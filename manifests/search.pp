# Public: Manage search domain entries in /etc/resolv.conf.
#
# namevar  - The search domain name as a String.
# priority - The optional priority of the search domain as an Integer.  If a
#            value between 0 and 5 is provided, the entry will be the first
#            through sixth search domain respectively.
# ensure   - The desired state of the resource as a String.  Valid values are
#            'absent' and 'present' (default: 'present').
#
# Examples
#
#   resolvconf::search {[
#     'foo.test.com',
#     'test.com',
#   ]}
define resolvconf::search($ensure = 'present') {
  case $ensure {
    'present': {
      augeas { "Adding search domain '${name}' to /etc/resolv.conf":
        context => '/files/etc/resolv.conf',
        changes => "set search/domain ${name}",
        onlyif  => "match search/domain[.='${name}'] size == 0",
      }
    }
    'absent': {
      augeas { "Removing search domain '${name}' from /etc/resolv.conf":
        context => '/files/etc/resolv.conf',
        changes => "rm search",
      }
    }
    default: {
      fail("Invalid ensure value passed to Resolvconf::Search[${name}]")
    }
  }
}
