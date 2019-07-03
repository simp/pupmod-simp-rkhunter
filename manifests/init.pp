# @summary Installs rkhunter and sets up cron job to run rkhunter once per day
#
# @param check_for_updates
#   Check internet for definition updates
#
# @param enable_system_check
#   Set rkhunter to check the system on a regular basis
#
# @param install_optional_packages
#   Install packages that enhance the capabilities of rkhunter
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#
class rkhunter (
  Boolean $check_for_updates         = false,
  Boolean $enable_system_check       = true,
  Boolean $install_optional_packages = true
) {

  simplib::assert_metadata($module_name)

  include 'rkhunter::install'
  include 'rkhunter::config'

  Class['rkhunter::install'] -> Class['rkhunter::config']

  if $check_for_updates {
    include 'rkhunter::update'
    Class['rkhunter::config'] -> Class['rkhunter::update']
  }

  if $enable_system_check {
    include 'rkhunter::check'
    Class['rkhunter::config'] -> Class['rkhunter::check']
  }

  if $check_for_updates and $enable_system_check {
    Class['rkhunter::update'] -> Class['rkhunter::check']
  }
}
