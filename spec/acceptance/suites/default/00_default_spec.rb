require 'spec_helper_acceptance'

test_name 'rkhunter class'

describe 'rkhunter class' do
  let(:manifest) {
    <<-EOS
      class { 'rkhunter': }
    EOS
  }

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      apply_manifest(manifest, :catch_failures => true)
    end

    it 'should be idempotent' do
      apply_manifest(manifest, :catch_changes => true)
    end

    describe package('unhide') do
      it { is_expected.to be_installed }
    end

    describe package('rkhunter') do
      it { is_expected.to be_installed }
    end

    it 'should create the conf file' do
      on(host, 'ls /etc/rkhunter.conf')
    end

    it 'should generate the database' do
      on(host, 'ls /var/lib/rkhunter/db/rkhunter.dat')
    end

    it 'should generate a valid report and log when problems are found' do
      on(host, 'touch /bin/.login')
      on(host, 'rkhunter --check --skip-keypress --quiet', :acceptable_exit_codes => 1)

      on(host, "grep 'Warning: Found login backdoor file: /bin/.login' /var/log/rkhunter/rkhunter.log")
    end
=begin
    describe service('rkhunter') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
=end
  end
end
