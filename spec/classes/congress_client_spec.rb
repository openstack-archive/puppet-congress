require 'spec_helper'

describe 'congress::client' do

  shared_examples 'congress::client' do

    context 'with default parameters' do
      it 'contains congress::params' do
        is_expected.to contain_class('congress::deps')
        is_expected.to contain_class('congress::params')
      end
      it 'contains congressclient' do
        is_expected.to contain_package('python-congressclient').with(
          :ensure => 'present',
          :name   => platform_params[:client_package_name],
          :tag    => 'openstack',
        )
      end
      it { is_expected.to contain_class('openstacklib::openstackclient') }
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
          { :client_package_name => 'python3-congressclient' }
        when 'RedHat'
          if facts[:operatingsystem] == 'Fedora'
            { :client_package_name => 'python3-congressclient' }
          else
            if facts[:operatingsystemmajrelease] > '7'
              { :client_package_name => 'python3-congressclient' }
            else
              { :client_package_name => 'python-congressclient' }
            end
          end
        end
      end

      it_behaves_like 'congress::client'
    end
  end


end
