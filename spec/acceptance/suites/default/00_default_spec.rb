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

=begin
    describe service('rkhunter') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
=end
  end
end
