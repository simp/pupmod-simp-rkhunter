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
      end
    end
  end
end
