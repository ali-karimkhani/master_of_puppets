class golang (
  $version      = '1.5.3',
  $workspace    = '/home/go_app',
  $arch         = 'linux-amd64',
  $download_dir = '/home/go_app/src',
  $download_url = undef,
  $download_timeout = 900,
) {

  file { '/etc/profile.d/golang.sh':
    content => template('golang/golang.sh.erb'),
    owner   => root,
    group   => root,
    mode    => 'a+x',
  }

  if ($download_url) {
    $download_location = $download_url
  } else {
    $download_location = "https://storage.googleapis.com/golang/go${version}.${arch}.tar.gz"
  }

  Exec {
    path => '/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin',
  }

  if ! defined(Package['curl']) {
    package { 'curl': }
  }

  if ! defined(Package['mercurial']) {
    package { 'mercurial': }
  }

  exec { 'download':
    command => "curl -o ${download_dir}/go-${version}.tar.gz ${download_location}",
    creates => "${download_dir}/go-${version}.tar.gz",
    unless  => "which go && go version | grep '${version}'",
    require => Package['curl'],
    timeout => $download_timeout,
  } ->
  exec { 'unarchive':
    command => "tar -C /usr/local -xzf ${download_dir}/go-${version}.tar.gz && rm ${download_dir}/go-${version}.tar.gz",
    onlyif  => "test -f ${download_dir}/go-${version}.tar.gz",
  }

  exec { 'remove-previous':
    command => 'rm -r /usr/local/go',
    onlyif  => [
      'test -d /usr/local/go',
      "which go && test `go version | cut -d' ' -f 3` != 'go${version}'",
    ],
    before  => Exec['unarchive'],
  }

  file { '/home/go_app/bin':
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0755',
  }

}
