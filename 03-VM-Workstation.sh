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

##Part I##
read -p -s "Set Root Password:" RTPASS
read -p -s "Set $USER Password:" RTUSER
echo "changeme\n$RTPASS\n$RTPASS" | sudo passwd root
echo "changeme\n$RTUSER\n$RTUSER" | passwd
echo "deb tor+http://deb.debian.org/debian buster-backports main contrib non-free" | sudo tee -a /etc/apt/sources.list.d/debian.list
sudo apt-get-update-plus dist-upgrade && sudo apt-get clean
sudo fdisk /dev/sdb
read -p "## On Prompt Type on this Sequence:
   n - <Enter> - <Enter> - <Enter> - <Enter> - w - <Enter>"
sudo mkfs.ext4 /dev/sdb1
mkdir /home/$user/storage
echo "/dev/sdb1 /home/$user/storage ext4 defaults 0 2" | sudo tee -a /etc/fstab
read -p "## Reboot Workstation ##"

##Part II##
sudo apt-get install hexchat-otr zerofree thunderbird enigmail
sudo apt-get install -t buster-backports keepassxc xul-ext-torbirdy && sudo apt-get clean
sudo chown $user:$user storage
mkdir storage/.thunderbird storage/.config storage/.config/keepassxc 
mv .config/hexchat storage/.config/hexchat
mv .gnupg storage
ln -t ./ -s storage/.gnupg storage/.thunderbird
ln -t .config -s ~/storage/.config/hexchat ~/storage/.config/keepassxc
cat 'EOF'
echo "Next things TODO....."

1)Create Shortcuts Favorito
  - HexChat
  - KeePassXC
  - Thunderbird
  - Tor Browser
  - Tor Downloader

2)Open Tor Browser
  - Preferences 
    -- Set Default Tor Browser
    -- Add HttpsAnywhere and NoScript Buttons
    - Advance
       -- Set Security Safest!

3)Run Tor Downloader To check updates

4)Restart and Boot Whonix on Advanced and Recovery Mode
  Enter Password of root and RUN:
mount -o remount,ro /dev/sda1 /
zerofree -v /dev/sda1
shutdown now

5) ## Take Snapshot And Run it Again!!! ##
EOF

read -p "## 1ST Prep VM Workstation FINITO ##
## Next will run 03-VM-Workstation.sh
Press <Enter> Key to conclude"
read -p "Press <Enter> Key after do this steps to continue"
