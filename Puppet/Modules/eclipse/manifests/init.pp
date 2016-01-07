class eclipse {

  class { 'java': } ->
  class { '::eclipse::install': }
  
}