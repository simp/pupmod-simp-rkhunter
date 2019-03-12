# @param allowdevfile
# @param allowhiddendir
# @param allowhiddenfile
# @param allowipcpid
# @param allowipcproc
# @param allowipcuser
# @param allowprocdelfile
# @param allowproclisten
# @param allowpromiscif
# @param allow_ssh_prot_v1
# @param allow_ssh_root_user
# @param allow_syslog_remote_logging
# @param append_log
# @param app_whitelist
# @param attrwhitelist
# @param auto_x_detect
# @param bindir
# @param color_set2
# @param copy_log_on_error
# @param dbdir
# @param disable_tests
# @param empty_logfiles
# @param enable_tests
# @param epoch_date_cmd
# @param exclude_user_fileprop_files_dirs
# @param existwhitelist
# @param globstar
# @param hash_cmd
# @param hash_fld_idx
# @param ignore_prelink_dep_err
# @param immutable_set
# @param immutwhitelist
# @param inetd_allowed_svc
# @param inetd_conf_path
# @param installdir
# @param ipc_seg_size
# @param language
# @param lock_timeout
# @param lockdir
# @param logfile
# @param mail_on_warning
# @param mail_cmd
# @param mirrors_mode
# @param missing_logfiles
# @param modules_dir
# @param os_version_file
# @param password_file
# @param phalanx2_dirtest
# @param pkgmgr_no_vrfy
# @param pkgmgr
# @param port_path_whitelist
# @param port_whitelist
# @param pwdless_accounts
# @param readlink_cmd
# @param rotate_mirrors
# @param rtkt_dir_whitelist
# @param rtkt_file_whitelist
# @param scan_mode_dev
# @param scanrootkitmode
# @param scriptdir
# @param scriptwhitelist
# @param shared_lib_whitelist
# @param show_lock_msgs
# @param show_summary_time
# @param show_summary_warning_number
# @param skip_inode_check
# @param ssh_config_dir
# @param startup_paths
# @param stat_cmd
# @param suspscan_dirs
# @param suspscan_maxsize
# @param suspscan_temp
# @param suspscan_thresh
# @param suspscan_whitelist
# @param syslog_config_file
# @param tmpdir
# @param uid0_accounts
# @param unhide_tests
# @param unhidetcp_opts
# @param update_lang
# @param update_mirrors
# @param updt_on_os_change
# @param use_locking
# @param user_fileprop_files_dirs
# @param use_sunsum
# @param use_syslog
# @param warn_on_os_change
# @param web_cmd
# @param whitelisted_is_white
# @param writewhitelist
# @param xinetd_allowed_svc
# @param xinetd_conf_path
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#

