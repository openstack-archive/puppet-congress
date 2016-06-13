require 'spec_helper'

describe 'congress::db::postgresql' do

  let :pre_condition do
    'include postgresql::server'
  end

  let :required_params do
    { :password => 'pw' }
  end

  shared_examples_for 'congress-db-postgresql' do
    context 'with only required parameters' do
      let :params do
        required_params
      end

      it { is_expected.to contain_postgresql__server__db('congress').with(
        :user     => 'congress',
        :password => 'md5a2f665ba4d66aae91c2a86eedd8e564e'
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
