class artifactory::config {

  file { '/opt/jfrog/artifactory/tomcat/conf/server.xml':
    ensure  => file,
    owner   => artifactory,
    group   => artifactory,
    mode    => '0444',
   #content => template('artifactory/server.xml.erb'),
    notify  => Class['artifactory::service'],
  }

}
