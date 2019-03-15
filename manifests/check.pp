# Sets a cron job for rkhunter to check the system
#
# @param minute   Cron minute
# @param hour     Cron hour
# @param monthday Cron monthday
# @param month    Cron month
# @param weekday  Cron weekday
# @param options  Options to pass to ``rkhunter --check``
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#
class rkhunter::check (
  Simplib::Cron::Minute   $minute   = 25,
  Simplib::Cron::Hour     $hour     = 0,
  Simplib::Cron::MonthDay $monthday = '*',
  Simplib::Cron::Month    $month    = '*',
  Simplib::Cron::Weekday  $weekday  = '*',
  Array[String[1]]        $options  = [ '--skip-keypress', '--quiet' ]
) {

  $_opts = join($options, ' ')

  cron { 'rkhunter':
    command  => "rkhunter --check ${_opts}",
    minute   => $minute,
    hour     => $hour,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday
  }
}
