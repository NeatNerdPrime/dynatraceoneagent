# Dynatrace OneAgent module for puppet

## Description

This module installs the OneAgent on Linux, Windows and AIX Operating Systems

### Requirements

Requires [puppet/archive](https://forge.puppet.com/puppet/archive)
Requires OneAgent version version 1.177 or higher

## Installation

Available from GitHub (via cloning)

## Usage

    #Sample OneAgent installation using a Managed tenant with a set version on a linux host
    class { 'dynatraceoneagent':
        tenant_url  => 'https://{your-domain}/e/{your-environment-id}',
        paas_token  => '{{your-paas-token}',
        version     => 'latest',
        host_group  => 'linux_servers',
        proxy       => 'no_proxy',
    }

    #Sample latest OneAgent version installation using a SAAS on a windows host
    class { 'dynatraceoneagent':
        tenant_url  => 'https://[your-environment-id}].live.dynatrace.com',
        paas_token  => '{your-paas-token}',
        host_group  => 'windows_servers',
    }