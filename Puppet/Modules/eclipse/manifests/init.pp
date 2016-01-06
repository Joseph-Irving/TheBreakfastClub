class eclipse {
  
  Exec {
    path => [
	  '/usr/local/bin',
	  '/opt/local/bin',
	  '/usr/bin',
	  '/bin',
	  '/sbin'],
	logoutput => true,
	timeout => 0,
  }
  
  exec {'download_eclipse':
    command => 'wget https://eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/1/eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz&mirror_id=17',
	before => Exec['extract_eclipse'],
  }
  
  exec {'extract_eclipse':
    command =>

}