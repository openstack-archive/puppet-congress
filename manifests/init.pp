# == Class: congress
#
# Module for managing congress config
#
# === Parameters
#
# [*keystone_password*]
#   (required) Password used to authentication.
#
# [*package_ensure*]
#   (optional) Desired ensure state of packages.
#   accepts latest or specific versions.
#   Defaults to present.
#
# [*client_package_ensure*]
#   (optional) Desired ensure state of the client package.
#   accepts latest or specific versions.
#   Defaults to present.
#
# [*bind_host*]
#   (optional) The IP address that congress binds to.
#   Default to '0.0.0.0'.
#
# [*bind_port*]
#   (optional) Port that congress binds to.
#   Defaults to '1789'
#
# [*verbose*]
#   (optional) Rather congress should log at verbose level.
#   Defaults to undef.
#
# [*debug*]
#   (optional) Rather congress should log at debug level.
#   Defaults to undef.
#
# [*auth_type*]
#   (optional) Type is authorization being used.
#   Defaults to 'keystone'
#
# [*auth_uri*]
#   (optional) Complete public Identity API endpoint.
#   Defaults to false.
#
# [*identity_uri*]
#   (optional) Complete admin Identity API endpoint.
#   Defaults to: false
#
# [*keystone_tenant*]
#   (optional) Tenant to authenticate to.
#   Defaults to services.
#
# [*keystone_user*]
#   (optional) User to authenticate as with keystone.
#   Defaults to 'congress'.
#
# [*manage_service*]
#   (Optional) If Puppet should manage service startup / shutdown.
#   Defaults to true.
#
# [*enabled*]
#  (optional) If the congress services should be enabled.
#   Default to true.
#
# [*database_connection*]
#   (optional) Url used to connect to database.
#   Defaults to undef.
#
# [*database_idle_timeout*]
#   (optional) Timeout when db connections should be reaped.
#   Defaults to undef.
#
# [*database_max_retries*]
#   (optional) Maximum number of database connection retries during startup.
#   Setting -1 implies an infinite retry count.
#   (Defaults to undef)
#
# [*database_retry_interval*]
#   (optional) Interval between retries of opening a database connection.
#   (Defaults to undef)
#
# [*database_min_pool_size*]
#   (optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to: undef
#
# [*database_max_pool_size*]
#   (optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to: undef
#
# [*database_max_overflow*]
#   (optional) If set, use this value for max_overflow with sqlalchemy.
#   Defaults to: undef
#
# [*rpc_backend*]
#   (Optional) Use these options to configure the RabbitMQ message system.
#   Defaults to 'rabbit'
#
# [*control_exchange*]
#   (Optional)
#   Defaults to 'openstack'.
#
# [*rabbit_host*]
#   (Optional) IP or hostname of the rabbit server.
#   Defaults to '127.0.0.1'
#
# [*rabbit_port*]
#   (Optional) Port of the rabbit server.
#   Defaults to 5672.
#
# [*rabbit_hosts*]
#   (Optional) Array of host:port (used with HA queues).
#   If defined, will remove rabbit_host & rabbit_port parameters from config
#   Defaults to undef.
#
# [*rabbit_userid*]
#   (Optional) User to connect to the rabbit server.
#   Defaults to 'guest'
#
# [*rabbit_password*]
#   (Required) Password to connect to the rabbit_server.
#   Defaults to empty. Required if using the Rabbit (kombu)
#   backend.
#
# [*rabbit_virtual_host*]
#   (Optional) Virtual_host to use.
#   Defaults to '/'
#
# [*rabbit_heartbeat_timeout_threshold*]
#   (optional) Number of seconds after which the RabbitMQ broker is considered
#   down if the heartbeat keepalive fails.  Any value >0 enables heartbeats.
#   Heartbeating helps to ensure the TCP connection to RabbitMQ isn't silently
#   closed, resulting in missed or lost messages from the queue.
#   (Requires kombu >= 3.0.7 and amqp >= 1.4.0)
#   Defaults to 0
#
# [*rabbit_heartbeat_rate*]
#   (optional) How often during the rabbit_heartbeat_timeout_threshold period to
#   check the heartbeat on RabbitMQ connection.  (i.e. rabbit_heartbeat_rate=2
#   when rabbit_heartbeat_timeout_threshold=60, the heartbeat will be checked
#   every 30 seconds.
#   Defaults to 2
#
# [*rabbit_use_ssl*]
#   (optional) Connect over SSL for RabbitMQ
#   Defaults to false
#
# [*kombu_ssl_ca_certs*]
#   (optional) SSL certification authority file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_certfile*]
#   (optional) SSL cert file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_keyfile*]
#   (optional) SSL key file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_version*]
#   (optional) SSL version to use (valid only if SSL enabled).
#   Valid values are TLSv1, SSLv23 and SSLv3. SSLv2 may be
#   available on some distributions.
#   Defaults to $::os_service_default
#
# [*kombu_reconnect_delay*]
#   (optional) How long to wait before reconnecting in response to an AMQP
#   consumer cancel notification.
#   Defaults to $::os_service_default
#
# [*amqp_durable_queues*]
#   Use durable queues in amqp.
#   (Optional) Defaults to false.
#
# [*service_provider*]
#   (optional) Provider, that can be used for congress service.
#   Default value defined in congress::params for given operation system.
#   If you use Pacemaker or another Cluster Resource Manager, you can make
#   custom service provider for changing start/stop/status behavior of service,
#   and set it here.
#
# [*service_name*]
#   (optional) Name of the service that will be providing the
#   server functionality of congress.
#   Defaults to '$::congress::params::service_name'
#
# [*sync_db*]
#   (Optional) Run db sync on the node.
#   Defaults to true
#
# == Dependencies
#  None
#
# == Examples
#
#   class { 'congress':
#     keystone_password   => 'congress',
#     keystone_tenant     => 'service',
#     auth_uri            => 'http://192.168.122.6:5000/',
#     identity_uri        => 'http://192.168.122.6:35357/',
#     database_connection => 'mysql://congress:password@192.168.122.6/congress',
#     rabbit_host         => '192.168.122.6',
#     rabbit_password     => 'guest',
#   }
#   
#   class { 'congress::db::mysql':
#       password => 'password',
#       host => '%',
#   } 
#   
#   class { 'congress::keystone::auth':
#     password            => 'congress',
#     tenant              => 'service',
#     admin_url           => 'http://192.168.122.6:1789',
#     internal_url        => 'http://192.168.122.6:1789',
#     public_url          => 'http://192.168.122.6:1789',
#     region              => 'regionOne',
#   }
#
# == Authors
#
#   Dan Radez <dradez@redhat.com>
#
# == Copyright
#
# Copyright 2015 Red Hat Inc, unless otherwise noted.
#

