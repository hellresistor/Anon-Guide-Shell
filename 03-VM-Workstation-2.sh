#!/bin/bash
## 03-VM-Workstation-2.sh
## Continue of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
## This script its the 2nd STEP TO DO for Workstation
## After your Whonix Workstation Boot 2nd Time
##

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
Next things TODO.....

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
EOF

read -p "Press <Enter> Key to continue..."

cat 'EOF'
4)Restart and Boot Whonix on Advanced and Recovery Mode
  Enter Password of root and RUN:
mount -o remount,ro /dev/sda1 /
zerofree -v /dev/sda1
shutdown now

5) ## Take Snapshot And Run it Again!!! ##
EOF

read -p "## 2ND Prep VM Workstation FINITO ##

Next will run 04-VM-Workstation-1.sh

Press <Enter> Key to conclude"
