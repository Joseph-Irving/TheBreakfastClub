class mysql::config{

include mysql::install

    exec { 'becomeroot':
		user    => root,
		cwd     => '/usr/local',
		command => 'mysql -u root',
		notify  => Exec['changepassword'],
		creates => '/opt/configs/mysql_pass',
		require => Service['mysqld'],
  }
  
    exec { 'changepassword':
		user    => root,
		cwd     => '/usr/local',
		command => "update user SET PASSWORD=PASSWORD('netbuilder') WHERE USER='root' || flush privileges || exit",
		notify  => Service['mysqld'],
		creates => '/opt/configs/mysql_pass',
  }
  
  file { '/opt/configs/mysql_pass': 
		ensure   => present,
		require => Service['mysqld'],
  }
}
