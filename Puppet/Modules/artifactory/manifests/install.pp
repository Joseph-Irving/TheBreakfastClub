class artifactory::install {
 
  Exec {
    path => '/usr/bin/',
  }
  

  user { 'artifactory':
    ensure => 'present',
    system => true,
    shell  => '/bin/bash',
    home   => '/var/opt/jfrog/artifactory',
    gid    => 'artifactory',
  }

  group { 'artifactory':
    ensure => 'present',
    system => true,
  }

  file {'/usr/jfrog-artifactory-oss-4.4.0.rpm':
    ensure => present,
    source => 'puppet:///modules/artifactory/jfrog-artifactory-oss-4.4.0.rpm',
    owner  => root,
  }

  exec {'local_install_artifactory':
    require => File['/usr/jfrog-artifactory-oss-4.4.0.rpm'],
    cwd     => '/usr/',
    command => "yum localinstall -y jfrog-artifactory-oss-4.4.0.rpm",
    user    => root,
  }


 # package { 'jfrog-artifactory-oss-4.4.0.rpm':
 #   ensure   => installed,
 #   require  => [ User['artifactory'], Group['artifactory'] ],
 #   notify   => Class['artifactory::service'],
 # }

  #if $::artifactory::data_path != '/var/opt/jfrog/artifactory/data' {
  #  file { $::artifactory::data_path:
  #    ensure => directory,
  #    mode   => '0775',
  #    owner  => artifactory,
  #    group  => artifactory,
  #  }

  #  file { '/var/opt/jfrog/artifactory/data':
  #    ensure => link,
  #    target => $::artifactory::data_path,
  #  }
  #}

}
