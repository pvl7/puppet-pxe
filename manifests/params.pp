class pxeboot::params {

  $packages = [
    'tftp-server',
    'syslinux',
    'httpd',
    'dhcp',
  ]

  # kickstart network parameters
  # change to whatever is needed
  $pxe_server_ip           = '192.168.15.250'
  $pxe_dhcp_subnet         = '192.168.15.0'
  $pxe_dhcp_subnet_netmask = '255.255.255.0'
  $pxe_dhcp_pool           = '192.168.15.120 192.168.15.125'
  #

  $tftp_src_files        = '/usr/share/syslinux'
  $tftp_root_dir         = '/tftpboot'
  $tftp_iso_mount_point  = 'iso/x86_64'
  $tftp_ks_dir           = "${tftp_root_dir}/ks"
  $pxelinux_cfg_dir      = "${tftp_root_dir}/pxelinux.cfg"
  $tftp_iso_dir          = "${tftp_root_dir}/${tftp_iso_mount_point}"

  $pxe_xinetd_conf          = "/etc/xinetd.d/tftp"
  $pxe_dhcpd_conf           = "/etc/dhcp/dhcpd.conf"
  $pxe_httpd_conf           = "/etc/httpd/conf.d/pxeboot.conf"
  $pxe_default_conf         = "${pxelinux_cfg_dir}/default"
  #  $pxe_ks_centos6_conf      = "${tftp_ks_dir}/centos6.cfg"
  #  $pxe_ks_centos7_conf      = "${tftp_ks_dir}/centos7.cfg"
  #  $pxe_ks_centos7_bond_conf = "${tftp_ks_dir}/centos7bond.cfg"

  $pxe_ks_config_menu = {
    'item1'  => { 
      hotkey => '0',
      config => 'centos7.cfg',
      label  => 'Centos 7 x86_64',
      },
    'item2'  => { 
      hotkey => '1',
      config => 'centos7bond.cfg',
      label  => 'Centos 7 (with NIC bonding) x86_64',
      },
    'item3'  => { 
      hotkey => '2',
      config => 'centos6.cfg',
      label  => 'Centos 6 x86_64',
      },
  }

  $tftp_dirs = [
    $tftp_root_dir,
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
