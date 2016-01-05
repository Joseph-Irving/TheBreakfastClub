class artifactory::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'artifactory':
    ensure  => running,
    enable  => true,
    require => Class['java'],
  }

}
