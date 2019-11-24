# Dynatrace OneAgent module for puppet

## Description

This module installs the OneAgent on Linux, Windows and AIX Operating Systems

### Requirements

Requires [puppet/archive](https://forge.puppet.com/puppet/archive)

Requires OneAgent version version 1.177 or higher

## Installation

Available from GitHub (via cloning) or via Puppet forge [luisescobar/dynatraceoneagent](https://forge.puppet.com/luisescobar/dynatraceoneagent)

## Usage

Default parameters already defined in params.pp: 'INFRA_ONLY=0' 'APP_LOG_CONTENT_ACCESS=1'

    #Sample OneAgent installation using a Managed tenant with a set version on a linux host
    class { 'dynatraceoneagent':
        tenant_url  => 'https://{your-domain}/e/{your-environment-id}',
        paas_token  => '{{your-paas-token}',
        version        => '1.181.63.20191105-161318',
    }

    #Sample latest OneAgent version installation using a SAAS tenant on a windows host
    class { 'dynatraceoneagent':
        tenant_url  => 'https://{your-domain}/e/{your-environment-id}',
        paas_token  => '{{your-paas-token}',
    }

    #Additional Parameters should be defined as follows (will override default params):
    class { 'dynatraceoneagent':
        tenant_url  => 'https://{your-domain}/e/{your-environment-id}',
        paas_token  => '{{your-paas-token}',
        version        => '1.181.63.20191105-161318',
        oneagent_params_array => [ 'INFRA_ONLY=0', 'APP_LOG_CONTENT_ACCESS=1', 'HOST_GROUP=linux_servers' ]
    }
