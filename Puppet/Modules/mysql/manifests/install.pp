class mysql::install{

    Exec {
		timeout => 0,
		path => [
	  '/usr/local/bin',
	  '/opt/local/bin',
	  '/usr/bin',
	  '/bin',
	  '/sbin'],
	logoutput => true,
  }
  
    package { 'wget':
		ensure    => installed,
		notify    => Exec['downloadmysql'],
  }

    package { 'mysql-server':
      ensure => present,
      require => Exec['update'],
    }
  
    exec { 'downloadmysql':
		user    => root,
		cwd     => '/usr/local',
		command => 'wget http://repo.mysql.com/mysql57-community-release-el7-7.noarch.rpm',
		notify  => Exec['runInstaller'],
	
		#unless  => "test -f /usr/local/mysql57-community-release-el7-7",
		creates  => "/usr/local/mysql57-community-release-el7-7",
		#onlyif  => "test ! -f /usr/local/mysql57-community-release-el7-7",
  }
  
    exec { 'runInstaller':
		user     => root,
		cwd      => '/usr/local',
		command  => 'rpm -ivh mysql57-community-release-el7-7.noarch.rpm',
		notify   => Exec['update'],
		creates  => "/usr/lib64/mysql/libmysqlclient.so.18",
  }
  
    exec { 'update':
		user    => root,
		cwd     => '/usr/local',
		command => 'yum -y update',
		notify  => Package['mysql-server'],
  }
  
    exec { 'openTCPport':
		user    => root,
		cwd     => '/usr/local',
		command => 'iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT',
		notify  => Service['mysqld'],
  }

    service { 'mysqld':
		ensure => running,
		enable => true,
  }

}
