require 'spec_helper.rb'

describe 'rkhunter' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        context 'with default parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to create_class('rkhunter') }
          it { is_expected.to create_class('rkhunter::install') }
          it { is_expected.to create_class('rkhunter::config').that_requires('Class[rkhunter::install]') }
          it { is_expected.to create_class('rkhunter::check').that_requires('Class[rkhunter::config]') }

          it { is_expected.to create_package('rkhunter') }
          it { is_expected.to create_cron('rkhunter') }

          if os_facts[:os][:release][:major].to_i >= 8
            it { is_expected.to_not create_package('unhide') }
          else
            it { is_expected.to create_package('unhide') }
          end
            
        end

        context 'when checking for updates' do
          let(:params) {{
            :check_for_updates => true
          }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to create_class('rkhunter::update').that_requires('Class[rkhunter::config]') }
        end

      end
    end
  end
end
