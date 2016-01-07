class eclipse::install {
  
  Exec {
    path => [
	  '/usr/local/bin',
	  '/opt/local/bin',
	  '/usr/bin',
	  '/bin',
	  '/sbin'],
	logoutput => true,
	timeout => 0,
  }
  
  file {'/opt/eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz':
    source => 'puppet:///modules/eclipse/eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz',
	owner  => root,
	ensure => present,
  }  
  
  exec {'extract_eclipse':
	command => "tar xzvf /opt/eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz",
	user    => root,
	cwd     => '/opt',
	require => File['/opt/eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz'],
	before  => Exec['install_eclipse'],
  }

  file {'/opt/eclipse.desktop':
    ensure => present,
    source => 'puppet:///modules/eclipse/eclipse.desktop',
  } 

  exec {'install_eclipse':
    cwd     => '/opt/',
    command => 'desktop-file-install eclipse.desktop',
	user    => root,
    require => File['/opt/eclipse.desktop'],
	before  => Exec['symlink_eclipse'],
  }

  exec {'symlink_eclipse':
    command => 'ln -s /opt/eclipse/eclipse /usr/local/bin/eclipse44',
	user    => root,
	before  => Exec['icon_eclipse'],
  }
  
  exec {'icon_eclipse':
    command => 'cp /opt/eclipse/icon.xpm /usr/share/pixmaps/eclipse.xpm',
	user    => root,
	before  => Exec['chown_eclipse'],
  }
  
  exec {'chown_eclipse':
    command => 'chown -R $USER:$USER /opt/eclipse/configuration/org.eclipse.equinox.simpleconfigurator',
	user    => root,
  }

}