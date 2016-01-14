class graylog {

  class { 'java': } ->
  class { 'mongodb': } ->
  class { 'elasticsearch': } ->
  class { '::graylog::install': }


}