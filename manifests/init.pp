#
class profile_proxy (
  Boolean $manage_ansible,
  Boolean $manage_iperf3,
  Boolean $manage_terraform,
  Boolean $manage_wol,
) {
  if $manage_ansible {
    include profile_proxy::ansible
  }

  if $manage_iperf3 {
    include profile_proxy::iperf3
  }

  if $manage_terraform {
    include profile_proxy::terraform
  }

  if $manage_wol {
    include profile_proxy::wake_on_lan
  }
}
