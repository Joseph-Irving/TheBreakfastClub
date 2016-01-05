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
  #ensure that wget is installed
    exec { 'downloadmysql'
    user    => root,
    cwd     => '/usr/local',
    command => 'wget http://repo.mysql.com/mysql57-community-release-el7-7.noarch.rpm',
	notify  =>Exec['runInstaller'],
  }
  
  exec { 'runInstaller'
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo rpm -ivh mysql57-community-release-el7-7.noarch.rpm',
	notify  =>Exec['installmysql'],
  }
  
  exec { 'installmysql'
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo yum install mysql-server || sudo /sbin/service mysqld start',
	#sudo systemctl start mysqld
	notify  =>Exec['installmariadb'],
  }
  
  exec { 'installmariadb'
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo yum install mariadb-server mariadb',
    notify  =>Exec['iptables'],
  }
  
  exec { 'iptables'
    user    => root,
    cwd     => '/usr/local',
    command => '-I INPUT -p tcp --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT || -I OUTPUT -p tcp --sport 3306 -m state --state ESTABLISHED -j ACCEPT',
    notify  =>Exec['mysqldstart'],
  }
  
  exec { 'mysqldstart'
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo /sbin/service mysqld start',
    notify  =>Exec['startmariadb'],
  }
  
  exec { 'startmariadb'
    user    => root,
    cwd     => '/usr/local',
    command => 'sudo systemctl start mariadb.service',
  }
}