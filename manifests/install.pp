# @summary Install rkhunter
#
# @param install_optional_packages
#   Install optional packages that enable additional functionality in rkhunter
#
# @param optional_packages
#   The list of optional packages to be installed
#
#   This may be anything that the puppetlabs-stdlib ``ensure_packages``
#   function accepts
#
# @param optional_package_ensure
#   The state in which to place all packages
#
# @param rkhunter_package_ensure
#   The state in which to place the rkhunter package. May be specifically
#   pinned.
#
# @author https://github.com/simp/pupmod-simp-rkhunter/graphs/contributors
#
class rkhunter::install (
  Variant[Hash[String[1],Hash],Array[String[1]]] $optional_packages, #Data in modules
  Boolean                                        $install_optional_packages = $rkhunter::install_optional_packages,
  Simplib::PackageEnsure                         $optional_package_ensure   = simplib::lookup('simp_options::package_ensure', { 'default_value' => 'installed' }),
  String[1]                                      $rkhunter_package_ensure   = simplib::lookup('simp_options::package_ensure', { 'default_value' => 'installed' })
) {
  assert_private()

  if $install_optional_packages{
    ensure_packages($optional_packages, {'ensure' => $optional_package_ensure})
  }

  package { 'rkhunter': ensure => $rkhunter_package_ensure }
}
