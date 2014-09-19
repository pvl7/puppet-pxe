#puppet-pxe

Configures a RHEL/Centos based PXE boot server with no hassle. Doesn't require any other Puppet modules. Doesn't require Puppet Master installed.

##Installation and usage:

1) git clone https://github.com/pvl7/puppet-pxe pxeboot

**Review default settings (change if required):**
* vi pxeboot/files/dhcpd.conf
* vi pxeboot/files/tftpd-defaults

2) puppet apply --modulepath ./ pxeboot/tests/pxeboot.pp

*The default settings are:*
* PXE boot network: 192.168.15.0/24
* PXE boot server: 192.168.15.254
* PXE boot root directory: /tftpboot
* ISO mounted to /tftpboot/iso/centos6 or /tftpboot/iso/centos7
* Kickstart files: /tftpboot/ks

3) Attach the minimal Centos6 or Centos7 ISO image to a VM

4) mount /dev/cdrom /tftpboot/iso/centos[6,7]

5) kickstart!

##Limitations:

Only tested with Centos/RedHat. Ubuntu/Debian are not supported yet
