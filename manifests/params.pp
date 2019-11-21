# Class: dynatraceoneagent::params
#
#
# Dynatrace OnaAgent default settings and according to operating system
#
class dynatraceoneagent::params {

    if $::kernel == 'Linux' {
        #Parameters for Linux OneAgent Download
        $os_type        = 'unix'
        #Parameters for Linux OneAgent Installer
        $service_name   = 'oneagent'
        $provider       = 'shell'
    }

    case $::osfamily {
        'Windows' : {
          #Parameters for Windows OneAgent Download
            $os_type        = 'windows'
            #Parameters for Windows OneAgent Installer
            $service_name   = 'Dynatrace OneAgent'
            $provider       = 'powershell'
        }

        'AIX': {
        #Parameters for AIX OneAgent Download
        $os_type        = 'aix'
        #Parameters for AIX OneAgent Installer
        $service_name   = 'oneagent'
        $provider       = 'shell'
        }
        default: {
        }
    }
}
