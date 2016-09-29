#
# Class to execute congress-manage db_sync
#
# == Parameters
#
# [*extra_params*]
#   (optional) String of extra command line parameters to append
#   to the congress-dbsync command.
#   Defaults to undef
#
class congress::db::sync(
  $extra_params  = undef,
) {
  exec { 'congress-db-sync':
    command     => "congress-manage db_sync ${extra_params}",
    path        => '/usr/bin',
    user        => 'congress',
    refreshonly => true,
    try_sleep   => 5,
    tries       => 10,
    subscribe   => [Package['congress'], Congress_config['database/connection']],
  }

  Exec['congress-manage db_sync'] ~> Service<| title == 'congress' |>
}
