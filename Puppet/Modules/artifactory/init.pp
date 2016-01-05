class artifactory(
  
  $ensure           = 'latest',
  $ajp_port         = 8019,
  $data_path        = '/var/opt/jfrog/artifactory/data',
  $backup_path      = undef,

  ) {

  include ::java

  class { '::artifactory::install': } ->
  class { '::artifactory::config': } ->
  class { '::artifactory::service': }

}