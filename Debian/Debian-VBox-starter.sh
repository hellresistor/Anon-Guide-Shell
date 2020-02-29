#!/bin/bash
#
source ../ChangeMe

cp /etc/apt/sources.list /etc/apt/sources.list.older
echo "deb [arch=amd64] tor+https://download.virtualbox.org/virtualbox/debian buster contrib" >> /etc/apt/sources.list
torsocks wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
apt-key add oracle_vbox_2016.asc
apt-get update
apt-get install virtualbox-6.1 dkms
sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/cGRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 quiet"/' /etc/default/grub
update-grub
exit

cd Downloads
echo "Get Whonix and Keys.."
torsocks wget -c https://download.whonix.org/ova/$WNXVER/Whonix-$WNXFAC-$WNXVER.ova
torsocks wget -c https://download.whonix.org/ova/$WNXVER/Whonix-$WNXFAC-$WNXVER.ova.asc
torsocks wget -c https://www.whonix.org/patrick.asc 

echo "Verifing Keys..."
gpg --keyid-format long --with-fingerprint patrick.asc 
gpg --import patrick.asc 
gpg --verify-options show-notations --verify Whonix-$WNXFAC-$WNXVER.ova.asc
   
vboxmanage import Whonix-$WNXFAC-$WNXVER.ova --vsys 0 --eula accept --vsys 1 --eula accept
cd
vboxmanage clonehd VirtualBox\ VMs/Whonix-Gateway-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk001.vmdk VirtualBox\ VMs/Whonix-Gateway-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk001.vdi --format VDI
vboxmanage storageattach Whonix-Gateway-$WNXFAC --storagectl "Whonix-Gateway-$WNXFAC-sas" --port 0 --device 0 --type hdd --medium /home/teste/VirtualBox\ VMs/Whonix-Gateway-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk001.vdi --mtype immutable
   
vboxmanage closemedium disk VirtualBox\ VMs/Whonix-Gateway-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk001.vmdk --delete
vboxmanage clonehd VirtualBox\ VMs/Whonix-Workstation-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk002.vmdk VirtualBox\ VMs/Whonix-Workstation-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk001.vdi --format VDI
vboxmanage storageattach Whonix-Workstation-$WNXFAC --storagectl "Whonix-Workstation-$WNXFAC-sas" --port 0 --device 0 --type hdd --medium /home/teste/VirtualBox\ VMs/Whonix-Workstation-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk001.vdi --mtype immutable
vboxmanage closemedium disk VirtualBox\ VMs/Whonix-Workstation-$WNXFAC/Whonix-$WNXFAC-$WNXVER-disk002.vmdk --delete
vboxmanage createhd --filename VirtualBox\ VMs/Whonix-Workstation-$WNXFAC/Whonix-Workstation-$WNXFAC-storage.vdi --size 8192
vboxmanage storageattach Whonix-Workstation-$WNXFAC --storagectl "Whonix-Workstation-$WNXFAC-sas" --port 1 --device 0 --type hdd --medium /home/teste/VirtualBox\ VMs/Whonix-Workstation-$WNXFAC/Whonix-Workstation-$WNXFAC-storage.vdi --mtype writethrough
 
