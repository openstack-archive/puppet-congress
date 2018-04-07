require 'spec_helper_acceptance'

describe 'basic congress' do

  context 'default parameters' do

    it 'should work with no errors' do
      pp= <<-EOS
      include ::openstack_integration
      include ::openstack_integration::repos
      include ::openstack_integration::rabbitmq
      include ::openstack_integration::mysql
      include ::openstack_integration::keystone

      rabbitmq_user { 'congress':
        admin    => true,
        password => 'an_even_bigger_secret',
        provider => 'rabbitmqctl',
        require  => Class['rabbitmq'],
      }
      rabbitmq_user_permissions { 'congress@/':
        configure_permission => '.*',
        write_permission     => '.*',
        read_permission      => '.*',
        provider             => 'rabbitmqctl',
        require              => Class['rabbitmq'],
      }
      # Congress resources
      class { '::congress::logging':
        debug => true,
      }
      class { '::congress':
        default_transport_url => 'rabbit://congress:an_even_bigger_secret@127.0.0.1/',
      }
      class { '::congress::keystone::auth':
        password => 'a_big_secret',
      }
      class { '::congress::db::mysql':
        password => 'a_big_secret',
      }
      class { '::congress::db':
        database_connection => 'mysql+pymysql://congress:a_big_secret@127.0.0.1/congress?charset=utf8',
      }
      class { '::congress::keystone::authtoken':
        password => 'a_big_secret',
      }
      class { '::congress::server': }
      class { '::congress::client': }
      EOS


      # Run it twice to test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe port(1789) do
      it { is_expected.to be_listening.with('tcp') }
    end
  end
end
