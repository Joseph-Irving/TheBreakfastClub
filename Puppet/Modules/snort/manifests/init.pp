class snort {
exec  { 'install':
  command   => "yum install -y https://www.snort.org/downloads/snort/daq-2.0.6-1.centos7.x86_64.rpm",

}
}
