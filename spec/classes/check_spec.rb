require 'spec_helper'

describe 'rkhunter::check' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      let(:pre_condition) do
        <<~PRECOND
          function assert_private(){}
        PRECOND
      end

      let(:facts) do
        os_facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to create_class('rkhunter::check') }

      it do
        is_expected.to create_systemd__timer('puppet_rkhunter_check.timer').
          with_timer_content(/OnCalendar=\*-\* 1:\d+/).
          with_service_content(/Type=oneshot/).
          with_service_content(%r{ExecStart=/usr/bin/rkhunter --check --skip-keypress --quiet}).
          with_active(true).
          with_enable(true)
      end

      it { is_expected.to create_cron('rkhunter_check').with_ensure('absent') }

      context 'cron mode' do
        let(:params) do
          {
            :method => 'cron'
          }
        end
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('rkhunter::check') }

        it do
          is_expected.to create_systemd__timer('puppet_rkhunter_check.timer').
            with_timer_content(/OnCalendar=\*-\* 1:\d+/).
            with_service_content(/Type=oneshot/).
            with_service_content(%r{ExecStart=/usr/bin/rkhunter --check --skip-keypress --quiet}).
            with_active(false).
            with_enable(false)
        end

        it do
          is_expected.to create_cron('rkhunter_check').
            with_command('/usr/bin/rkhunter --check --skip-keypress --quiet').
            with_minute(/\d+/).
            with_hour(1).
            with_monthday('*').
            with_month('*').
            with_weekday('*')
        end
      end
    end
  end
end
