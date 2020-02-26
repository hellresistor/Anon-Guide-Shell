#!/bin/bash
## 03-VM-Workstation-1.sh
## Continue of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
## This script its the 1st STEP TO DO
## After your Whonix Workstation Boot 1st Time
##

##Part I##
read -p -s "Set Root Password:" RTPASS
read -p -s "Set $USER Password:" RTUSER
echo "changeme\n$RTPASS\n$RTPASS" | sudo passwd root
echo "changeme\n$RTUSER\n$RTUSER" | passwd
echo "deb tor+http://deb.debian.org/debian buster-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list.d/debian.list
#OR
# sudo su -c "echo -e 'deb tor+http://vwakviie2ienjx6t.onion/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/backports.list"
sudo apt-get-update-plus dist-upgrade && sudo apt-get clean
sudo fdisk /dev/sdb
read -p "## On Prompt Type on this Sequence:
   n - <Enter> - <Enter> - <Enter> - <Enter> - w - <Enter>"
sudo mkfs.ext4 /dev/sdb1
mkdir /home/$user/storage
echo "/dev/sdb1 /home/$user/storage ext4 defaults 0 2" | sudo tee -a /etc/fstab

read -p "Press <Enter> Key to REBOOT! And Execute Next script 02-VM-Workstation-2.sh"
sudo reboot
