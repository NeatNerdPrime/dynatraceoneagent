# Class: dynatraceoneagent  See README.md for documentation.
# ============================================
#
# This module installs the dynatrace one agent on the host.
# Requires oneagent version version 1.177 or higher
# Currently supported for Linux, AIX and Windows Operating Systems
#
#   Parameters for the OneAgent Download:
#
#   * $tenant_url                 => URL of your dynatrace Tenant - Managed https://{your-domain}/e/{your-environment-id}, SaaS 
#                                    https://{your-environment-id}.live.dynatrace.com
#   * $paas_token                 => PAAS token for downloading one agent installer
#   * $version                    => The required version of the OneAgent in 1.155.275.20181112-084458 format. Default is latest and will 
#                                     default to most recent version
#   * $arch                       => The architecture of your OS - default is all
#   * $installer_type             => The type of the installer - default is default
#
#   Parameters for the OneAgent Installer:
#
#   * $root_drive                 => For Windows only, specify the drive in which to install the oneagent. - default is C:
#   * $host_group                 => The name of a group you want to assign the host to. The host group string can only contain 
#                                    alphanumeric characters, hyphens, underscores, and periods. It must not start with dt. and the 
#                                    maximum length is 100 characters.
#   * $proxy                      => The address of the proxy server. Use the IP address or a name. Add the port number following a colon, 
#                                    for example PROXY=172.1.1.128:8080. We also support IPv6 
#                                    addresses. To let the installer automatically detect proxy details, use PROXY=auto. default is auto
#   * $app_log_content_access     => Windows and Linux only - When set to true, allows Dynatrace OneAgent to access log files for the 
#                                    purpose of log monitoring. 
#                                    Accepted values are (true, false) or (1, 0) - default is 0
#   * $infra_only                 => Activates cloud infrastructure monitoring mode, in place of full-stack monitoring mode. With this 
#                                    approach, you receive infrastructure-only health data, with no application or user performance data. 
#                                    Accepted values are 0 (deactivated) and 1 (activated) - default is 0

class dynatraceoneagent (

# OneAgent Download Parameters
  $tenant_url                      = undef,
  $paas_token                      = undef,
  String $version                  = 'latest',
  String $arch                     = 'all',
  String $installer_type           = 'default',
  String $os_type                  = $dynatraceoneagent::params::os_type,

#OneAgent Install Parameters
  String $root_drive               = 'C:',
  Optional[String] $host_group     = undef,
  Optional[String] $proxy          = undef,
  String $infra_only               = '0',
  String $app_log_content_access   = '1',
  String $service_name             = $dynatraceoneagent::params::service_name,
  String $provider                 = $dynatraceoneagent::params::provider,

) inherits dynatraceoneagent::params {

    if $version == 'latest' {
      $download_link  = "${tenant_url}/api/v1/deployment/installer/agent/${os_type}/${installer_type}/latest/?Api-Token=${paas_token}&flavor=default&arch=${arch}"
    } else {
      $download_link  = "${tenant_url}/api/v1/deployment/installer/agent/${os_type}/${installer_type}/version/${version}?Api-Token=${paas_token}&flavor=default&arch=${arch}"
    }

    if $::osfamily == 'Windows' {
      $download_dir   = "${root_drive}\\Windows\\Temp\\"
      $install_dir    = "${root_drive}\\Program Files (x86)\\dynatrace\\oneagent\\"
      $created_dir    = "${install_dir}agent\\agent.state"
      $filename       = "Dynatrace-OneAgent-${::osfamily}-${version}.exe"
      $download_path  = "${download_dir}${filename}"
      $command        = "cmd.exe /c ${download_path} HOST_GROUP=${host_group} PROXY=${proxy} INFRA_ONLY=${infra_only} APP_LOG_CONTENT_ACCESS=${app_log_content_access} --quiet"
    } elsif $::osfamily == 'AIX' {
      $download_dir   = '/tmp/'
      $install_dir    = '/opt/dynatrace/oneagent/'
      $created_dir    = "${install_dir}agent/agent.state"
      $filename       = "Dynatrace-OneAgent-${::osfamily}-${version}.sh"
      $download_path  = "${download_dir}${filename}"
      $command        = "/bin/sh ${download_path} HOST_GROUP=${host_group} PROXY=${proxy} INFRA_ONLY=${infra_only}"
    } elsif $::kernel == 'linux'  {
      $download_dir   = '/tmp/'
      $install_dir    = '/opt/dynatrace/oneagent/'
      $created_dir    = "${install_dir}agent/agent.state"
      $filename       = "Dynatrace-OneAgent-${::kernel}-${version}.sh"
      $download_path  = "${download_dir}${filename}"
      $command        = "/bin/sh ${download_path} HOST_GROUP=${host_group} PROXY=${proxy} INFRA_ONLY=${infra_only} APP_LOG_CONTENT_ACCESS=${app_log_content_access}"
    }

  contain dynatraceoneagent::install
  contain dynatraceoneagent::service

  Class['::dynatraceoneagent::install']
  ~> Class['::dynatraceoneagent::service']
}