class rkhunter::config (
  Optional[Array[Stdlib::Unixpath]]
                              $allowdevfile                      = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $allowhiddendir                    = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $allowhiddenfile                   = undef,
  Optional[Array[Integer[1]]] $allowipcpid                       = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $allowipcproc                      = undef,
  Optional[Array[String[1]]]  $allowipcuser                      = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $allowprocdelfile                  = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $allowproclisten                   = undef,
  Optional[Array[String[1]]]  $allowpromiscif                    = undef,
  Integer[0,2]                $allow_ssh_prot_v1                 = 0,
  Enum['no','yes','unset']    $allow_ssh_root_user               = 'no',
  Integer[0,1]                $allow_syslog_remote_logging       = 0,
  Integer[0,1]                $append_log                        = 0,
  Optional[Array[String[1]]]  $app_whitelist                     = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $attrwhitelist                     = undef,
  Integer[0,1]                $auto_x_detect                     = 0,
  Optional[Array[Rkhunter::BindPath]]
                              $bindir                            = undef,
  Integer[0,1]                $color_set2                        = 0,
  Integer[0,1]                $copy_log_on_error                 = 0,
  Stdlib::Unixpath            $dbdir                             = '/var/lib/rkhunter/db',
  # While the default of rkhunter is to disable none of 
  # its tests, these tests are recommended to be disabled 
  # for normal runs due to their system intesive nature 
  # and the fact they are prone to false positives.
  Array[String[1]]            $disable_tests                     = ['suspscan hidden_ports hidden_procs deleted_files packet_cap_apps apps'],
  Optional[Array[Stdlib::Unixpath]]
                              $empty_logfiles                    = undef,
  Array[String[1]]            $enable_tests                      = ['ALL'],
  Optional[String[1]]         $epoch_date_cmd                    = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $exclude_user_fileprop_files_dirs  = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $existwhitelist                    = undef,
  Integer[0,1]                $globstar                          = 0,
  String[1]                   $hash_cmd                          = 'SHA256',
  Integer[1]                  $hash_fld_idx                      = 1,
  Optional[Array[Stdlib::Unixpath]]
                              $ignore_prelink_dep_err            = undef,
  Integer[0,1]                $immutable_set                     = 0,
  Optional[Array[Stdlib::Unixpath]]
                              $immutwhitelist                    = undef,
  Optional[Array[String[1]]]  $inetd_allowed_svc                 = undef,
  Optional[Stdlib::Unixpath]
                              $inetd_conf_path                   = undef,
  Stdlib::Unixpath            $installdir                        = '/usr',
  Integer[1]                  $ipc_seg_size                      = 1048576,
  String[1]                   $language                          = 'en',
  Integer[1]                  $lock_timeout                      = 300,
  Stdlib::Unixpath            $lockdir                           = '/var/run/lock',
  Stdlib::Unixpath            $logfile                           = '/var/log/rkhunter/rkhunter.log',
  Optional[Array[String[1]]]  $mail_on_warning                   = undef,
  String[1]                   $mail_cmd                          = 'mail -s "[rkhunter] Warnings found for ${HOST_NAME}"', # lint:ignore:single_quote_string_with_variables
  Integer[0,2]                $mirrors_mode                      = 0,
  Optional[Array[Stdlib::Unixpath]]
                              $missing_logfiles                  = undef,
  Optional[Stdlib::Unixpath]
                              $modules_dir                       = undef,
  Optional[Stdlib::Unixpath]
                              $os_version_file                   = undef,
  Optional[Stdlib::Unixpath]
                              $password_file                     = undef,
  Integer[0,1]                $phalanx2_dirtest                  = 0,
  Optional[Array[Stdlib::Unixpath]]
                              $pkgmgr_no_vrfy                    = undef,
  String[1]                   $pkgmgr                            = 'RPM',
  Optional[Array[Stdlib::Unixpath]]
                              $port_path_whitelist               = undef,
  Optional[Array[String[1]]]  $port_whitelist                    = undef,
  Optional[Array[String[1]]]  $pwdless_accounts                  = undef,
  Optional[String[1]]         $readlink_cmd                      = undef,
  Integer[0,1]                $rotate_mirrors                    = 1,
  Optional[Array[Stdlib::Unixpath]]
                              $rtkt_dir_whitelist                = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $rtkt_file_whitelist               = undef,
  Enum['THOROUGH','LAZY']     $scan_mode_dev                     = 'THOROUGH',
  Optional[Enum['THOROUGH']]  $scanrootkitmode                   = undef,
  Stdlib::Unixpath            $scriptdir                         = '/usr/share/rkhunter/scripts',
  Optional[Array[Stdlib::Unixpath]]
                              $scriptwhitelist                   = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $shared_lib_whitelist              = undef,
  Integer[0,1]                $show_lock_msgs                    = 1,
  Integer[0,3]                $show_summary_time                 = 3,
  Integer[0,1]                $show_summary_warning_number       = 0,
  Integer[0,1]                $skip_inode_check                  = 0,
  Stdlib::Unixpath            $ssh_config_dir                    = '/etc/ssh',
  Optional[Array[Stdlib::Unixpath]]
                              $startup_paths                     = undef, #suggestion: /etc/rc.d /etc/rc.local ??
  Optional[String[1]]         $stat_cmd                          = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $suspscan_dirs                     = undef,
  Integer[0]                  $suspscan_maxsize                  = 1024000,
  Stdlib::Unixpath            $suspscan_temp                     = '/dev/shm',
  Integer[0]                  $suspscan_thresh                   = 200,
  Optional[Array[Stdlib::Unixpath]]
                              $suspscan_whitelist                = undef,
  Optional[Array[Stdlib::Unixpath]]
                              $syslog_config_file                = undef,
  Stdlib::Unixpath            $tmpdir                            = '/var/lib/rkhunter',
  Optional[Array[String[1]]]  $uid0_accounts                     = undef,
  Array[String[1]]            $unhide_tests                      = ['sys'],
  Array[String]               $unhidetcp_opts                    = [''],
  Optional[Array[String[1]]]  $update_lang                       = undef,
  Integer[0,1]                $update_mirrors                    = 1,
  Integer[0,1]                $updt_on_os_change                 = 0,
  Integer[0,1]                $use_locking                       = 1,
  Optional[Array[Stdlib::Unixpath]]
                              $user_fileprop_files_dirs          = undef,
  Integer[0,1]                $use_sunsum                        = 0,
  #syslog verification, will combine in template to set rk's USE_SYSLOG
  #both of these values must be set to use syslog
  Simplib::Syslog::Facility   $syslog_facility                   = 'LOCAL6',
  Simplib::Syslog::Priority   $syslog_priority                   = 'NOTICE'
  Boolean                     $use_syslog                        = true,
  Integer[0,1]                $warn_on_os_change                 = 1,
  Optional[String[1]]         $web_cmd                           = undef, #shuold keep? rkhunter auto selects one
  Integer[0,1]                $whitelisted_is_white              = 0,
  Optional[Array[Stdlib::Unixpath]]
                              $writewhitelist                    = undef,
  Optional[Array[String[1]]]  $xinetd_allowed_svc                = undef,
  Optional[Stdlib::Unixpath]
                              $xinetd_conf_path                  = undef
) {

  if $use_syslog {
    unless $syslog_facility and $syslog_priority {
      error("Must supply a valid syslog_facility and syslog_priority if 'use_syslog = true'.")
    }
  }

}
