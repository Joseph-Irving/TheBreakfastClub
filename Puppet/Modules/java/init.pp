class java {

  package {'default-jdk':
    ensure => present,
	before => Package['default-jre']
  }

  package {'default-jre':
    ensure => present,
  }

}  