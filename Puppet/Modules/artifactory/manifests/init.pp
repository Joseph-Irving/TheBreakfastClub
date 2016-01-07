class artifactory {

  class { 'java': } ->
  class { '::artifactory::install': } ->
  class { '::artifactory::config': } ->
  class { '::artifactory::service': }

}
