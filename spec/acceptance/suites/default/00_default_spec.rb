require 'spec_helper_acceptance'

# For loading YAML
require 'puppet'

test_name 'rkhunter class'

describe 'rkhunter class' do
  hosts.each do |host|
    let(:manifest) do
      <<~MANIFEST
        include 'rkhunter'
      MANIFEST
    end

    context 'default parameters' do
      # Using puppet_apply as a helper
      it 'works with no errors' do
        apply_manifest_on(host, manifest, catch_failures: true)
      end

      it 'is idempotent' do
        apply_manifest_on(host, manifest, catch_changes: true)
      end

      if host[:platform].include?('el-7-x86_64')
        it 'installs unhide' do
          expect(check_for_package(host, 'unhide')).to be true
        end
      end

      it 'has rkhunter installed' do
        expect(check_for_package(host, 'rkhunter')).to be true
      end

      it 'creates the conf file' do
        on(host, %(test -f /etc/rkhunter.conf))
      end

      it 'is running puppet_rkhunter_check.timer' do
        output = on(host, 'puppet resource service puppet_rkhunter_check.timer --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_check.timer']
        expect { service['ensure'].to eq 'running' }
        expect { service['enable'].to eq 'true' }
      end

      it 'is running puppet_rkhunter_check.service' do
        output = on(host, 'puppet resource service puppet_rkhunter_check.service --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_check.timer']
        expect { service['ensure'].to eq 'running' }
        expect { service['enable'].to eq 'true' }
      end

      it 'is running puppet_rkhunter_update.timer' do
        output = on(host, 'puppet resource service puppet_rkhunter_update.timer --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_update.timer']
        expect { service['ensure'].to eq 'running' }
        expect { service['enable'].to eq 'true' }
      end

      it 'is running puppet_rkhunter_update.service' do
        output = on(host, 'puppet resource service puppet_rkhunter_update.service --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_update.timer']
        expect { service['ensure'].to eq 'running' }
        expect { service['enable'].to eq 'true' }
      end

      it 'does not have the root cron entry for rkhunter_check' do
        output = on(host, 'puppet resource cron rkhunter_check --to_yaml').stdout
        cron = YAML.safe_load(output)['cron']['rkhunter_check']
        expect { cron['ensure'].to eq 'absent' }
      end

      it 'does not have the root cron entry for rkhunter_update' do
        output = on(host, 'puppet resource cron rkhunter_update --to_yaml').stdout
        cron = YAML.safe_load(output)['cron']['rkhunter_update']
        expect { cron['ensure'].to eq 'absent' }
      end

      it 'generates the database' do
        on(host, %(test -f /var/lib/rkhunter/db/rkhunter.dat))
      end

      it 'runs rkhutner successfully without warnings' do
        on(host, %(sed -i 's/^PATH=PATH/export PATH=PATH/' .ssh/environment;))
        on(host, %(rkhunter --check --skip-keypress --disable passwd_changes,group_changes,system_configs_ssh))
      end

      it 'generates a valid log when problems are found' do
        on(host, %(touch /bin/.login))
        on(host, %(rkhunter --check --skip-keypress --disable passwd_changes,group_changes,system_configs_ssh), acceptable_exit_codes: 1)
        on(host, %(grep 'Warning: Found login backdoor file: /bin/.login' /var/log/rkhunter/rkhunter.log))
      end
    end

    context 'using cron instead of systemd' do
      let(:hieradata) do
        {
          'rkhunter::check::method' => 'cron',
          'rkhunter::update::method' => 'cron'
        }
      end

      it 'works with no errors' do
        set_hieradata_on(host, hieradata)
        apply_manifest_on(host, manifest, catch_failures: true)
      end

      it 'is idempotent' do
        apply_manifest_on(host, manifest, catch_changes: true)
      end

      it 'is not running puppet_rkhunter_check.timer' do
        output = on(host, 'puppet resource service puppet_rkhunter_check.timer --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_check.timer']
        expect { service['ensure'].to eq 'stopped' }
        expect { service['enable'].to eq 'false' }
      end

      it 'is not running puppet_rkhunter_check.service' do
        output = on(host, 'puppet resource service puppet_rkhunter_check.service --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_check.timer']
        expect { service['ensure'].to eq 'stopped' }
        expect { service['enable'].to eq 'false' }
      end

      it 'is not running puppet_rkhunter_update.timer' do
        output = on(host, 'puppet resource service puppet_rkhunter_update.timer --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_update.timer']
        expect { service['ensure'].to eq 'stopped' }
        expect { service['enable'].to eq 'false' }
      end

      it 'is not running puppet_rkhunter_update.service' do
        output = on(host, 'puppet resource service puppet_rkhunter_update.service --to_yaml').stdout
        service = YAML.safe_load(output)['service']['puppet_rkhunter_update.timer']
        expect { service['ensure'].to eq 'stopped' }
        expect { service['enable'].to eq 'false' }
      end

      it 'has the root cron entry for rkhunter_check' do
        output = on(host, 'puppet resource cron rkhunter_check --to_yaml').stdout
        cron = YAML.safe_load(output)['cron']['rkhunter_check']
        expect { cron['command'].to eq '/usr/bin/rkhunter --check --skip-keypress --quiet' }
      end

      it 'has the root cron entry for rkhunter_update' do
        output = on(host, 'puppet resource cron rkhunter_update --to_yaml').stdout
        cron = YAML.safe_load(output)['cron']['rkhunter_update']
        expect { cron['command'].to eq '/usr/bin/rkhunter --update --nocolors' }
      end
    end
  end
end
