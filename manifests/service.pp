# Class: dynatraceoneagent::service:  See README.md for documentation.
# ===========================
#
#
class dynatraceoneagent::service {

  $command               = $dynatraceoneagent::command
  $service_name          = $dynatraceoneagent::service_name
  $provider              = $dynatraceoneagent::provider
  $download_dir          = $dynatraceoneagent::download_dir
  $download_path         = $dynatraceoneagent::download_path
  $check_service         = $dynatraceoneagent::check_service
  $reboot_system         = $dynatraceoneagent::reboot_system
  $oneagent_params_array = $dynatraceoneagent::oneagent_params_array

  if ($reboot_system) and ($::kernel == 'Linux') or ($::osfamily  == 'AIX') {
    file{ $download_path:
    ensure => present,
    mode   => '0755',
    }
    exec { 'install_oneagent':
      command   => $command,
      cwd       => $download_dir,
      timeout   => 6000,
      unless    => $check_service,
      provider  => $provider,
      logoutput => true,
      notify    => Exec['reboot'],
    }
  }

  if (!$reboot_system) and ($::kernel == 'Linux') or ($::osfamily  == 'AIX') {
    file{ $download_path:
    ensure => present,
    mode   => '0755',
    }
    exec { 'install_oneagent':
      command   => $command,
      cwd       => $download_dir,
      timeout   => 6000,
      unless    => $check_service,
      provider  => $provider,
      logoutput => true,
    }
  }

if ($::osfamily == 'Windows'){
  package { $service_name:
    ensure          => present,
    #provider        => $provider,
    source          => $download_path,
    install_options => $oneagent_params_array,
  }
}

  service{ $service_name:
      ensure => running
  }

  if ($reboot_system) and ($::osfamily == 'Windows') {
    reboot { 'after':
      subscribe => Package[$service_name],
    }
  } elsif ($reboot_system) and ($::kernel == 'Linux') or ($::osfamily  == 'AIX') {
      exec { 'reboot':
        command     => '/sbin/reboot',
        refreshonly => true,
    }
  } else {
    notify { 'Not rebooting': }
  }

}
