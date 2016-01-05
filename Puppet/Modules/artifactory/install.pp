class artifactory::install {

  #if $caller_module_name != $module_name {
  #  fail("Use of private class ${name} by ${caller_module_name}")
  #}

  File {
    require => Package['artifactory'],
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

  package { 'artifactory':
    ensure   => latest,
    require  => [ User['artifactory'], Group['artifactory'] ],
    notify   => Class['artifactory::service'],
  }

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
