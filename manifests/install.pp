# Class: dynatraceoneagent::install:  See README.md for documentation.
# ===========================
#
#
class dynatraceoneagent::install {

  class { 'archive':
    seven_zip_provider => '',
  }

  $download_dir   = $dynatraceoneagent::download_dir
  $filename       = $dynatraceoneagent::filename
  $download_path  = $dynatraceoneagent::download_path
  $download_link  = $dynatraceoneagent::download_link

  file{ $download_dir:
    ensure => directory
  }

  archive{ $download_path:
    ensure  => present,
    extract => false,
    source  => $download_link,
    path    => $download_path,
  }

}
