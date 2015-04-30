class pxeboot::params {

  # kickstart network parameters
  # change to whatever is needed
  $pxe_server_ip           = '192.168.15.250'
  $pxe_dhcp_subnet         = '192.168.15.0'
  $pxe_dhcp_subnet_netmask = '255.255.255.0'
  $pxe_dhcp_pool           = '192.168.15.120 192.168.15.125'

  # Bootstrap menu. The kickstart profile has to be pre-created in files/
  $pxe_ks_config_menu = {
    item1  => { 
      label   => '0',
      config  => 'centos7.cfg',
      title   => 'Centos 7 x86_64',
      },
    item2  => { 
      label   => '1',
      config  => 'centos7-cluster1.cfg',
      title   => 'Centos 7 Cluster Node 1 x86_64',
      },
    item3  => { 
      label   => '2',
      config  => 'centos7-cluster2.cfg',
      title   => 'Centos 7 Cluster Node 2 x86_64',
      },
    item4  => { 
      label   => '3',
      config  => 'centos6.cfg',
      title   => 'Centos 6 x86_64',
      },
  }

  # kickstart profile files provisioning
  $pxe_ks_files = [
    'centos7.cfg',
    'centos7-cluster1.cfg',
    'centos7-cluster2.cfg',
    'centos6.cfg',
  ]
  ### end of configurable section ###

  $packages = [
    'tftp-server',
    'syslinux',
    'httpd',
    'dhcp',
  ]

  $tftp_src_files        = '/usr/share/syslinux'
  $tftp_root_dir         = '/tftpboot'
  $tftp_iso_mount_point  = 'iso/x86_64'
  $tftp_iso_image_dir    = "${tftp_root_dir}/iso"
  $tftp_ks_dir           = "${tftp_root_dir}/ks"
  $pxelinux_cfg_dir      = "${tftp_root_dir}/pxelinux.cfg"
  $tftp_iso_dir          = "${tftp_root_dir}/${tftp_iso_mount_point}"

  $pxe_xinetd_conf          = "/etc/xinetd.d/tftp"
  $pxe_dhcpd_conf           = "/etc/dhcp/dhcpd.conf"
  $pxe_httpd_conf           = "/etc/httpd/conf.d/pxeboot.conf"
  $pxe_default_conf         = "${pxelinux_cfg_dir}/default"


  $tftp_dirs = [
    $tftp_root_dir,
    $tftp_iso_image_dir,
    $tftp_ks_dir,
    $tftp_iso_dir,
    $pxelinux_cfg_dir,
  ]

  $tftp_files = [
    'pxelinux.0',
    'menu.c32',
    'memdisk',
    'mboot.c32',
    'chain.c32',
  ]
}
