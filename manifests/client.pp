# == Class: congress::client
#
# Installs congress client.
#
# === Parameters
#
# [*ensure*]
#   (optional) Ensure state of the package.
#   Defaults to 'present'.
#
class congress::client (
  $ensure = 'present'
) {

  package { 'python-congressclient':
    ensure => $ensure,
    tag    => 'openstack',
  }

  if $ensure == 'present' {
    include '::openstacklib::openstackclient'
  } else {
    class { '::openstacklib::openstackclient':
      package_ensure => $ensure,
    }
  }
}
