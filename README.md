[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/73/badge)](https://bestpractices.coreinfrastructure.org/projects/73)
[![Puppet Forge](https://img.shields.io/puppetforge/v/simp/rkhunter.svg)](https://forge.puppetlabs.com/simp/rkhunter)
[![Puppet Forge Downloads](https://img.shields.io/puppetforge/dt/simp/rkhunter.svg)](https://forge.puppetlabs.com/simp/rkhunter)
[![Build Status](https://travis-ci.org/simp/pupmod-simp-rkhunter.svg)](https://travis-ci.org/simp/pupmod-simp-rkhunter)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with rkhunter](#setup)
    * [What rkhunter affects](#what-rkhunter-affects)
    * [Beginning with rkhunter](#beginning-with-rkhunter)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
    * [Acceptance Tests - Beaker env variables](#acceptance-tests)


## Description

A SIMP Puppet module for managing rkhunter, a daemon that checks for rootkits
on a Linux system.


### This is a SIMP module

This module is a component of the [System Integrity Management Platform](https://simp-project.com),
a compliance-management framework built on Puppet.

If you find any issues, they may be submitted to our [bug
tracker](https://simp-project.atlassian.net/).

This module is optimally designed for use within a larger SIMP ecosystem, but
it can be used independently:

 * When included within the SIMP ecosystem, security compliance settings will
   be managed from the Puppet server.


## Setup


### What rkhunter affects

This module configures:
  * rkhunter package
  * unhide package
  * rkhunter cron jobs

Some tests require single-purpose tools, if rkhunter has them then it will use
them. Unhide is one such tool.

### Beginning with rkhunter

To use this module with it's default settings, just instantiate it. The
following example is in hiera:

  ```yaml
  ---
  classes:
    - rkhunter

  ```


## Usage

The class will install the packages and crob jobs automatically.

The output of the cron jobs will be sent to the default cron mechanism.


## Reference

Please refer to the inline documentation within each source file, or to the
module's generated YARD documentation for reference material.


## Limitations

SIMP Puppet modules are generally intended for use on Red Hat Enterprise Linux
and compatible distributions, such as CentOS. Please see the [`metadata.json`
file](./metadata.json) for the most up-to-date list of supported operating
systems, Puppet versions, and module dependencies.


## Development

Please read our [Contribution Guide] (https://simp.readthedocs.io/en/stable/contributors_guide/index.html)


### Acceptance tests

This module includes [Beaker](https://github.com/puppetlabs/beaker) acceptance
tests using the SIMP [Beaker Helpers](https://github.com/simp/rubygem-simp-beaker-helpers).
By default the tests use [Vagrant](https://www.vagrantup.com/) with
[VirtualBox](https://www.virtualbox.org) as a back-end; Vagrant and VirtualBox
must both be installed to run these tests without modification. To execute the
tests run the following:

```shell
bundle install
bundle exec rake beaker:suites
```

Please refer to the [SIMP Beaker Helpers documentation](https://github.com/simp/rubygem-simp-beaker-helpers/blob/master/README.md) for more information.
