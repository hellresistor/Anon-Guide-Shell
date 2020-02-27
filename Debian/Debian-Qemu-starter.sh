#!/bin/bash
#
source ./ChangeMe

sudo apt install qemu qemu-kvm libvirt-bin bridge-utils virt-manager libosinfo-bin git time curl apt-cacher-ng lsb-release fakeroot dpkg-dev build-essential devscripts
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients virt-manager gir1.2-spiceclientgtk-3.0

echo "activating services..."
sudo cat<<EOF>> /etc/libvirt/qemu.conf
user = "root"
group = "root"
EOF
sudo service libvirtd start
sudo update-rc.d libvirtd enable
sudo service libvirtd status
sudo addgroup "$(whoami)" libvirt
sudo addgroup "$(whoami)" kvm
exit
echo "Downloading Whonix"
cd Downloads
torsocks wget -c https://download.whonix.org/libvirt/$WNXVER/Whonix-$WNXFAC-$WNXVER.libvirt.xz
torsocks wget -c https://download.whonix.org/libvirt/$WNXVER/Whonix-$WNXFAC-$WNXVER.libvirt.xz.asc
torsocks wget -c https://www.whonix.org/hulahoop.asc
echo "Verifing Keys..."
gpg --keyid-format long --with-fingerprint hulahoop.asc
gpg --import hulahoop.asc 
gpg --verify-options show-notations --verify Whonix-$WNXFAC-$WNXVER.libvirt.xz.asc
tar -xvf Whonix-$WNXFAC-$WNXVER.libvirt.xz
touch WHONIX_BINARY_LICENSE_AGREEMENT_accepted

