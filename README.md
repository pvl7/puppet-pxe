#puppet-pxe

Configures a RHEL/Centos based PXE boot server with no hassle. Doesn't require any other Puppet modules. Doesn't require Puppet Master installed.

##Installation and usage:

1) git clone https://github.com/pvl7/puppet-pxe pxeboot

2) Attach the minimal Centos6 or Centos7 ISO image to a VM

**Review default settings (change if required):**

vi pxeboot/manifests/params.pp

and adjust the following parameters to suit your needs

The kickstart config files are in $module_name/files/ks/

```
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
```

3) puppet apply --modulepath ./ pxeboot/tests/pxeboot.pp

4) kickstart!

##Limitations:

Only tested with Centos/RedHat. Ubuntu/Debian are not supported yet
