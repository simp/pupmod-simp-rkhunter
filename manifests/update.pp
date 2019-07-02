# @summary Add a cron job to check for rkhunter updates
#
# @param minute   Cron minute
# @param hour     Cron hour
# @param monthday Cron monthday
# @param month    Cron month
# @param weekday  Cron weekday
# @param options  Extra options to pass to ``rkhunter --update``
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#
class rkhunter::update (
  Simplib::Cron::Minute   $minute   = 5,
  Simplib::Cron::Hour     $hour     = 0,
  Simplib::Cron::MonthDay $monthday = '*',
  Simplib::Cron::Month    $month    = '*',
  Simplib::Cron::Weekday  $weekday  = '*',
  Array[String[1]]        $options  = ['--nocolors']
) {

  $_opts = join($options,' ')

  cron { 'rkhunter_update':
    command  => "rkhunter --update ${_opts}",
    minute   => $minute,
    hour     => $hour,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday
  }
}
