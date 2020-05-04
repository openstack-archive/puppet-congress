# == Class: congress::params
#
# Parameters for puppet-congress
#
class congress::params {
  include openstacklib::defaults
  $pyvers = $::openstacklib::defaults::pyvers

  $client_package_name = "python${pyvers}-congressclient"
  $group               = 'congress'

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
