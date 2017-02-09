# == Class: congress::params
#
# Parameters for puppet-congress
#
class congress::params {
  include ::openstacklib::defaults

  $drivers             = ['congress.datasources.neutronv2_driver.NeutronV2Driver,congress.datasources.glancev2_driver.GlanceV2Driver',
                          'congress.datasources.nova_driver.NovaDriver',
                          'congress.datasources.keystone_driver.KeystoneDriver',
                          'congress.datasources.ceilometer_driver.CeilometerDriver',
                          'congress.datasources.cinder_driver.CinderDriver']
  $client_package_name = 'python-congressclient'

  case $::osfamily {
    'RedHat': {
      $package_name = 'openstack-congress'
      $service_name = 'openstack-congress-server'
    }
    'Debian': {
      $package_name = 'congress-server'
      $service_name = 'congress-server'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }
  }
}
