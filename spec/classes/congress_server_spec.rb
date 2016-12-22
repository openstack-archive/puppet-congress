require 'spec_helper'

describe 'congress::server' do

  let :pre_condition do
    "class { '::congress::keystone::authtoken':
       password =>'foo',
     }
     class {'::congress': }"
  end

  let :params do
    { :enabled        => true,
      :manage_service => true,
      :bind_host      => '0.0.0.0',
      :bind_port      => '1789'
    }
  end

  shared_examples_for 'congress::server' do

    it { is_expected.to contain_class('congress::deps') }
    it { is_expected.to contain_class('congress::params') }
    it { is_expected.to contain_class('congress::policy') }

    it 'configures api' do
      is_expected.to contain_congress_config('DEFAULT/bind_host').with_value( params[:bind_host] )
      is_expected.to contain_congress_config('DEFAULT/bind_port').with_value( params[:bind_port] )
    end

    [{:enabled => true}, {:enabled => false}].each do |param_hash|
      context "when service should be #{param_hash[:enabled] ? 'enabled' : 'disabled'}" do
        before do
          params.merge!(param_hash)
        end

        it 'configures congress-server service' do
          is_expected.to contain_service('congress-server').with(
            :ensure => (params[:manage_service] && params[:enabled]) ? 'running' : 'stopped',
            :name   => platform_params[:congress_service],
            :enable => params[:enabled],
            :tag    => 'congress-service',
          )
        end
      end
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          { :congress_service => 'congress-server' }
        when 'RedHat'
          { :congress_service => 'openstack-congress' }
        end
      end

      it_configures 'congress::server'
    end
  end
end
