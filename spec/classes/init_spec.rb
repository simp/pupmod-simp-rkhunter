require 'spec_helper.rb'

describe 'rkhunter' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        context 'with default parameters' do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to create_class('rkhunter') }
          it { is_expected.to create_package('rkhunter') }
          it { is_expected.to create_cron('rkhunter') }
        end

        context 'with hiera override parameters' do
          let(:params) {{
            :dbdir            => '/var/lib/rkhunter/db',
            :disable_tests    => ['suspscan hidden_ports','deleted_files packet_cap_apps',
              'apps ipc_shared_mem','fake_test number3'],
            :existwhitelist   => ['/fake/whitelist/path', '/usr/bin/POST'],
            :language         => 'ch',
            :missing_logfiles => ['/this/used/to/be/here.log','/another/file/not/here.log'],
            :password_file    => '/etc/fakepwdir',
          }}
          it { is_expected.to compile.with_all_deps }
          # make sure interpolation of hieradata in modules's data/ is working
          it { is_expected.to contain_class('rkhunter').with(
            :dbdir            => '/var/lib/rkhunter/db',
            :disable_tests    => ['suspscan hidden_ports','deleted_files packet_cap_apps',
              'apps ipc_shared_mem','fake_test number3'],
            :existwhitelist   => ['/fake/whitelist/path', '/usr/bin/POST'],
            :language         => 'ch',
            :missing_logfiles => ['/this/used/to/be/here.log','/another/file/not/here.log'],
            :password_file    => '/etc/fakepwdir',
            )
          }
        end

      end
    end
  end
end
