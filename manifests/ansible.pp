#
#
#
class profile_proxy::ansible {
  package { 'ansible':
    ensure => present,
  }
}
