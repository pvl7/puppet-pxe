class pxeboot (
  $packages            = $pxeboot::params::packages,
  $tftp_dirs           = $pxeboot::params::tftp_dirs,
  $tftp_files          = $pxeboot::params::tftp_files,
  $tftp_src_files      = $pxeboot::params::tftp_src_files,
  $tftp_root_dir       = $pxeboot::params::tftp_root_dir,
  $tftp_ks_dir         = $pxeboot::params::tftp_ks_dir,
  $tftp_iso_dir        = $pxeboot::params::tftp_iso_dir,
  $pxe_xinetd_conf     = $pxeboot::params::pxe_xinetd_conf,
  $pxe_httpd_conf      = $pxeboot::params::pxe_httpd_conf,
  $pxe_dhcpd_conf      = $pxeboot::params::pxe_dhcpd_conf,
  $pxe_default_conf    = $pxeboot::params::pxe_default_conf,
  $pxe_ks_centos6_conf = $pxeboot::params::pxe_ks_centos6_conf,
  $pxe_ks_centos7_conf = $pxeboot::params::pxe_ks_centos7_conf,
){

  package {$packages:
    ensure => installed,
  } ->
  file {$tftp_dirs:
    ensure => directory,
  } ->
  filecopy {$tftp_files:
    src_dir => $tftp_src_files,
    dst_dir => $tftp_root_dir,
  }
  file {$pxe_xinetd_conf:
    ensure  => present,
    content => template("pxeboot/tftp.erb"),
    notify  => Service["xinetd"],
    require => Package["xinetd"],
  }
  file {$pxe_httpd_conf:
    ensure  => present,
    content => template("pxeboot/pxeboot.conf-httpd.erb"),
    notify  => Service["httpd"],
    require => Package["httpd"],
  }
  file {$pxe_dhcpd_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/dhcpd.conf",
    notify => Service["dhcpd"],
    require => Package["dhcp"],
  }
  file {$pxe_default_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/tftpboot-default",
  }
  file {$pxe_ks_centos6_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/centos6.cfg",
  }
  file {$pxe_ks_centos7_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/centos7.cfg",
  }

  service {'httpd':
    ensure   => running,
    enable   => true,
  }
  service {'dhcpd':
    ensure   => running,
    enable   => true,
  }
  service {'xinetd':
    ensure   => running,
    enable   => true,
  }

}

define filecopy (
  $src_dir,
  $dst_dir,
){
  file {"${dst_dir}/${name}":
    ensure => present,
    source => "${src_dir}/${name}",
  }
}
