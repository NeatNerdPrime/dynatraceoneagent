# Class: dynatraceoneagent::params
#
#
# Dynatrace OnaAgent default settings and according to operating system
#
class dynatraceoneagent::params {

    # OneAgent Download Parameters
    $tenant_url         = undef
    $paas_token         = undef
    $version            = 'latest'
    $arch               = 'all'
    $installer_type     = 'default'
    $reboot_system      = false

    if $::osfamily == 'Windows' {
        #Parameters for Windows OneAgent Download
        $os_type        = 'windows'
        $download_dir   = "C:\\Windows\\Temp\\"
        #Parameters for Windows OneAgent Installer
        $service_name   = 'Dynatrace OneAgent'
        $provider       = 'powershell'
        $check_service  = "if(Get-Service \"${service_name}\") { exit 0 } else { exit 1 }"
        $oneagent_params_array  = [ 'INFRA_ONLY=0', 'APP_LOG_CONTENT_ACCESS=1', '--quiet' ]
    } elsif $::osfamily == 'AIX' {
        #Parameters for AIX OneAgent Download
        $os_type        = 'aix'
        $download_dir   = '/tmp/'
        #Parameters for AIX OneAgent Installer
        $service_name   = 'oneagent'
        $provider       = 'shell'
        $check_service  = 'test -f /opt/dynatrace/oneagent/agent/agent.state'
        $oneagent_params_array  = [ 'INFRA_ONLY=0', 'APP_LOG_CONTENT_ACCESS=1' ]
    } elsif $::kernel == 'Linux' {
        #Parameters for Linux OneAgent Download
        $os_type        = 'unix'
        $download_dir   = '/tmp/'
        #Parameters for Linux OneAgent Installer
        $service_name   = 'oneagent'
        $provider       = 'shell'
        $check_service  = 'test -f /opt/dynatrace/oneagent/agent/agent.state'
        $oneagent_params_array  = [ 'INFRA_ONLY=0', 'APP_LOG_CONTENT_ACCESS=1' ]
    }
}
