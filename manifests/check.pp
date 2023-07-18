# @summary Add a scheduled job to check the system with rkhunter
#
# @param method
#   How you wish to schedule the run
#
# @param systemd_calendar
#   If `$method` is `systemd`, set this exact calendar string
#
#   This is not verified, use `systemd-analyze calendar` on a modern system to
#   ensure that you have a valid string
#
# @param minute
#   Cron minute
#
# @param hour
#   Cron hour
#
# @param monthday
#   Cron monthday
#
# @param month
#   Cron month
#
# @param weekday
#   Cron weekday
#
# @param path
#   The path to rkhunter
#
# @param options
#   Extra options to pass to `rkhunter --check`
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#
class rkhunter::check (
  Enum['cron','systemd']  $method           = 'systemd',
  Optional[String[1]]     $systemd_calendar = undef,
  Simplib::Cron::Minute   $minute           = fqdn_rand(59),
  Simplib::Cron::Hour     $hour             = 1,
  Simplib::Cron::MonthDay $monthday         = '*',
  Simplib::Cron::Month    $month            = '*',
  Simplib::Cron::Weekday  $weekday          = '*',
  Stdlib::Unixpath        $path             = '/usr/bin/rkhunter',
  Array[String[1]]        $options          = ['--skip-keypress', '--quiet']
) {

  $_opts = join($options,' ')

  if $systemd_calendar {
    $_systemd_calendar = $systemd_calendar
  }
  else {
    $_systemd_calendar = simplib::cron::to_systemd(
      $minute,
      $hour,
      $month,
      $monthday,
      $weekday
    )
  }

  $_timer = @("EOM")
  [Timer]
  OnCalendar=${_systemd_calendar}
  | EOM

  $_service = @("EOM")
  [Service]
  Type=oneshot
  ExecStart=${path} --check ${_opts}
  | EOM

  systemd::timer { 'puppet_rkhunter_check.timer':
    timer_content   => $_timer,
    service_content => $_service,
    active          => ($method == 'systemd'),
    enable          => ($method == 'systemd')
  }

  if $method == 'cron' {
    cron { 'rkhunter_check':
      command  => "${path} --check ${_opts}",
      minute   => $minute,
      hour     => $hour,
      month    => $month,
      monthday => $monthday,
      weekday  => $weekday
    }
  }
  else {
    cron { 'rkhunter_check': ensure => 'absent' }
  }
}
