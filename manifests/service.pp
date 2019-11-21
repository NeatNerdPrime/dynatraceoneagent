# Class: dynatraceoneagent::service:  See README.md for documentation.
# ===========================
#
#
class dynatraceoneagent::service {

  $command       = $dynatraceoneagent::command
  $created_dir   = $dynatraceoneagent::created_dir
  $service_name  = $dynatraceoneagent::service_name
  $provider      = $dynatraceoneagent::provider
  $download_dir  = $dynatraceoneagent::download_dir
  $download_path = $dynatraceoneagent::download_path

  if ($::kernel == 'Linux') or ($::osfamily  == 'AIX') {
    file{ $download_path:
    ensure => present,
    mode   => '0755',
    }
  }

  exec { 'install_oneagent':
      command   => $command,
      cwd       => $download_dir,
      timeout   => 6000,
      creates   => $created_dir,
      provider  => $provider,
      logoutput => true,
  }

  service{ $service_name:
      ensure => running
  }
}