# Configure rkhunter
#
# Any parameter that is not documented below matches its direct counterpart in
# the rkhunter.conf configuration file.
#
# You may need to extract a copy from the RPM for the full documentation set.
#
# Any deviations from the defaults are noted here and any defaults that are set
# here relate to either performance or system security safety.
#
# @param allowdevfile
#   In module data
# @param allowhiddendir
#   In module data
# @param allowhiddenfile
#   In module data
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
#   While the default of rkhunter is to disable none of its tests, these tests
#   are recommended to be disabled for normal runs due to their system intesive
#   nature and the fact they are prone to false positives.
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
# @param tcp_port_whitelist
#   TCP Ports to add to the PORT_WHITELIST option
# @param udp_port_whitelist
#   UDP Ports to add to the PORT_WHITELIST option
# @param pwdless_accounts
# @param readlink_cmd
# @param rotate_mirrors
# @param rtkt_dir_whitelist
# @param rtkt_file_whitelist
# @param scan_mode_dev
# @param scanrootkitmode
#   WARNING: Do not enable this parameter unless you 100% understand what it
#   can do to your system performance!
# @param scriptdir
# @param scriptwhitelist
# @param shared_lib_whitelist
# @param show_lock_msgs
# @param show_summary_time
# @param show_summary_warnings_number
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
  Array[Stdlib::Unixpath]             $allowhiddendir,
  Array[Stdlib::Unixpath]             $allowhiddenfile,
  Array[Stdlib::Unixpath]             $allowdevfile,
  Optional[Array[Stdlib::Unixpath]]   $scriptwhitelist                  = undef,
  Optional[Array[Integer[1]]]         $allowipcpid                      = undef,
  Optional[Array[Stdlib::Unixpath]]   $allowipcproc                     = undef,
  Optional[Array[String[1]]]          $allowipcuser                     = undef,
  Optional[Array[Stdlib::Unixpath]]   $allowprocdelfile                 = undef,
  Optional[Array[Stdlib::Unixpath]]   $allowproclisten                  = undef,
  Optional[Array[String[1]]]          $allowpromiscif                   = undef,
  Boolean                             $allow_ssh_prot_v1                = false,
  Variant[Boolean,Enum['unset']]      $allow_ssh_root_user              = false,
  Boolean                             $allow_syslog_remote_logging      = true,
  Boolean                             $append_log                       = false,
  Optional[Array[String[1]]]          $app_whitelist                    = undef,
  Optional[Array[Stdlib::Unixpath]]   $attrwhitelist                    = undef,
  Boolean                             $auto_x_detect                    = true,
  Optional[Array[Rkhunter::BindPath]] $bindir                           = undef,
  Boolean                             $color_set2                       = false,
  Boolean                             $copy_log_on_error                = false,
  Stdlib::Unixpath                    $dbdir                            = '/var/lib/rkhunter/db',
  Array[String]                       $disable_tests                    = ['suspscan', 'hidden_ports', 'hidden_procs', 'deleted_files', 'packet_cap_apps', 'apps'],
  Optional[Array[Stdlib::Unixpath]]   $empty_logfiles                   = undef,
  Array[String[1]]                    $enable_tests                     = ['ALL'],
  Optional[String[1]]                 $epoch_date_cmd                   = undef,
  Optional[Array[Stdlib::Unixpath]]   $exclude_user_fileprop_files_dirs = undef,
  Optional[Array[Stdlib::Unixpath]]   $existwhitelist                   = undef,
  Boolean                             $globstar                         = true,
  Optional[String[1]]                 $hash_cmd                         = undef,
  Optional[Integer[1]]                $hash_fld_idx                     = undef,
  Optional[Array[Stdlib::Unixpath]]   $ignore_prelink_dep_err           = undef,
  Boolean                             $immutable_set                    = false,
  Optional[Array[Stdlib::Unixpath]]   $immutwhitelist                   = undef,
  Optional[Array[String[1]]]          $inetd_allowed_svc                = undef,
  Optional[Stdlib::Unixpath]          $inetd_conf_path                  = undef,
  Stdlib::Unixpath                    $installdir                       = '/usr',
  Optional[Integer[1]]                $ipc_seg_size                     = undef,
  Optional[String[1]]                 $language                         = undef,
  Optional[Integer[1]]                $lock_timeout                     = undef,
  Stdlib::Unixpath                    $lockdir                          = '/var/run/lock',
  Stdlib::Unixpath                    $logfile                          = '/var/log/rkhunter/rkhunter.log',
  Optional[Array[String[1]]]          $mail_on_warning                  = undef,
  String[1]                           $mail_cmd                         = 'mail -s "[rkhunter] Warnings found for ${HOST_NAME}"', # lint:ignore:single_quote_string_with_variables
  Enum['any','local','remote']        $mirrors_mode                     = 'any',
  Optional[Array[Stdlib::Unixpath]]   $missing_logfiles                 = undef,
  Optional[Stdlib::Unixpath]          $modules_dir                      = undef,
  Optional[Stdlib::Unixpath]          $os_version_file                  = undef,
  Optional[Stdlib::Unixpath]          $password_file                    = undef,
  Boolean                             $phalanx2_dirtest                 = false,
  Optional[Array[Stdlib::Unixpath]]   $pkgmgr_no_vrfy                   = undef,
  String[1]                           $pkgmgr                           = 'RPM',
  Optional[Array[Stdlib::Unixpath]]   $port_path_whitelist              = undef,
  Optional[Array[Simplib::Port]]      $tcp_port_whitelist               = undef,
  Optional[Array[Simplib::Port]]      $udp_port_whitelist               = undef,
  Optional[Array[String[1]]]          $pwdless_accounts                 = undef,
  Optional[String[1]]                 $readlink_cmd                     = undef,
  Boolean                             $rotate_mirrors                   = true,
  Optional[Array[Stdlib::Unixpath]]   $rtkt_dir_whitelist               = undef,
  Optional[Array[Stdlib::Unixpath]]   $rtkt_file_whitelist              = undef,
  Enum['THOROUGH','LAZY']             $scan_mode_dev                    = 'THOROUGH',
  Boolean                             $scanrootkitmode                  = false,
  Stdlib::Unixpath                    $scriptdir                        = '/usr/share/rkhunter/scripts',
  Optional[Array[Stdlib::Unixpath]]   $shared_lib_whitelist             = undef,
  Boolean                             $show_lock_msgs                   = true,
  Integer[0,3]                        $show_summary_time                = 3,
  Boolean                             $show_summary_warnings_number     = false,
  Boolean                             $skip_inode_check                 = false,
  Optional[Stdlib::Unixpath]          $ssh_config_dir                   = undef,
  Optional[Array[Stdlib::Unixpath]]   $startup_paths                    = undef,
  Optional[String[1]]                 $stat_cmd                         = undef,
  Optional[Array[Stdlib::Unixpath]]   $suspscan_dirs                    = undef,
  Integer[0]                          $suspscan_maxsize                 = 1024000,
  Stdlib::Unixpath                    $suspscan_temp                    = '/dev/shm',
  Integer[0]                          $suspscan_thresh                  = 200,
  Optional[Array[Stdlib::Unixpath]]   $suspscan_whitelist               = undef,
  Optional[Array[Stdlib::Unixpath]]   $syslog_config_file               = undef,
  Stdlib::Unixpath                    $tmpdir                           = '/var/lib/rkhunter',
  Optional[Array[String[1]]]          $uid0_accounts                    = undef,
  Optional[Array[String[1]]]          $unhide_tests                     = undef,
  Optional[Array[String[1]]]          $unhidetcp_opts                   = undef,
  Optional[Array[String[1]]]          $update_lang                      = undef,
  Boolean                             $update_mirrors                   = true,
  Boolean                             $updt_on_os_change                = false,
  Boolean                             $use_locking                      = true,
  Optional[Array[Stdlib::Unixpath]]   $user_fileprop_files_dirs         = undef,
  Boolean                             $use_sunsum                       = false,
  Simplib::Syslog::Priority           $syslog_priority                  = 'LOCAL6.NOTICE',
  Boolean                             $use_syslog                       = true,
  Boolean                             $warn_on_os_change                = true,
  Optional[String[1]]                 $web_cmd                          = undef,
  Boolean                             $whitelisted_is_white             = false,
  Optional[Array[Stdlib::Unixpath]]   $writewhitelist                   = undef,
  Optional[Array[String[1]]]          $xinetd_allowed_svc               = undef,
  Optional[Stdlib::Unixpath]          $xinetd_conf_path                 = undef
) {
  assert_private()

  exec { 'propupd':
    command => 'rkhunter --propupd',
    creates => "${dbdir}/rkhunter.dat",
    path    => ['/bin', '/usr/bin']
  }

  if $use_syslog {
    unless $syslog_priority {
      error("Must supply a valid syslog_priority if 'use_syslog = true'.")
    }
  }

  file { '/tmp/rkhunter.conf':
    ensure       => 'file',
    owner        => 'root',
    group        => 'root',
    mode         => '0640',
    content      => epp("${module_name}/rkhunter-conf.epp")
  }

  file { '/etc/rkhunter.conf':
    ensure       => 'file',
    owner        => 'root',
    group        => 'root',
    mode         => '0640',
    content      => epp("${module_name}/rkhunter-conf.epp"),
    validate_cmd => 'PATH=/sbin:/bin:/usr/sbin:/usr/bin rkhunter -C --configfile %'
  }
}
