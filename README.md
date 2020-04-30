Team and repository tags
========================

[![Team and repository tags](https://governance.openstack.org/tc/badges/puppet-congress.svg)](https://governance.openstack.org/tc/reference/tags/index.html)

<!-- Change things from this point on -->

congress
=======

#### Table of Contents

1. [Overview - What is the congress module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with congress](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Beaker-Rspec - Beaker-rspec tests for the project](#beaker-rspec)
7. [Development - Guide for contributing to the module](#development)
8. [Contributors - Those with commits](#contributors)

Overview
--------

The congress module is a part of [OpenStack](https://opendev.org/openstack), an effort by the OpenStack infrastructure team to provide continuous integration testing and code review for OpenStack and OpenStack community projects not part of the core software.  The module its self is used to flexibly configure and manage the policy service for OpenStack.

Module Description
------------------

The congress module is a thorough attempt to make Puppet capable of managing the entirety of congress.  This includes manifests to provision region specific endpoint and database connections.  Types are shipped as part of the congress module to assist in manipulation of configuration files.

Setup
-----

**What the congress module affects**

* [Congress](https://docs.openstack.org/congress/latest/), the policy service for OpenStack.

### Installing congress

    congress is not currently in Puppet Forge, but is anticipated to be added soon.  Once that happens, you'll be able to install congress with:
    puppet module install openstack/congress

### Beginning with congress

To utilize the congress module's functionality you will need to declare multiple resources.

Implementation
--------------

### congress

congress is a combination of Puppet manifest and ruby code to delivery configuration and extra functionality through types and providers.

Limitations
------------

* All the congress types use the CLI tools and so need to be ran on the congress node.

Beaker-Rspec
------------

This module has beaker-rspec tests

To run the tests on the default vagrant node:

```shell
bundle install
bundle exec rake acceptance
```

For more information on writing and running beaker-rspec tests visit the documentation:

* https://github.com/puppetlabs/beaker-rspec/blob/master/README.md

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://docs.openstack.org/puppet-openstack-guide/latest/

Contributors
------------

* https://github.com/openstack/puppet-congress/graphs/contributors

Release Notes
-------------

* https://docs.openstack.org/releasenotes/puppet-congress

Repository
----------

* https://opendev.org/openstack/puppet-congress


