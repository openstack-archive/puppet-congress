# == Class: congress::params
#
# Parameters for puppet-congress
#
class congress::params {
  include ::openstacklib::defaults

  $client_package_name = 'python-congressclient'
  $drivers             = ['congress.datasources.neutronv2_driver.NeutronV2Driver,congress.datasources.glancev2_driver.GlanceV2Driver',
                          'congress.datasources.nova_driver.NovaDriver',
                          'congress.datasources.keystone_driver.KeystoneDriver',
                          'congress.datasources.ceilometer_driver.CeilometerDriver',
                          'congress.datasources.cinder_driver.CinderDriver']
  $policy_path         = '/etc/congress/snapshot/'

  case $::osfamily {
    'RedHat': {
      $package_name = 'openstack-congress'
      $service_name = 'congress-server'
    }
    'Debian': {
      $package_name = 'congress'
      $service_name = 'congress'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }
  }
}
