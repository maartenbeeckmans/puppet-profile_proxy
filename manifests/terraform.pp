#
#
#
class profile_proxy::terraform (
  Boolean $manage_repo,
) {
  if $manage_repo {
    include hashi_stack::repo
  }

  package { 'terraform':
    ensure => present,
  }
}
