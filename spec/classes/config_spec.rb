require 'spec_helper.rb'

describe 'rkhunter' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        # config is a private class called by init.
        #
        context 'with default parameters' do
          it { is_expected.to create_class('Rkhunter::Propupd').with_stage('simp_finalize')}

          it {
            is_expected.to create_exec('rkhunter_propupd')
              .with_command('rkhunter --propupd')
              .with_creates('/var/lib/rkhunter/db/rkhunter.dat')
              .with_path(['/bin', '/usr/bin'])
          }

          it {
            is_expected.to create_file('/etc/rkhunter.conf')
              .with_owner('root')
              .with_group('root')
              .with_mode('0640')
              .with_validate_cmd('PATH=/sbin:/bin:/usr/sbin:/usr/bin rkhunter -C --configfile %')
          }

          expected_content = File.read(File.join(File.dirname(__FILE__),'../files/rkhunter_conf.txt'))
          it { is_expected.to create_file('/etc/rkhunter.conf').with_content(expected_content) }
        end

      end
    end
  end
end
