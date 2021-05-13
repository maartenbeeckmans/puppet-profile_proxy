#
#
#
class profile_proxy::iperf3 (
  Array[Integer] $ports,
  Boolean        $manage_package,
  Boolean        $manage_firewall,
  Boolean        $manage_sd_service,
  String         $sd_service_name,
  Array[String]  $sd_service_tags,
) {
  if $manage_package {
    package { 'iperf3':
      ensure => installed,
    }
  }

  user { 'iperf':
    ensure => 'present',
    system => true,
  }

  ::systemd::unit_file{ 'iperf3-server@.service':
    source => "puppet:///modules/${module_name}/iperf3-service@.service",
  }

  $ports.each | Integer $port | {
    service { "iperf3-server@${port}":
      ensure => 'running',
      enable => true,
    }

    if $manage_firewall {
      firewall { "0${port} allow iperf3":
        dport  => $port,
        action => 'accept',
      }
    }

    if $manage_sd_service {
      consul::service { "${sd_service_name}_${port}":
        service_name => $sd_service_name,
        checks       => [
          {
            tcp      => "${facts[networking][ip]}:${port}",
            interval => '10s',
          }
        ],
        port         => $port,
        tags         => $sd_service_tags,
      }
    }
  }
}
