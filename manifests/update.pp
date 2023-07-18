# @summary Add a scheduled job to update rkhunter
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
# @param options
#   Extra options to pass to `rkhunter --update`
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#
class rkhunter::update (
  Enum['cron','systemd']  $method           = 'systemd',
  Optional[String[1]]     $systemd_calendar = undef,
  Simplib::Cron::Minute   $minute           = fqdn_rand(59),
  Simplib::Cron::Hour     $hour             = 0,
  Simplib::Cron::MonthDay $monthday         = '*',
  Simplib::Cron::Month    $month            = '*',
  Simplib::Cron::Weekday  $weekday          = '*',
  Stdlib::Unixpath        $path             = '/usr/bin/rkhunter',
  Array[String[1]]        $options          = ['--nocolors']
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
  ExecStart=${path} --update ${_opts}
  | EOM

  systemd::timer { 'puppet_rkhunter_update.timer':
    timer_content   => $_timer,
    service_content => $_service,
    active          => ($method == 'systemd'),
    enable          => ($method == 'systemd')
  }

  if $method == 'cron' {
    cron { 'rkhunter_update':
      command  => "${path} --update ${_opts}",
      minute   => $minute,
      hour     => $hour,
      month    => $month,
      monthday => $monthday,
      weekday  => $weekday
    }
  }
  else {
    cron { 'rkhunter_update': ensure => 'absent' }
  }
}
