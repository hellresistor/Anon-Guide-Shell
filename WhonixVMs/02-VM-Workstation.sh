#!/bin/bash
## 02-VM-Workstation.sh
## Continue of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
## This script its the 1st STEP TO DO
## After your Whonix Workstation Boot 1st Time
##

echo
read -s -p "Set New Root Password:
" RTPASS
echo
read -s -p "Set New $USER Password:
" RTUSER
echo
echo
echo " sudo password is:  changeme  :ONLY THIS TIME"
sleep 2
echo
echo -e "$RTPASS\n$RTPASS" | sudo passwd root
echo -e "changeme\n$RTUSER\n$RTUSER" | passwd

sudo echo "deb tor+http://deb.debian.org/debian $ID_CODENAME-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list.d/debian.list
#OR
# sudo su -c "echo -e 'deb tor+http://vwakviie2ienjx6t.onion/debian $ID_CODENAME-backports main contrib non-free' > /etc/apt/sources.list.d/backports.list"
sudo apt-get-update-plus dist-upgrade && sudo apt-get clean

read -p "## On Prompt Type on this Sequence:
   n - <Enter> - <Enter> - <Enter> - <Enter> - w - <Enter>"
sudo fdisk /dev/sdb

sudo mkfs.ext4 /dev/sdb1
mkdir $PWD/storage
echo "/dev/sdb1 /home/$user/storage ext4 defaults 0 2" | sudo tee -a /etc/fstab

read -p "Press <Enter> Key to REBOOT! And Execute Next script 03-VM-Workstation.sh"
sudo reboot
