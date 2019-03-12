# Installs rkhunter and sets up cron job
# to run rkhunter once per day
#
# @param upd_minute   Cron minute for update check
# @param upd_hour     Cron hour for update check
# @param upd_monthday Cron monthday for update check
# @param upd_month    Cron month for update check
# @param upd_weekday  Cron weekday for update check
# @param minute       Cron minute
# @param hour         Cron hour
# @param monthday     Cron monthday
# @param month        Cron month
# @param weekday      Cron weekday
#
# @param package_ensure                The ensure status of packages to be managed
#
# @param rkhunter_conf_file            The path to the conf file
#
# @param rkhunter_conf_file_template   Template to use for the conf file
#
# @param check_for_updates             Check internet for definition updates
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#
class rkhunter (
  Simplib:Cron:Minute    $upd_minute                  = 5,
  Simplib:Cron:Hour      $upd_hour                    = 0,
  Simplib:Cron:MonthDay  $upd_monthday                = '*',
  Simplib:Cron:Month     $upd_month                   = '*',
  Simplib:Cron:Weekday   $upd_weekday                 = '*',
  String                 $upd_command                 = ,
  Simplib:Cron:Minute    $minute                      = 25,
  Simplib:Cron:Hour      $hour                        = 0,
  Simplib:Cron:MonthDay  $monthday                    = '*',
  Simplib:Cron:Month     $month                       = '*',
  Simplib:Cron:Weekday   $weekday                     = '*',
  String                 $command                     = ,
  Optional[Boolean]      $check_for_updates           = undef
  String[1]              $package_ensure              = simplib::lookup('simp_options::package_ensure', { 'default_value' => 'installed' }),
  Stdlib::Absolutepath   $rkhunter_conf_file          = '/etc/rkhunter.conf',
  Optional[Boolean]      $drop_rkhunter_complete_conf = undef,
  Stdlib::Absolutepath   $full_conf_drop_path         = '/etc/rkhunter.conf.README',
) {

  simplib::assert_metadata($module_name)

  include '::rkhunter::config'

  # Some tests require single-purpose tools, if rkhunter has
  # them then it will use them. Unhide is one such tool. 
  package { 'unhide':
    ensure => $package_ensure
  }

  package { 'rkhunter':
    ensure  => $package_ensure,
    require => Package['unhide']
  }

  file { $rkhunter_conf_file:
    ensure       => 'file',
    owner        => 'root',
    group        => 'root',
    mode         => '0640',
    content      => epp("${module_name}/rkhunter-conf.epp"),
    require      => Package['rkhunter']
    validate_cmd => 'rkhunter -C --configfile %'
  }

  if $drop_rkhunter_complete_conf {
    file { $full_conf_drop_path:
      path         => $full_conf_drop_path,
      ensure       => 'file',
      owner        => 'root',
      group        => 'root',
      mode         => '0440',
      content      => file("${module_name}/rkhunter.conf.README"),
      require      => Package['rkhunter']
      validate_cmd => "file %'
    }
  }

  if $check_for_updates {
    cron { 'rkhunter_update':
      command  => 'rkhunter --update --nocolors',
      minute   => $upd_minute,
      hour     => $upd_hour,
      month    => $upd_month,
      monthday => $upd_monthday,
      weekday  => $upd_weekday,
      require  => [ Package['rkhunter'], Package['unhide'], File[ $rkhunter_conf_file ] ]
    }
  }

  cron { 'rkhunter':
    command  => 'if test -f /var/lib/rkhunter/db/rkhunter.dat; then rkhunter --check --skip-keypress --quiet; else rkhunter --check --skip-keypress --quiet --propupd; fi',
    minute   => $minute,
    hour     => $hour,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday,
    require  => [ Package['rkhunter'], Package['unhide'], File[ $rkhunter_conf_file ] ]
  }
}
