class graylog::install {
  
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
  
  exec {'graylog_rpm':
    command => 'rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-1.3-repository-el7_latest.rpm',
	user    => root,
	before  => Exec['install_graylog'],
  }
	
  exec {'install_graylog':
    command => 'yum install graylog-server graylog-web',
	user    => root,
	before  => Exec['set_secretgray'],
  }
  
   file {'/etc/graylog/web/graylog-web-interface.conf':
    ensure  => present,
	source  => 'puppet:///modules/graylog/graylog-web-interface.conf',
	owner   => root,
	require => Exec{'install_graylog'],
  }
  
   exec {'set_secretgray':
    command => "sed -i '11s/.*/password_secret = gfjftgdfsddhjfghcdgfrxzsdxszghfyudxstrh/' /etc/graylog/server/server.conf",
	user    => root,
	before  => Exec['setshapass_gray'],
  }
  
  exec {'setshapass_gray':
    command => "sed -i '22s/.*/root_password_sha2 = d003852b8e43f74fa8ee45ed72a2de32534ebac9478dced04e17f4b79442c487/' /etc/graylog/server/server.conf",
	user    => root,
	before  => Exec['start_grayserver']
  }
	
  exec {'start_grayserver':
    command => 'systemctl start graylog-server',
	user    => root,
	before  => Exec['start_greyweb'],
	require => File['/etc/graylog/web/graylog-web-interface.conf'],
  }
	
  exec {'start_greyweb':
    command => 'systemctl start graylog-web',
    user    => root,
    before  => Exec['run_greyweb'],
  }
  
  exec {'run_greyweb':
    command => './graylog-web-interface',
    cwd     => '/usr/share/graylog-web/bin/',
	user    => root,
  }
}