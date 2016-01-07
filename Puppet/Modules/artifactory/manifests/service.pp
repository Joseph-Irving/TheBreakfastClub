class artifactory::service {

  service { 'artifactory':
    ensure  => running,
    enable  => true,
    require => Class['java'],
  }

}
