class travis {
include ::travis::params


 file { '/etc/.travis.yml':
  owner   =>  'root',
  group   =>  'root',
  content =>  "language: $::travis::params::language \n sudo: $::travis::params::sudo",
  }
   }
  