class congress(
  $keystone_password,
  $package_ensure                     = 'present',
  $client_package_ensure              = 'present',
  $bind_host                          = '0.0.0.0',
  $bind_port                          = '1789',
  $verbose                            = undef,
  $debug                              = undef,
  $auth_type                          = 'keystone',
  $auth_uri                           = false,
  $identity_uri                       = false,
  $keystone_tenant                    = 'services',
  $keystone_user                      = 'congress',
  $manage_service                     = true,
  $enabled                            = true,
  $database_connection                = undef,
  $database_idle_timeout              = undef,
  $database_max_retries               = undef,
  $database_retry_interval            = undef,
  $database_min_pool_size             = undef,
  $database_max_pool_size             = undef,
  $database_max_overflow              = undef,
  $rpc_backend                        = 'rabbit',
  $control_exchange                   = 'congress',
  $rabbit_host                        = '127.0.0.1',
  $rabbit_port                        = 5672,
  $rabbit_hosts                       = false,
  $rabbit_virtual_host                = '/',
  $rabbit_heartbeat_timeout_threshold = 0,
  $rabbit_heartbeat_rate              = 2,
  $rabbit_userid                      = 'guest',
  $rabbit_password                    = false,
  $rabbit_use_ssl                     = false,
  $kombu_ssl_ca_certs                 = $::os_service_default,
  $kombu_ssl_certfile                 = $::os_service_default,
  $kombu_ssl_keyfile                  = $::os_service_default,
  $kombu_ssl_version                  = $::os_service_default,
  $kombu_reconnect_delay              = $::os_service_default,
  $amqp_durable_queues                = false,
  $service_provider                   = $::congress::params::service_provider,
  $service_name                       = $::congress::params::service_name,
) inherits congress::params {
  congress_config {
    'DEFAULT/drivers'     : value => 'congress.datasources.neutronv2_driver.NeutronV2Driver,congress.datasources.glancev2_driver.GlanceV2Driver,congress.datasources.nova_driver.NovaDriver,congress.datasources.keystone_driver.KeystoneDriver,congress.datasources.ceilometer_driver.CeilometerDriver,congress.datasources.cinder_driver.CinderDriver';
    'DEFAULT/policy_path' : value => '/etc/congress/snapshot/';
    'DEFAULT/log_file'    : value => 'congress.log';
    'DEFAULT/log_dir'     : value => '/var/log/congress/';
  }

  if $identity_uri {
    congress_config { 'keystone_authtoken/identity_uri': value => $identity_uri; }
    congress_config { 'keystone_authtoken/auth_url'    : value => $identity_uri; }
  } else {
    congress_config { 'keystone_authtoken/identity_uri': ensure => absent; }
  }

  if $auth_uri {
    congress_config { 'keystone_authtoken/auth_uri': value => $auth_uri; }
  } else {
    congress_config { 'keystone_authtoken/auth_uri': ensure => absent; }
  }

  if $auth_type == 'keystone' {
    congress_config {
      'keystone_authtoken/project_name' : value => $keystone_tenant;
      'keystone_authtoken/username'     : value => $keystone_user;
      'keystone_authtoken/password'     : value => $keystone_password, secret => true;
    }
  }

  Congress_config<||> ~> Service[$service_name]
  Congress_config<||> ~> Exec<| title == 'congress-manage db_sync'|>

  include ::congress::db
  include ::congress::params

  if $sync_db {
    include ::congress::db::sync
    Class['::congress::db::sync'] ~> Service[$service_name]
  }
  if $rpc_backend == 'rabbit' {

    if ! $rabbit_password {
      fail('Please specify a rabbit_password parameter.')
    }

    congress_config {
      'DEFAULT/rabbit_password':              value => $rabbit_password, secret => true;
      'DEFAULT/rabbit_userid':                value => $rabbit_userid;
      'DEFAULT/rabbit_virtual_host':          value => $rabbit_virtual_host;
      'DEFAULT/control_exchange':             value => $control_exchange;
      #'DEFAULT/rabbit_use_ssl':               value => $rabbit_use_ssl;
      #'DEFAULT/kombu_reconnect_delay':        value => $kombu_reconnect_delay;
      #'DEFAULT/heartbeat_timeout_threshold':  value => $rabbit_heartbeat_timeout_threshold;
      #'DEFAULT/heartbeat_rate':               value => $rabbit_heartbeat_rate;
      #'DEFAULT/amqp_durable_queues':          value => $amqp_durable_queues;
    }

    if $rabbit_use_ssl {
      congress_config {
        'DEFAULT/kombu_ssl_version'  : value => $kombu_ssl_version;
        'DEFAULT/kombu_ssl_ca_certs' : value => $kombu_ssl_ca_certs;
        'DEFAULT/kombu_ssl_certfile' : value => $kombu_ssl_certfile;
        'DEFAULT/kombu_ssl_keyfile'  : value => $kombu_ssl_keyfile;
      }
    }

    if $rabbit_hosts {
      congress_config { 'DEFAULT/rabbit_hosts':     value => join($rabbit_hosts, ',') }
      congress_config { 'DEFAULT/rabbit_ha_queues': value => true }
      congress_config { 'DEFAULT/rabbit_host':      ensure => absent }
      congress_config { 'DEFAULT/rabbit_port':      ensure => absent }
    } else {
      congress_config { 'DEFAULT/rabbit_host':      value => $rabbit_host }
      congress_config { 'DEFAULT/rabbit_port':      value => $rabbit_port }
      congress_config { 'DEFAULT/rabbit_hosts':     value => "${rabbit_host}:${rabbit_port}" }
      congress_config { 'DEFAULT/rabbit_ha_queues': value => false }
    }

  }

  package { 'congress':
    ensure => $package_ensure,
    name   => $::congress::params::package_name,
    tag    => ['openstack', 'congress-package'],
  }
  if $client_package_ensure == 'present' {
    include '::congress::client'
  } else {
    class { '::congress::client':
      ensure => $client_package_ensure,
    }
  }

  group { 'congress':
    ensure  => present,
    system  => true,
    require => Package['congress'],
  }

  user { 'congress':
    ensure  => 'present',
    gid     => 'congress',
    system  => true,
    require => Package['congress'],
  }

  file { ['/etc/congress', '/var/log/congress', '/var/lib/congress']:
    ensure  => directory,
    mode    => '0750',
    owner   => 'congress',
    group   => 'congress',
    require => Package['congress'],
    notify  => Service[$service_name],
  }

  file { '/etc/congress/congress.conf':
    ensure  => present,
    mode    => '0600',
    owner   => 'congress',
    group   => 'congress',
    require => Package['congress'],
    notify  => Service[$service_name],
  }

  congress_config {
    'DEFAULT/bind_host': value => $bind_host;
    'DEFAULT/bind_port': value => $bind_port;
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }
  }

  class { '::congress::service':
    ensure       => $service_ensure,
    service_name => $service_name,
    enable       => $enabled,
    hasstatus    => true,
    hasrestart   => true,
    provider     => $service_provider,
  }
}
