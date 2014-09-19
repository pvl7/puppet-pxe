#puppet-pxe

##Installation and usage:

git clone https://github.com/pvl7/puppet-pxe pxeboot

**Review default settings (change if required):**

* vi pxeboot/files/dhcpd.conf

* vi pxeboot/files/tftpd-defauls


puppet apply --modulepath ./ pxeboot/tests/pxeboot.pp
