class elasticsearch {

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
  
  exec {'elastikey':
    command => 'rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch',
	user    => root,
	before  => Exec['install_elastic'],
  }
  
  file {'/etc/yum.repos.d/elasticsearch.repo':
    ensure => present,
	source => 'puppet:///modules/elasticsearch/elasticsearch.repo',
	owner  => root,
  }
  
  exec {'install_elastic':
    command => 'yum -y install elasticsearch',
	user    => root,
	require => File['/etc/yum.repos.d/elasticsearch.repo'],
	before  => Exec['config_elastic'],
  }
  
  exec {'config_elastic':
    command => "sed -i '54s/.*/network.host: localhost/' /etc/yum.repos.d/elasticsearch.repo",
	user    => root,
	before  => Exec['start_elastic'],
  }	
  
  exec {'start_elastic':
    command => 'systemctl start elasticsearch',
	user    => root,
	before  => Exec['enable_elastic'],
  }
  
  exec {'enable_elastic':
    command => 'systemctl enable elasticsearch',
	user    => root,
  }
  
}