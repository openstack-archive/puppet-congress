# == Class: congress::policy
#
# Configure the congress policies
#
# === Parameters
#
# [*policies*]
#   (optional) Set of policies to configure for congress
#   Example :
#     {
#       'congress-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'congress-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (optional) Path to the nova policy.json file
#   Defaults to /etc/congress/policy.json
#
class congress::policy (
  $policies    = {},
  $policy_path = '/etc/congress/policy.json',
) {

  validate_hash($policies)

  Openstacklib::Policy::Base {
    file_path => $policy_path,
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'congress_config': policy_file => $policy_path }

}
