#
#
#
class profile_proxy::wake_on_lan (
  String $concat_target = '/usr/local/bin/wake_up_nucs.sh',
) {
  concat { $concat_target:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  concat::fragment { 'wol_header':
    target  => $concat_target,
    content => "#!/bin/bash\n",
    order   => '1',
  }

  Profile_proxy::Wake_on_lan::Host <<| |>>

  package { 'wol':
    ensure => present,
  }
}
