require 'spec_helper.rb'

shared_examples_for 'a rkhunter::config' do |content|

  it { is_expected.to compile.with_all_deps }
  it { is_expected.to create_class('rkhunter') }
  it { is_expected.to contain_class('rkhunter::config') }
  it { is_expected.to contain_file('/etc/rkhunter.conf').with({
      :ensure       => 'file',
      :owner        => 'root',
      :group        => 'root',
      :mode         => '0640',
      :content      => content,
      :validate_cmd => 'PATH=/sbin:/bin:/usr/sbin:/usr/bin rkhunter -C --configfile %'
      } )
  }
end

describe 'rkhunter' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        context 'with default parameters used by rkhunter::config' do
          it_should_behave_like 'a rkhunter::config', File.read(File.join(fixtures, 'rkhunter.conf/default'))
        end
        context 'with default parameters and all optionals set' do
          let(:hieradata) { 'config' }
          it_should_behave_like 'a rkhunter::config', File.read(File.join(fixtures, 'rkhunter.conf/full'))
        end
      end
    end
  end
end
