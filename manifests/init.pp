# Sets up rkhunter to be run once per day
#
# @param minute_upd   Cron minute for update check
# @param hour_upd     Cron hour for update check
# @param monthday_upd Cron monthday for update check
# @param month_upd    Cron month for update check
# @param weekday_upd  Cron weekday for update check
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
  String[1]         $minute_upd                      = '0',
  String[1]         $hour_upd                        = '0',
  String[1]         $monthday_upd                    = '*',
  String[1]         $month_upd                       = '*',
  String[1]         $weekday_upd                     = '*',
  String[1]         $minute                          = '10',
  String[1]         $hour                            = '0',
  String[1]         $monthday                        = '*',
  String[1]         $month                           = '*',
  String[1]         $weekday                         = '*',
  String[1]         $package_ensure                  = 'latest',
  Optional[String[1]]  $rkhunter_conf_file           = '/etc/rkhunter.conf',
  Optional[String[1]]  $rkhunter_conf_file_template  = 'rkhunter/rkhunter-conf.erb',
  Optional[Boolean]    $check_for_updates            = undef,
############start of rkhunter.conf options
  Optional[Array[String[1]]]  $allowdevfile                      =  undef,
  Optional[Array[String[1]]]  $allowhiddendir                    =  undef,
  Optional[Array[String[1]]]  $allowhiddenfile                   =  undef,
  Optional[Array[String[1]]]  $allowipcpid                       =  undef,
  Optional[Array[String[1]]]  $allowipcproc                      =  undef,
  Optional[Array[String[1]]]  $allowipcuser                      =  undef,
  Optional[Array[String[1]]]  $allowprocdelfile                  =  undef,
  Optional[Array[String[1]]]  $allowproclisten                   =  undef,
  Optional[Array[String[1]]]  $allowpromiscif                    =  undef,
  Integer[0,2]                $allow_ssh_prot_v1                 =  0,
  Enum['no','yes','unset']    $allow_ssh_root_user               =  'no',
  Integer[0,1]                $allow_syslog_remote_logging       =  0,
  Integer[0,1]                $append_log                        =  0,
  Optional[Array[String[1]]]  $app_whitelist                     =  undef,
  Optional[Array[String[1]]]  $attrwhitelist                     =  undef,
  Integer[0,1]                $auto_x_detect                     =  0,
  Optional[Array[String[1]]]  $bindir                            =  undef,
  Integer[0,1]                $color_set2                        =  0,
  Integer[0,1]                $copy_log_on_error                 =  0,
  Optional[String[1]]         $dbdir                             =  undef,
  Optional[Array[String[1]]]  $disable_tests                     =  undef,
  Optional[Array[String[1]]]  $empty_logfiles                    =  undef,
  Optional[Array[String[1]]]  $enable_tests                      =  ['ALL'],
  Optional[String[1]]         $epoch_date_cmd                    =  undef,
  Optional[Array[String[1]]]  $exclude_user_fileprop_files_dirs  =  undef,
  Optional[Array[String[1]]]  $existwhitelist                    =  undef,
  Integer[0,1]                $globstar                          =  0,
  String[1]                   $hash_cmd                          =  'SHA256',
  Integer[1]                  $hash_fld_idx                      =  1,
  Optional[Array[String[1]]]  $ignore_prelink_dep_err            =  undef,
  Integer[0,1]                $immutable_set                     =  0,
  Optional[Array[String[1]]]  $immutwhitelist                    =  undef,
  Optional[Array[String[1]]]  $inetd_allowed_svc                 =  undef,
  Optional[String[1]]         $inetd_conf_path                   =  undef,
  Optional[String[1]]         $installdir                        =  undef,
  Integer[1]                  $ipc_seg_size                      =  1048576,
  String[1]                   $language                          =  'en',
  String[1]                   $logfile                           =  '/var/log/rkhunter/rkhunter.log',
  Optional[String[1]]         $mail_on_warning                   =  undef,
  String[1]                   $mail_cmd                          =  'mail -s "[rkhunter] Warnings found for ${HOST_NAME}"', # lint:ignore:single_quote_string_with_variables
  Integer[0,2]                $mirrors_mode                      =  0,
  Optional[Array[String[1]]]  $missing_logfiles                  =  undef,
  Optional[String[1]]         $modules_dir                       =  undef,
  Optional[String[1]]         $os_version_file                   =  undef,
  Optional[String[1]]         $password_file                     =  undef, #should keep? suggestion: /etc/shadow
  Integer[0,1]                $phalanx2_dirtest                  =  0,
  Optional[Array[String[1]]]  $pkgmgr_no_vrfy                    =  undef,
  String[1]                   $pkgmgr                            =  'RPM',
  Optional[Array[String[1]]]  $port_path_whitelist               =  undef,
  Optional[Array[String[1]]]  $port_whitelist                    =  undef,
  Optional[Array[String[1]]]  $pwdless_accounts                  =  undef,
  Optional[String[1]]         $readlink_cmd                      =  undef,
  Integer[0,1]                $rotate_mirrors                    =  1,
  Optional[Array[String[1]]]  $rtkt_dir_whitelist                =  undef,
  Optional[Array[String[1]]]  $rtkt_file_whitelist               =  undef,
  Enum['THOROUGH','LAZY']     $scan_mode_dev                     =  'THOROUGH',
  Optional[String[1]]         $scriptdir                         =  undef,
  Optional[Array[String[1]]]  $scriptwhitelist                   =  undef,
  Optional[Array[String[1]]]  $shared_lib_whitelist              =  undef,
  Integer[0,1]                $skip_inode_check                  =  0,
  Optional[String[1]]         $ssh_config_dir                    =  undef,
  Optional[Array[String[1]]]  $startup_paths                     =  undef, #suggestion: /etc/rc.d /etc/rc.local ??
  Optional[String[1]]         $stat_cmd                          =  undef,
  Optional[Array[String[1]]]  $suspscan_dirs                     =  ['/tmp /var/tmp'],
  Integer                     $suspscan_maxsize                  =  1024000,
  String[1]                   $suspscan_temp                     =  '/dev/shm',
  Integer                     $suspscan_thresh                   =  200,
  Optional[Array[String[1]]]  $suspscan_whitelist                =  undef,
  Optional[Array[String[1]]]  $syslog_config_file                =  undef,
  Optional[String[1]]         $tmpdir                            =  undef,
  Optional[Array[String[1]]]  $uid0_accounts                     =  undef,
  Optional[Array[String[1]]]  $update_lang                       =  undef,
  Integer[0,1]                $update_mirrors                    =  1,
  Integer[0,1]                $updt_on_os_change                 =  0,
  Integer[0,1]                $use_locking                       =  1,
  Optional[Array[String[1]]]  $user_fileprop_files_dirs          =  undef,
  Integer[0,1]                $use_sunsum                        =  0,
  String[1]                   $use_syslog                        =  'NONE', #recommend authpriv.notice??
  Integer[0,1]                $warn_on_os_change                 =  1,
  Optional[String[1]]         $web_cmd                           =  undef, #shuold keep? rkhunter auto selects one
  Integer[0,1]                $whitelisted_is_white              =  0,
  Optional[Array[String[1]]]  $writewhitelist                    =  undef,
  Optional[Array[String[1]]]  $xinetd_allowed_svc                =  undef,
  Optional[String[1]]         $xinetd_conf_path                  =  undef
) {

  package { 'unhide':
    ensure => $package_ensure
  }

  package { 'rkhunter':
    ensure  => $package_ensure,
    require => Package['unhide']
  }

  file { $rkhunter_conf_file:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    path    => '/etc/rkhunter.conf',
    content => template($rkhunter_conf_file_template),
    require => Package['rkhunter']
  }

  if $check_for_updates {
    cron { 'rkhunter_update':
      command  => 'rkhunter --update --nocolors',
      minute   => $minute_upd,
      hour     => $hour_upd,
      month    => $month_upd,
      monthday => $monthday_upd,
      weekday  => $weekday_upd,
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
