class editor{

        exec { 'update':
                command => 'sudo apt-get update',
                path => '/bin:/usr/bin:/sbin:/usr/sbin:',
	}

	package {'apache2':
		ensure => 'installed',
		require => Exec['update'],
	}

	file {'/etc/apache2/sites-available/homepagecom.conf':
		content => template('editor/homepagecom.conf.erb'),
		require => Package['apache2'],
	}

	file {'/etc/hosts':
		content => template('editor/hosts.erb'),
	}

	package { 'libapache2-mod-php':
		ensure => 'installed',
		require => Package['apache2'],
		notify => Service['apache2'],	
	}	

	file { '/etc/apache2/mods-available/php7.0.conf':
		content => template('editor/php7.0.conf.erb'),
		require => Package['apache2'],
		notify => Service['apache2'],
	}

	exec { 'a2enmod':
		command => 'sudo a2enmod userdir',
		path => '/bin:/usr/bin:/sbin:/usr/sbin:',
		require => Package['apache2'],
		notify => Service['apache2'],
	}


	file { '/etc/apache2/sites-enabled/homepagecom.conf':
		ensure => link,
		target => '/etc/apache2/sites-available/homepagecom.conf',
		require => Package['apache2'],
		notify => Service['apache2'],	
	}

	service {'apache2':
		ensure => true,
		enable => true,
		require => Package['apache2'],
	}

	user { 'editor':
		ensure => 'present',		
		password => 'jAwQ639FgEpas',
		managehome => true,
		home => '/home/editor',
	}


	file { '/home/editor/public_html/':
		ensure => 'directory',
		owner => 'editor',
		require => User['editor'],
	}

	file { '/home/editor/public_html/index.php':
		content => template('editor/index.php.erb'),
		owner => 'editor',
		require => File['/home/editor/public_html/'],
	}

        package { 'gimp':
                ensure => 'installed',
		require => Exec['update'],
	}

	package { 'kdenlive':
		ensure => 'installed',
		require => Exec['update'],
	}

}
