class nginx {

	# Symlink guest /home/app to host /vagrant
	file { '/home/app':
	  ensure  => 'link',
	  target  => '/vagrant/app',
	}

	package { 'nginx':
	  ensure => 'present',
	  require => Exec['apt-get update'],
	}

	service { 'nginx':
	  ensure => running,
	  require => Package['nginx'],
	}

	# Disable default nginx vhost
	file { 'default-nginx-disable':
	    path => '/etc/nginx/sites-enabled/default',
	    ensure => absent,
	    require => Package['nginx'],
	}

  # Add nginx config
	file { 'nginx-config':
	    path => '/etc/nginx/nginx.conf',
	    ensure => file,
	    source => 'puppet:///modules/nginx/nginx.conf',
      notify => Service['nginx'],
      require => [
          File['default-nginx-disable'],
          Package['nginx'],
      ],
	}

}
