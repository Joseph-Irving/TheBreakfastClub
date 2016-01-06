class mysql{
  Exec {
    path => [
	  '/usr/local/bin',
	  '/opt/local/bin',
	  '/usr/bin',
	  '/bin',
	  '/sbin'],
	logoutput => true,
  }
  
   exec { 'downloadwget':
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo yum -y install wget',
	notify  =>Exec['downloadmysql'],
  }
  
    exec { 'downloadmysql':
    user    => root,
    cwd     => '/usr/local',
    command => 'wget http://repo.mysql.com/mysql57-community-release-el7-7.noarch.rpm',
	notify  =>Exec['runInstaller'],
  }
  
  exec { 'runInstaller':
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo rpm -ivh mysql57-community-release-el7-7.noarch.rpm',
	notify  =>Exec['installmysql'],
  }
  
  exec { 'installmysql':
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo yum install mysql-server || sudo /sbin/service mysqld start',
	#sudo systemctl start mysqld
	notify  =>Exec['installmariadb'],
  }
  
  exec { 'installmariadb':
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo yum install mariadb-server mariadb',
    notify  =>Exec['openTCPport'],
  }
  
  exec { 'openTCPport':
    user    => root,
    cwd     => '/usr/local',
    command => 'iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT',
    notify  =>Exec['mysqldstart'],
  }
  
  exec { 'mysqldstart':
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo /sbin/service mysqld start',
    notify  =>Exec['startmariadb'],
  }
  
  exec { 'startmariadb':
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo systemctl start mariadb.service',
  }
}