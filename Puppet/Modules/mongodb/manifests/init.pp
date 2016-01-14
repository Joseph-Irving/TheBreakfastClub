class mongodb {
   
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
  
  file {'/etc/yum.repos.d/mongodb.repo':
    ensure => present,
	source => 'puppet:///modules/mongodb/mongodb.repo',
	owner  => root,
  }
  
  exec {'install_mongodb':
    command => 'yum install -y mongodb-org',
	require => File['/etc/yum.repos.d/mongodb.repo'],
	user    => root,
	before  => Exec['restart_mongod'],
  }
  
  exec {'restart_mongod':
    command => '/etc/init.d/mongod restart',
	user    => root,
	before  => Exec['auto_mongod'],
  }
  
  exec {'auto_mongod':
    command => 'chkconfig mongod on',
	user    => root,
  }

}