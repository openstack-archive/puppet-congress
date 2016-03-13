require 'spec_helper'

describe 'congress::db' do

  shared_examples 'congress::db' do
    context 'with default parameters' do
      it { is_expected.to contain_congress_config('database/connection').with_value('mysql://congress:secrete@localhost:3306/congress') }
      it { is_expected.to contain_congress_config('database/idle_timeout').with_value('3600') }
      it { is_expected.to contain_congress_config('database/min_pool_size').with_value('1') }
      it { is_expected.to contain_congress_config('database/max_retries').with_value('10') }
      it { is_expected.to contain_congress_config('database/retry_interval').with_value('10') }
      it { is_expected.to contain_congress_config('database/max_pool_size').with_value('10') }
      it { is_expected.to contain_congress_config('database/max_overflow').with_value('20') }
    end

    context 'with specific parameters' do
      let :params do
        { :database_connection     => 'mysql://congress:congress@localhost/congress',
          :database_idle_timeout   => '3601',
          :database_min_pool_size  => '2',
          :database_max_retries    => '11',
          :database_retry_interval => '11',
          :database_max_pool_size  => '11',
          :database_max_overflow   => '21',
        }
      end

      it { is_expected.to contain_congress_config('database/connection').with_value('mysql://congress:congress@localhost/congress') }
      it { is_expected.to contain_congress_config('database/idle_timeout').with_value('3601') }
      it { is_expected.to contain_congress_config('database/min_pool_size').with_value('2') }
      it { is_expected.to contain_congress_config('database/max_retries').with_value('11') }
      it { is_expected.to contain_congress_config('database/retry_interval').with_value('11') }
      it { is_expected.to contain_congress_config('database/max_pool_size').with_value('11') }
      it { is_expected.to contain_congress_config('database/max_overflow').with_value('21') }
    end

    context 'with postgresql backend' do
      let :params do
        { :database_connection     => 'postgresql://congress:congress@localhost/congress', }
      end

      it 'install the proper backend package' do
        is_expected.to contain_package('python-psycopg2').with(:ensure => 'present')
      end

    end

    context 'with incorrect database_connection string' do
      let :params do
        { :database_connection     => 'sqlite://congress:congress@localhost/congress', }
      end

      it_raises 'a Puppet::Error', /validate_re/
    end
  end

  context 'on Debian platforms' do
    let :facts do
      { :osfamily => 'Debian',
        :operatingsystem => 'Debian',
        :operatingsystemrelease => 'jessie',
      }
    end

    it_configures 'congress::db'
  end

  context 'on Redhat platforms' do
    let :facts do
      { :osfamily => 'RedHat',
        :operatingsystemrelease => '7.1',
      }
    end

    it_configures 'congress::db'
  end

end
