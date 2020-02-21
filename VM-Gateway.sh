#!/bin/bash
## 02-VM-Gateway.sh
## Continue of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
## This script its the 1st STEP TO DO
## After your Whonix Gateway Boot 1st Time

read -p -s "Set Root Password:" RTPASS
read -p -s "Set $USER Password:" RTUSER
echo "changeme\n$RTPASS\n$RTPASS" | sudo passwd root
echo "changeme\n$RTUSER\n$RTUSER" | passwd

dbpkg --reconfigure keyboard

sudo apt-get-update-plus dist-upgrade && sudo apt-get clean
sudo apt-get install zerofree

cat 'EOF'
1)Create Shortcuts Favoritos 
  - Onion Circuits
  
2)Restart and Boot Whonix Advanced and Recovery Mode
  Enter Password of root and RUN:
  
$ mount -o remount,ro /dev/sda1 /
$ zerofree -v /dev/sda1
$ shutdown now

3) ## Take Snapshot And Run Whonix Gateway ##
EOF

read -p "## 1ST Prep VM GATEWAY FINITO ##
Press <Enter> Key to conclude"
