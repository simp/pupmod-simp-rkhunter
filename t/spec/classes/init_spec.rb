require 'spec_helper'

describe 'rkhunter' do
  let(:title) { 'rkhunter' }
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

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
