# @summary Immediately update the properties database
#
# Needed so that each run after installation does not trigger false positives
class rkhunter::propupd (
  Stdlib::Unixpath $datfile,
  Boolean $enable = true,
){
  if $enable {
    assert_private()

    exec { "${module_name}_propupd":
      command => 'rkhunter --propupd',
      creates => $datfile,
      path    => ['/bin','/usr/bin']
    }
  }
}
