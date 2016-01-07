define artifactory::fetch_artifact (
  $project,
  $version,
  $install_path,
  $format,
  $path        = undef,
  $server      = 'http://artifactory',
  $repo        = 'libs-release-local',
  $filename    = undef,
  $source_file = undef,
  ){

  if $source_file {
    $sourcefile_real = $source_file
  } else {
    $sourcefile_real = "${project}-${version}.${format}"
  }

  if $filename {
    $filename_real = $filename
  } else {
    $filename_real = "${project}-${version}.${format}"
  }

  if ( $path ) {
    $fetch_url = "${server}/artifactory/${repo}/${path}/${project}/${version}/${sourcefile_real}"
  } else {
    $fetch_url = "${server}/artifactory/${repo}/${project}/${version}/${sourcefile_real}"
  }

  $full_path = "${install_path}/${filename_real}"

  exec { "artifactory_fetch_${name}":
    command   => "curl -o ${full_path} ${fetch_url}",
    cwd       => $install_path,
    creates   => $full_path,
    path      => '/usr/bin:/bin',
    logoutput => on_failure;
  }
}
