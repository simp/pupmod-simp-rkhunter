require 'spec_helper_acceptance'

test_name 'rkhunter class'

describe 'rkhunter class' do
  hosts.each do |host|
    let(:manifest) {
      <<-EOS
        class { 'rkhunter': }
      EOS
    }

    context 'default parameters' do
      # Using puppet_apply as a helper
      it 'should work with no errors' do
        apply_manifest_on(host, manifest, :catch_failures => true)
      end

      it 'should be idempotent' do
        apply_manifest_on(host, manifest, :catch_changes => true)
      end

      if host[:platform] =~ %r{el-7-x86_64}
        it 'should install unhide' do
          expect(check_for_package(host,'unhide')).to be true
        end
      end

      it 'should have rkhunter installed'  do
        expect(check_for_package(host,'rkhunter')).to be true
      end

      it 'should create the conf file' do
        on(host, %(test -f /etc/rkhunter.conf))
      end

      it 'should create a crontab entry' do
        on(host, %(crontab -l | grep "# Puppet Name: rkhunter"))
      end

      it 'should generate the database' do
        on(host, %(test -f /var/lib/rkhunter/db/rkhunter.dat))
      end

      it 'should run rkhutner successfully without warnings' do
        on(host, %(sed -i 's/^PATH=PATH/export PATH=PATH/' .ssh/environment;))
        on(host, %(rkhunter --check --skip-keypress --disable passwd_changes,group_changes,system_configs_ssh))
      end

      it 'should generate a valid log when problems are found' do
        on(host, %(touch /bin/.login))
        on(host, %(rkhunter --check --skip-keypress --disable passwd_changes,group_changes,system_configs_ssh), :acceptable_exit_codes => 1)
        on(host, %(grep 'Warning: Found login backdoor file: /bin/.login' /var/log/rkhunter/rkhunter.log))
      end
    end
  end
end
