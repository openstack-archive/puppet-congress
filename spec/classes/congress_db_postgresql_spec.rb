require 'spec_helper'

describe 'congress::db::postgresql' do

  let :pre_condition do
    'include postgresql::server'
  end

  let :required_params do
    { :password => 'congresspass' }
  end

  shared_examples_for 'congress-db-postgresql' do
    context 'with only required parameters' do
      let :params do
        required_params
      end

      it { is_expected.to contain_openstacklib__db__postgresql('congress').with(
        :user       => 'congress',
        :password   => 'congresspass',
        :dbname     => 'congress',
        :encoding   => nil,
        :privileges => 'ALL',
      )}
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts({ :concat_basedir => '/var/lib/puppet/concat' }))
      end

      it_behaves_like 'congress-db-postgresql'
    end
  end
end
