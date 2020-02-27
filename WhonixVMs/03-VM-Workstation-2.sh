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

sudo apt-get install apparmor-profiles apparmor-profiles-extra apparmor-profiles-kicksecure
sudo aa-enforce /etc/apparmor.d/*
sudo apt-get install apparmor-profile-torbrowser
sudo apt-get install apparmor-profile-xchat
sudo apt-get install apparmor-profile-icedove
sudo apt-get install apparmor-profile-virtualbox

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

4) Go TO Debian Host script and PRESS <Enter> Key to continue....
EOF

read -p "## 2ND Prep VM Workstation FINITO ##
Press <Enter> Key to conclude"
