#!/bin/bash
## 00-The-Start.sh
## Preparations To The Start of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
source ChangeMe

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
echo "deb tor+https://deb.debian.org/debian-security buster/updates main contrib non-free" | sudo tee -a /etc/apt/sources.list
apt-get update
apt-get install -y linux-headers-amd64 software-properties-common cpu-checker

echo "Checking VM Support..."
sudo kvm-ok
read -p -r "Press any key to continue"
}

ender(){
sudo systemctl disable tor.service

echo "alias dist-upgrade='sudo systemctl start tor.service && sleep 30 && sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get clean && sudo systemctl stop tor.service && test -f /var/run/reboot-required && tput setaf 1 && echo NEW SOFTWARE REQUIRES A REBOOT. && tput setaf 2 && echo Press ENTER to reboot your && read -sp computer: && echo If prompted by Debian, type your password and press ENTER. && sudo reboot'" >> .bashrc 
echo "function apt-install() { sudo systemctl start tor.service; sleep 30; sudo apt-get update; sudo apt-get install "\$@"; sudo apt-get clean; sudo systemctl stop tor.service; }" >> .bashrc 
echo "alias vbcompact='find ~/VirtualBox\ VMs/ -type f -mtime -1 -size +10M -name *.vdi -exec vboxmanage modifymedium --compact {} \;'" >> .bashrc

source .bashrc
dist-upgrade 

read -p "Os Updated!
Press <Enter> Key to Continue..."
}

VBox(){
cp /etc/apt/sources.list /etc/apt/sources.list.older
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

VBox2(){
cat 'EOF'
Open Oracle Virtual Box
You will execute scripts into VMs:
 - 01-Anonguide-Debian.sh (executing..)
 - 02-VM-Gateway.sh       (Execute on Whonix Gateway)
 - 03-VM-Workstation-1.sh (Execute on Whonix Workstation)
 - 03-VM-Workstation-2.sh (Execute on Whonix Workstation)
 - 04-VM-Workstation-1.sh (Execute on Whonix Workstation)
 
----- STOP HERE  NOW -- RUN VM Gateway and back here when 02-VM-Gateway.sh Finished -----
EOF

read -p "Press <ENTER> Key to continue..."

cat 'EOF'
2)Restart and Boot Whonix GATEWAY ON Advanced and Recovery Mode
  Enter Password of root and ENTER this commands:
  
$ mount -o remount,ro /dev/sda1 /
$ zerofree -v /dev/sda1
$ shutdown now

3) ## Take Snapshot And Run Whonix Gateway Again and minimize it ;) ##

----- STOP HERE  NOW And back here when 03-VM-Workstation-1.sh Finished -----
EOF

read -p "Press <ENTER> Key to continue..."

cat 'EOF'
5)Restart and Boot Whonix WORKSTATION ON Advanced and Recovery Mode
  Enter Password of root and RUN:
  
$ mount -o remount,ro /dev/sda1 /
$ zerofree -v /dev/sda1
$ shutdown now

6) ## Take Snapshot And Run Whonix WORKSTATION with script 04-VM-Workstation-1.sh ;) ##

----- STOP HERE  NOW And back here when 04-VM-Workstation-1.sh Finished -----
EOF

read -p "Press <ENTER> Key to continue..."

read -p "SHUTDOWN WHONIX workstation AND THAN SHUTDOWN WHONIX Gateway
###############################################
### VERIFY WHONIXes VMs ARE ALL SHUTDOWN!!! ###
###      Press <Enter> key to continue      ###"

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

$ mount -o remount,ro /dev/sda1 /
$ zerofree -v /dev/sda1 
$ shutdown now

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

$ mount -o remount,ro /dev/sda1 /
$ mount -o remount,ro /dev/sdb1 /home/user/storage 
$ zerofree -v /dev/sda1 
$ zerofree -v /dev/sdb1 
$ shutdown now

# Take Snapshot ONLY #
##############################################################
EOF

read -p "### VERIFY WHONIXes VMs ARE ALL SHUTDOWN!!! ###"
vbcompact

sleep 2
}

QeMu(){
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

}

QeMu2(){
virsh -c qemu:///system net-autostart default
virsh -c qemu:///system net-start default
sudo virsh autostart linuxconfig-vm

## To get the List od OS Types 
osinfo-query os > output.txt

## To EDIT  XML
#export VISUAL=nano
#virsh -c qemu:///system edit Whonix-Gateway

echo "Importing VM Templates ..."
virsh -c qemu:///system net-define Whonix_external*.xml
virsh -c qemu:///system net-define Whonix_internal*.xml
virsh -c qemu:///system net-autostart Whonix-External
virsh -c qemu:///system net-start Whonix-External
virsh -c qemu:///system net-autostart Whonix-Internal
virsh -c qemu:///system net-start Whonix-Internal

echo "Importing VM Images..."
virsh -c qemu:///system define Whonix-Gateway*.xml
virsh -c qemu:///system define Whonix-Workstation*.xml

echo "Moving VMs Images Files..."
sudo mv Whonix-Gateway*.qcow2 /var/lib/libvirt/images/Whonix-Gateway.qcow2
sudo mv Whonix-Workstation*.qcow2 /var/lib/libvirt/images/Whonix-Workstation.qcow2

echo "Copying VMs Images Files..."
sudo cp --sparse=always Whonix-Gateway*.qcow2 /var/lib/libvirt/images/Whonix-Gateway.qcow2
sudo cp --sparse=always Whonix-Workstation*.qcow2 /var/lib/libvirt/images/Whonix-Workstation.qcow2

echo "Encrypted containers"
sudo chmod og+xr /run/media/private/user/$container_name

#rm Downloads/Whonix*



if [ "$WNXFAC" == "CLI" ] then;
read -p "Will Run Whonix Gateway on CLI...
Press <Enter> Key to continue..."
sudo virsh start Whonix-Gateway
read -p "Will Run Whonix Workstation on CLI...
Press <Enter> Key to continue..."

systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
sudo virsh start Whonix-Workstation

cat 'EOF'
Change this /etc/default/grub on VM Workstation to able console serial
 GRUB_CMDLINE_LINUX_DEFAULT=“console=tty0 console=ttyS0"
 GRUB_TERMINAL=“serial console"
update-grub
EOF
read -p "continue...."
virsh console Whonix-Workstation

else
cat 'EOF'
Go Start - Application - System - Virtual machine Manager
  - Run Gateway
  - Run Workstation
EOF
fi

read -p "Change screen Resolution: "

ls -la /var/run/libvirt/libvirt-sock
}

####################################################
read -p "What you will use:
1- Virtual Box  (completed)
2- KVM (qemu)   (in building...)" OPTION

if [ "$OPTION" == "1" ] then;
 starter
 VBox
 ender
 VBox2
elif [ "$OPTION" == "2" ] then;
 starter
 QeMu
 ender
 QeMu2
else
 echo "Wrong OPTION" && exit 0
fi
echo "Congratulations!!! ARE COMPLETED!!!"
sleep 2
####################################################
