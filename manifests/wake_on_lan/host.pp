#
#
#
define profile_proxy::wake_on_lan::host (
  Stdlib::MAC                   $mac,
  Stdlib::IP::Address::Nosubnet $ip,
  Stdlib::Fqdn                  $hostname      = $title,
  String                        $concat_target = '/usr/local/bin/wake_up_nucs.sh',
) {
  $_wol_config = {
    'hostname' => $hostname,
    'mac'      => $mac,
    'ip'       => $ip,
  }

  $_wol_template = @(EOT)
  <%- | $hostname, $mac, $ip | -%>

  echo ''
  echo 'Waking up <%= $hostname %>'
  wol --verbose --wait=1000 <%= $mac %>
  wol --verbose --wait=1000 --ipaddr=<%= $ip %> <%= $mac %>
  sleep 1
  | EOT

  concat::fragment { $title:
    target  => $concat_target,
    content => inline_epp($_wol_template, $_wol_config),
    order   => '10',
  }
}
