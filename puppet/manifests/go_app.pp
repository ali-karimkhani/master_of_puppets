exec { 'apt-get update':
  path => '/usr/bin',
}

package { 'vim':
  ensure => present,
}

file { '/home/app/':
  ensure => 'directory',
}

include golang
