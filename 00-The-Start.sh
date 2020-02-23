#!/bin/bash
## 00-The-Start.sh
## Preparations To The Start of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 

## PREPARATION os Debian Host
##########################
##  PLEASE CHANGE THIS  ##
##########################
WNXVER="15.0.0.8.9"
WNXFAC="XFCE" ## OR "CLI"
##########################

starter(){
# root session #
sudo -i

echo "net.ipv4.tcp_timestamps = 0" > /etc/sysctl.d/tcp_timestamps.conf
sysctl -p /etc/sysctl.d/tcp_timestamps.conf

## Detecting bluethooth service .. later .. Dont worry on failure on this line ;)
systemctl stop bluetooth.service && systemctl disable bluetooth.service

apt-get install ufw
cp /etc/ufw/before.rules /etc/ufw/before.rules.original
sed -i /etc/ufw/before.rules -e '/# ok icmp codes for INPUT/,/# allow dhcp client to work/s/ACCEPT/DROP/g'
ufw enable

apt-get install tor apt-transport-tor
cp /etc/apt/sources.list /etc/apt/sources.list.original 
sudo sed -i 's|https|tor+https|g' /etc/apt/sources.list | sudo tee -a /etc/apt/sources.list
echo "deb tor+https://deb.debian.org/debian-security buster/updates main contrib non-free" | sudo tee -a /etc/apt/sources.list
apt-get update
apt-get install linux-headers-amd64 software-properties-common
sudo apt install -y cpu-checker
echo "Checking VM Support..."
sudo kvm-ok
read -p -r "Press any key to continue"
}

VBox(){
echo "deb [arch=amd64] tor+https://download.virtualbox.org/virtualbox/debian buster contrib" >> /etc/apt/sources.list
torsocks wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
apt-key add oracle_vbox_2016.asc
apt-get update
apt-get install virtualbox-6.1 dkms
sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/cGRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 quiet"/' /etc/default/grub
update-grub
exit
# user session #
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
}

QeMu(){
sudo apt install qemu qemu-kvm libvirt-bin bridge-utils virt-manager libosinfo-bin git time curl apt-cacher-ng lsb-release fakeroot dpkg-dev build-essential devscripts
sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients virt-manager gir1.2-spiceclientgtk-3.0

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

read -p "Do Reboot"

virsh -c qemu:///system net-autostart default
virsh -c qemu:///system net-start default
#sudo virsh autostart linuxconfig-vm
# disable auto start
# virsh autostart --disable linuxconfig-vm
## To get the List od OS Types 
osinfo-query os > output.txt

echo "Downloading Whonix"
torsocks wget -c https://download.whonix.org/libvirt/$WNXVER/Whonix-$WNXFAC-$WNXVER.libvirt.xz
torsocks wget -c https://download.whonix.org/libvirt/$WNXVER/Whonix-$WNXFAC-$WNXVER.libvirt.xz.asc
torsocks wget -c https://www.whonix.org/hulahoop.asc

echo "Verifing Keys..."
gpg --keyid-format long --with-fingerprint hulahoop.asc
gpg --import hulahoop.asc 
gpg --verify-options show-notations --verify Whonix-$WNXFAC-$WNXVER.libvirt.xz.asc

tar -xvf Whonix-$WNXFAC-$WNXVER.libvirt.xz
touch WHONIX_BINARY_LICENSE_AGREEMENT_accepted

export VISUAL=nano
virsh -c qemu:///system edit Whonix-Gateway

ls -la /var/run/libvirt/libvirt-sock
}

start2(){
rm Downloads/*
sudo systemctl disable tor.service

echo "alias dist-upgrade='sudo systemctl start tor.service && sleep 30 && sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get clean && sudo systemctl stop tor.service && test -f /var/run/reboot-required && tput setaf 1 && echo NEW SOFTWARE REQUIRES A REBOOT. && tput setaf 2 && echo Press ENTER to reboot your && read -sp computer: && echo If prompted by Debian, type your password and press ENTER. && sudo reboot'" >> .bashrc 
echo "function apt-install() { sudo systemctl start tor.service; sleep 30; sudo apt-get update; sudo apt-get install "\$@"; sudo apt-get clean; sudo systemctl stop tor.service; }" >> .bashrc 
echo "alias vbcompact='find ~/VirtualBox\ VMs/ -type f -mtime -1 -size +10M -name *.vdi -exec vboxmanage modifymedium --compact {} \;'" >> .bashrc

source .bashrc
dist-upgrade 
}

###########################
###########################
read -p "What you will use:
1- Virtual Box
2- KVM (qemu)" OPTION

if [ "$OPTION" == "1" ] then;
 starter
 VBox
 start2
elif [ "$OPTION" == "2" ] then;
 starter
 QeMu
 start2
else
 echo "Wrong OPTION" && exit 0
fi
