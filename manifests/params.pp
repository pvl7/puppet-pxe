class pxeboot::params {

  $packages = [
    'tftp-server',
    'syslinux',
    'httpd',
    'dhcp',
  ]

  $tftp_src_files   = '/usr/share/syslinux'
  $tftp_root_dir    = '/tftpboot'
  $tftp_ks_dir      = "${tftp_root_dir}/ks"
  $pxelinux_cfg_dir = "${tftp_dir}/pxelinux.cfg"
  $tftp_iso_dir     = "${tftp_dir}/iso"
  $tftp_centos6_iso = "${tftp_iso_dir}/centos6"
  $tftp_centos7_iso = "${tftp_iso_dir}/centos7"

  $pxe_xinetd_conf  = "/etc/xinetd.d/tftp"
  $pxe_dhcpd_conf   = "/etc/dhcp/dhcpd.conf"
  $pxe_httpd_conf   = "/etc/httpd/conf.d/pxeboot.conf"
  $pxe_default_conf = "${pxelinux_cfg_dir}/default"
  $pxe_ks_centos6_conf = "${tftp_ks_dir}/centos6.cfg"
  $pxe_ks_centos7_conf = "${tftp_ks_dir}/centos7.cfg"

  $tftp_dirs = [
    $tftp_root_dir,
    $tftp_ks_dir,
    $pxelinux_cfg_dir,
    $tftp_centos6_iso,
    $tftp_centos7_iso,
  ]

  $tftp_files = [
    'pxelinux.0',
    'menu.c32',
    'memdisk',
    'mboot.c32',
    'chain.c32',
  ]
}
