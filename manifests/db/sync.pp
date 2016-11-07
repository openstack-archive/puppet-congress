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
    command     => "congress-db-manage upgrade head ${extra_params}",
    path        => ['/bin', '/usr/bin'],
    user        => 'congress',
    refreshonly => true,
    logoutput   => 'on_failure',
    subscribe   => [Package['congress']],
  }

  Exec['congress-db-sync'] ~> Service<| title == 'congress' |>
}
