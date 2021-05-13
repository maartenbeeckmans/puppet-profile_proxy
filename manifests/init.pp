#
class profile_proxy (
  Boolean $manage_ansible,
  Boolean $manage_iperf3,
) {
  if $manage_ansible {
    include profile_proxy::ansible,
  }

  if $manage_iperf3 {
    include profile_proxy::iperf3
  }
}
