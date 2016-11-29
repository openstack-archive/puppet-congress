require 'spec_helper'

describe 'congress::db::sync' do

  shared_examples_for 'congress-dbsync' do

    it 'runs congress-db-sync' do
      is_expected.to contain_exec('congress-db-sync').with(
        :command     => 'congress-db-manage --config-file /etc/congress/congress.conf upgrade head',
        :path        => ["/bin", "/usr/bin"],
        :refreshonly => true,
        :user        => 'congress',
        :logoutput   => 'on_failure',
        :subscribe   => ['Anchor[congress::install::end]',
                         'Anchor[congress::config::end]',
                         'Anchor[congress::dbsync::begin]'],
        :notify      => 'Anchor[congress::dbsync::end]',
      )
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts({
          :os_workers     => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      it_configures 'congress-dbsync'
    end
  end

end
