class java {
 
  case $operatingsystem {
    'Ubuntu': { 
       package {'default-jdk':
        ensure => present,
        before => Package['default-jre'],
       }

       package {'default-jre':
         ensure => present,
       }
    }
    'CentOS': {
     package {'java-1.7.0-openjdk':
       ensure => present,
     }
    }
  }  
}
