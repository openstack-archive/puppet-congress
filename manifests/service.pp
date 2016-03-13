# == Class congress::service
#
# Encapsulates the congress service to a class.
# This allows resources that require congress to
# require this class, which can optionally
# validate that the service can actually accept
# connections.
#
# === Parameters
#
# [*ensure*]
#   (optional) The desired state of the congress service
#   Defaults to undef
#
# [*service_name*]
#   (optional) The name of the congress service
#   Defaults to $::congress::params::service_name
#
# [*enable*]
#   (optional) Whether to enable the congress service
#   Defaults to true
#
# [*hasstatus*]
#   (optional) Whether the congress service has status
#   Defaults to true
#
# [*hasrestart*]
#   (optional) Whether the congress service has restart
#   Defaults to true
#
# [*provider*]
#   (optional) Provider for congress service
#   Defaults to $::congress::params::service_provider
#
class congress::service(
  $ensure         = undef,
  $service_name   = $::congress::params::service_name,
  $enable         = true,
  $hasstatus      = true,
  $hasrestart     = true,
  $provider       = $::congress::params::service_provider,
) {
  include ::congress::params

  service { 'congress':
    ensure     => $ensure,
    name       => $service_name,
    enable     => $enable,
    hasstatus  => $hasstatus,
    hasrestart => $hasrestart,
    provider   => $provider,
    tag        => 'congress-service',
  }

}
