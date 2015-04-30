class pxeboot (
  $packages                     = $pxeboot::params::packages,
  $pxe_server_ip                = $pxeboot::params::pxe_server_ip,
  $pxe_dhcp_subnet              = $pxeboot::params::pxe_dhcp_subnet,
  $pxe_dhcp_subnet_netmask      = $pxeboot::params::pxe_dhcp_subnet_netmask,
  $pxe_dhcp_pool                = $pxeboot::params::pxe_dhcp_pool,
  $tftp_dirs                    = $pxeboot::params::tftp_dirs,
  $tftp_files                   = $pxeboot::params::tftp_files,
  $tftp_src_files               = $pxeboot::params::tftp_src_files,
  $tftp_root_dir                = $pxeboot::params::tftp_root_dir,
  $tftp_ks_dir                  = $pxeboot::params::tftp_ks_dir,
  $tftp_iso_mount_point         = $pxeboot::params::tftp_iso_mount_point,
  $tftp_iso_dir                 = $pxeboot::params::tftp_iso_dir,
  $pxe_xinetd_conf              = $pxeboot::params::pxe_xinetd_conf,
  $pxe_httpd_conf               = $pxeboot::params::pxe_httpd_conf,
  $pxe_dhcpd_conf               = $pxeboot::params::pxe_dhcpd_conf,
  $pxe_default_conf             = $pxeboot::params::pxe_default_conf,
  $pxe_ks_config_menu           = $pxeboot::params::pxe_ks_config_menu,
){

  package {$packages:
    ensure => installed,
  } ->
  file {$tftp_dirs:
    ensure => directory,
  } ->
  build_kickstart_env {$tftp_files:
    src_dir => $tftp_src_files,
    dst_dir => $tftp_root_dir,
    require => File["${tftp_root_dir}"]
  }
  create_kickstart_profiles {$pxe_ks_files:
    dst_dir => $tftp_ks_dir,
    require => File["${tftp_ks_dir}"],
  }
  file {$pxe_httpd_conf:
  file {$pxe_xinetd_conf:
    ensure  => present,
    content => template("${module_name}/tftp.erb"),
    notify  => Service["xinetd"],
    require => Package["tftp-server"],
  }
  file {$pxe_httpd_conf:
    ensure  => present,
    content => template("${module_name}/pxeboot.conf-httpd.erb"),
    notify  => Service["httpd"],
    require => Package["httpd"],
  }
  file {$pxe_dhcpd_conf:
    ensure  => present,
    content => template("${module_name}/dhcpd.conf.erb"),
    notify  => Service["dhcpd"],
    require => Package["dhcp"],
  }
  file {$pxe_default_conf:
    ensure  => present,
    content => template("${module_name}/tftpboot-default.erb"),
  }

  mount {"${tftp_iso_dir}":
    device    => '/dev/cdrom',
    fstype    => 'iso9660',
    options   => 'defaults',
    remounts  => false,
    atboot    => true,
    ensure    => mounted,
    require   => File["${tftp_iso_dir}"],
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

# defined type to build pxe tftp boot environment
define build_kickstart_env (
  $src_dir,
  $dst_dir,
){
  file {"${dst_dir}/${name}":
    ensure => present,
    source => "${src_dir}/${name}",
  }
}

# defined type to provision kickstart configurations
define create_kickstart_profiles (
  $dst_dir,
){
  file {"${dst_dir}/${name}":
    ensure => present,
    source => "puppet:///modules/${module_name}/ks/${name}",
  }
}
