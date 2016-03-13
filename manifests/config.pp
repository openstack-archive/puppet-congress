# == Class: congress::config
#
# This class is used to manage arbitrary congress configurations.
#
# === Parameters
#
# [*congress_config*]
#   (optional) Allow configuration of arbitrary congress configurations.
#   The value is an hash of congress_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   congress_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class congress::config (
  $congress_config = {},
) {

  validate_hash($congress_config)

  create_resources('congress_config', $congress_config)
}
