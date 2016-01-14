class graylog::install {
  
  exec {'graylog_rpm':
    command => 'rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-1.3-repository-el7_latest.rpm',
	user    => root,
	before  => Exec['install_graylog'],
  }
	
  exec {'install_graylog':
    command => 'yum install graylog-server graylog-web',
	user    => root,
	before  => Exec['start_grayserver'],
  }
	
  exec {'start_grayserver':
    command => 'systemctl start graylog-server',
	user    => root,
	before  => Exec['start_greyweb']
  }
	
  exec {'start_greyweb':
    command => 'systemctl start graylog-web',
    user    => root,
    before  => 
  }

  exec {'set_secretgray':
    command => "sed -i '11s/.*/password_secret = gfjftgdfsddhjfghcdgfrxzsdxszghfyudxstrh/' /etc/graylog/server/server.conf",
	user    => root,
  }
	
  exec {'setshapass_gray':
    command => "sed -i '22s/.*/root_password_sha2 = d003852b8e43f74fa8ee45ed72a2de32534ebac9478dced04e17f4b79442c487/' /etc/graylog/server/server.conf",
	user    => root,
  }
  
  file {'/etc/graylog/web/graylog-web-interface.conf':

}