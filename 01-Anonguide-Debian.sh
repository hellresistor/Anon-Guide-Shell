#!/bin/bash
## 01-Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
## This script its the 1st STEP TO DO
## After your HDD/USB Debian OS Installation (Chapters 3a ,3b)

##########################
##  PLEASE CHANGE THIS  ##
##########################
WNXVER="15.0.0.8.9"
WNXFAC="XFCE" ## OR "CLI"
##########################

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
echo "deb [arch=amd64] tor+https://download.virtualbox.org/virtualbox/debian buster contrib" >> /etc/apt/sources.list
torsocks wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
apt-key add oracle_vbox_2016.asc
apt-get update
apt-get install virtualbox-6.1 dkms

# IF NEEDED UnComment 2 down lines
# torsocks wget https://download.virtualbox.org/virtualbox/6.1.2/Oracle_VM_VirtualBox_Extension_Pack-6.1.2.vbox-extpack
# VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.2.vbox-extpack

sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/cGRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 quiet"/' /etc/default/grub
update-grub
exit

# user session #
cd Downloads

echo "Get Whonix and Keys.."
torsocks wget -c https://download.whonix.org/ova/$WNXVER/Whonix-$WNXFAC-$WNXVER.ova
torsocks wget -c https://download.whonix.org/ova/$WNXVER/Whonix-$WNXFAC-$WNXVER.ova.asc
torsocks wget https://www.whonix.org/patrick.asc 

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
 
rm Downloads/*

sudo systemctl disable tor.service

echo "alias dist-upgrade='sudo systemctl start tor.service && sleep 30 && sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get clean && sudo systemctl stop tor.service && test -f /var/run/reboot-required && tput setaf 1 && echo NEW SOFTWARE REQUIRES A REBOOT. && tput setaf 2 && echo Press ENTER to reboot your && read -sp computer: && echo If prompted by Debian, type your password and press ENTER. && sudo reboot'" >> .bashrc 

echo "function apt-install() { sudo systemctl start tor.service; sleep 30; sudo apt-get update; sudo apt-get install "\$@"; sudo apt-get clean; sudo systemctl stop tor.service; }" >> .bashrc 

echo "alias vbcompact='find ~/VirtualBox\ VMs/ -type f -mtime -1 -size +10M -name *.vdi -exec vboxmanage modifymedium --compact {} \;'" >> .bashrc

source .bashrc
dist-upgrade 

#######################################################
read -p "Open Oracle Virtual Box

You will execute scripts into VMs:
 - 02-VM-Gateway.sh 
 - 03-VM-Workstation-1.sh
 - 03-VM-Workstation-2.sh
 - 04-VM-Workstation-1.sh
 
----- STOP HERE DO steps upstep -----
Press <ENTER> Key to continue..." 

read -p "### VERIFY WHONIXes VMs ARE ALL SHUTDOWN!!! ###
###      Press <Enter> key to continue      ###"
#########################################################

vbcompact
echo -e "DEBIAN WITH WHONIX ON USB COMPLETED INSTALLED \n Shutdown and Rest a Little.. OR PRESS <Enter> Key to Continue ;)"
read -p

echo "checking securely updates to Host"
dist-upgrade

cat 'EOF'
#############################
## BOOT/RUN Whonix Gateway ##
#############################
sudo apt-get-update-plus dist-upgrade && sudo apt-get clean

#############################################################
## Every time you run updates AND installing, NEED DO THIS ##
#############################################################
# Shutdown - Boot in Recovery Mode - Put Password #
# type this commands:

mount -o remount,ro /dev/sda1 /
zerofree -v /dev/sda1 
shutdown now

# Take Snapshot and Start Gateway Again #
##############################################################
EOF

read -p "AFTER Succefully runned of Whonix Gateway...
Press <Enter> Key to Continue.."

cat 'EOF'
#################################
## BOOT/RUN Whonix Workstation ##
##   Execute this on Terminal  ##
#################################
sudo apt-get-update-plus dist-upgrade && sudo apt-get clean

#############################################################
## Every time you run updates AND installing, NEED DO THIS ##
#############################################################
# Shutdown - Boot in Recovery Mode - Put password #
# type this commands:

mount -o remount,ro /dev/sda1 /
mount -o remount,ro /dev/sdb1 /home/user/storage 
zerofree -v /dev/sda1 
zerofree -v /dev/sdb1 
shutdown now

# Take Snapshot and Start Gateway Again #
##############################################################
EOF

read -p "### VERIFY WHONIXes VMs ARE ALL SHUTDOWN!!! ###"
vbcompact

sleep 2
echo "Congratulations!!! Debian Host, Whonix VMs Installed and Updated!!"
sleep 2
read -p "Prepared to Next Step? ;)"
