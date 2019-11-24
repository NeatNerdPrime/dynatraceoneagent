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

    #OneAgent Install Parameters
    $param_1  = 'INFRA_ONLY=0'
    $param_2  = 'APP_LOG_CONTENT_ACCESS=1'
    $param_3  = undef
    $param_4  = undef
    $param_5  = undef
    $param_6  = undef
    $param_7  = undef
    $param_8  = undef
    $param_9  = undef
    $param_10 = undef

    if $::osfamily == 'Windows' {
        #Parameters for Windows OneAgent Download
        $os_type        = 'windows'
        $download_dir   = "C:\\Windows\\Temp\\"
        #Parameters for Windows OneAgent Installer
        $install_dir    = "C:\\Program Files (x86)\\dynatrace\\oneagent\\"
        $service_name   = 'Dynatrace OneAgent'
        $provider       = 'powershell'
    } elsif $::osfamily == 'AIX' {
        #Parameters for AIX OneAgent Download
        $os_type        = 'aix'
        $download_dir   = '/tmp/'
        #Parameters for AIX OneAgent Installer
        $install_dir    = '/opt/dynatrace/oneagent/'
        $service_name   = 'oneagent'
        $provider       = 'shell'
    } elsif $::kernel == 'Linux' {
        #Parameters for Linux OneAgent Download
        $os_type        = 'unix'
        $download_dir   = '/tmp/'
        #Parameters for Linux OneAgent Installer
        $install_dir    = '/opt/dynatrace/oneagent/'
        $service_name   = 'oneagent'
        $provider       = 'shell'
    }
}
