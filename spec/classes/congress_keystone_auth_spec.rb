#
# Unit tests for congress::keystone::auth
#

require 'spec_helper'

describe 'congress::keystone::auth' do
  shared_examples_for 'congress-keystone-auth' do
    context 'with default class parameters' do
      let :params do
        { :password => 'congress_password',
          :tenant   => 'foobar' }
      end

      it { is_expected.to contain_keystone_user('congress').with(
        :ensure   => 'present',
        :password => 'congress_password',
      ) }

      it { is_expected.to contain_keystone_user_role('congress@foobar').with(
        :ensure  => 'present',
        :roles   => ['admin']
      )}

      it { is_expected.to contain_keystone_service('congress::policy').with(
        :ensure      => 'present',
        :description => 'congress Policy Service'
      ) }

      it { is_expected.to contain_keystone_endpoint('RegionOne/congress::policy').with(
        :ensure       => 'present',
        :public_url   => 'http://127.0.0.1:1789',
        :admin_url    => 'http://127.0.0.1:1789',
        :internal_url => 'http://127.0.0.1:1789',
      ) }
    end

    context 'when overriding URL parameters' do
      let :params do
        { :password     => 'congress_password',
          :public_url   => 'https://10.10.10.10:80',
          :internal_url => 'http://10.10.10.11:81',
          :admin_url    => 'http://10.10.10.12:81', }
      end

      it { is_expected.to contain_keystone_endpoint('RegionOne/congress::policy').with(
        :ensure       => 'present',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81',
      ) }
    end

    context 'when overriding auth name' do
      let :params do
        { :password => 'foo',
          :auth_name => 'congressy' }
      end

      it { is_expected.to contain_keystone_user('congressy') }
      it { is_expected.to contain_keystone_user_role('congressy@services') }
      it { is_expected.to contain_keystone_service('congress::policy') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/congress::policy') }
    end

    context 'when overriding service name' do
      let :params do
        { :service_name => 'congress_service',
          :auth_name    => 'congress',
          :password     => 'congress_password' }
      end

      it { is_expected.to contain_keystone_user('congress') }
      it { is_expected.to contain_keystone_user_role('congress@services') }
      it { is_expected.to contain_keystone_service('congress_service::policy') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/congress_service::policy') }
    end

    context 'when disabling user configuration' do

      let :params do
        {
          :password       => 'congress_password',
          :configure_user => false
        }
      end

      it { is_expected.not_to contain_keystone_user('congress') }
      it { is_expected.to contain_keystone_user_role('congress@services') }
      it { is_expected.to contain_keystone_service('congress::policy').with(
        :ensure      => 'present',
        :description => 'congress Policy Service'
      ) }

    end

    context 'when disabling user and user role configuration' do

      let :params do
        {
          :password            => 'congress_password',
          :configure_user      => false,
          :configure_user_role => false
        }
      end

      it { is_expected.not_to contain_keystone_user('congress') }
      it { is_expected.not_to contain_keystone_user_role('congress@services') }
      it { is_expected.to contain_keystone_service('congress::policy').with(
        :ensure      => 'present',
        :description => 'congress Policy Service'
      ) }

    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'congress-keystone-auth'
    end
  end
end
