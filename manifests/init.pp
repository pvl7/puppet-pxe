class pxeboot {

  include ::params

  package {$packages:
    ensure => installed,
  }
  file {$tftp_dirs:
    ensure => directory,
  }
  filecopy {$tftp_files:
    src_dir => $tftp_src_files,
    dst_dir => $tftp_root_dir,
  }
  file {$pxe_xinetd_conf:
    ensure  => present,
    content => template("templates/tftp.erb")
    notify  => Service["xinetd"],
  }
  file {$pxe_httpd_conf:
    ensure  => present,
    content => template("templates/pxeboot.conf-httpd.erb")
    notify  => Service["httpd"],
  }
  file {$pxe_dhcpd_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/dhcpd.conf"
    notify => Service["dhcpd"],
  }
  file {$pxe_default_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/tftpboot-default"
  }
  file {$pxe_ks_centos6_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/centos6.cfg"
  }
  file {$pxe_ks_centos7_conf:
    ensure => present,
    source => "puppet:///modules/${module_name}/centos7.cfg"
  }

  service {'httpd':
    ensure    => running,
    enabled   => true,
  }
  service {'dhcpd':
    ensure    => running,
    enabled   => true,
  }
  service {'xinetd':
    ensure    => running,
    enabled   => true,
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
