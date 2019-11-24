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
#   * download_dir                => OneAgent installer file download directory   
#
#   Up to 10 parameters can be added
#   Default parameters already defined (can be overriden):
#
#    * $param_1                  => INFRA_ONLY=0
#    * $param_2                  => APP_LOG_CONTENT_ACCESS=1
#   Refer to the Customize OneAgent installation documentation on https://www.dynatrace.com/support/help/technology-support/operating-systems/

class dynatraceoneagent (

# OneAgent Download Parameters
  $tenant_url                      = $dynatraceoneagent::params::tenant_url,
  $paas_token                      = $dynatraceoneagent::params::paas_token,
  String $version                  = $dynatraceoneagent::params::version,
  String $arch                     = $dynatraceoneagent::params::arch,
  String $installer_type           = $dynatraceoneagent::params::installer_type,
  String $os_type                  = $dynatraceoneagent::params::os_type,

#OneAgent Install Parameters
  String $download_dir             = $dynatraceoneagent::params::download_dir,
  String $service_name             = $dynatraceoneagent::params::service_name,
  String $provider                 = $dynatraceoneagent::params::provider,
  String $check_service            = $dynatraceoneagent::params::check_service,
  Optional[String] $param_1        = $dynatraceoneagent::params::param_1,
  Optional[String] $param_2        = $dynatraceoneagent::params::param_2,
  Optional[String] $param_3        = $dynatraceoneagent::params::param_3,
  Optional[String] $param_4        = $dynatraceoneagent::params::param_4,
  Optional[String] $param_5        = $dynatraceoneagent::params::param_5,
  Optional[String] $param_6        = $dynatraceoneagent::params::param_6,
  Optional[String] $param_7        = $dynatraceoneagent::params::param_7,
  Optional[String] $param_8        = $dynatraceoneagent::params::param_8,
  Optional[String] $param_9        = $dynatraceoneagent::params::param_9,
  Optional[String] $param_10       = $dynatraceoneagent::params::param_10,

) inherits dynatraceoneagent::params {

    if $version == 'latest' {
      $download_link  = "${tenant_url}/api/v1/deployment/installer/agent/${os_type}/${installer_type}/latest/?Api-Token=${paas_token}&flavor=default&arch=${arch}"
    } else {
      $download_link  = "${tenant_url}/api/v1/deployment/installer/agent/${os_type}/${installer_type}/version/${version}?Api-Token=${paas_token}&flavor=default&arch=${arch}"
    }

    if $::osfamily == 'Windows' {
      $filename       = "Dynatrace-OneAgent-${::osfamily}-${version}.exe"
      $download_path  = "${download_dir}${filename}"
      $command        = "cmd.exe /c ${download_path} ${param_1} ${param_2} ${param_3} ${param_4} ${param_5} ${param_6} ${param_7} ${param_8} ${param_9} ${param_10} --quiet"
    } elsif $::osfamily == 'AIX' {
      $filename       = "Dynatrace-OneAgent-${::osfamily}-${version}.sh"
      $download_path  = "${download_dir}${filename}"
      $command        = "/bin/sh ${download_path} ${param_1} ${param_2} ${param_3} ${param_4} ${param_5} ${param_6} ${param_7} ${param_8} ${param_9} ${param_10}"
    } elsif $::kernel == 'linux'  {
      $filename       = "Dynatrace-OneAgent-${::kernel}-${version}.sh"
      $download_path  = "${download_dir}${filename}"
      $command        = "/bin/sh ${download_path} ${param_1} ${param_2} ${param_3} ${param_4} ${param_5} ${param_6} ${param_7} ${param_8} ${param_9} ${param_10}"
    }

  contain dynatraceoneagent::install
  contain dynatraceoneagent::service

  Class['::dynatraceoneagent::install']
  ~> Class['::dynatraceoneagent::service']
}
