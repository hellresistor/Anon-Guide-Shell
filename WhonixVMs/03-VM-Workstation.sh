#!/bin/bash
## 03-VM-Workstation.sh
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
sudo chown $USER:$USER storage
mkdir $PWD/storage/.thunderbird $PWD/storage/.config $PWD/storage/.config/keepassxc 
mv $PWD/.config/hexchat $PWD/storage/.config/hexchat
mv $PWD/.gnupg $PWD/storage
ln -t $PWD -s $PWD/storage/.gnupg $PWD/storage/.thunderbird
ln -t $PWD/.config -s $PWD/storage/.config/hexchat $PWD/storage/.config/keepassxc

sudo apt-get install apparmor-profiles apparmor-profiles-extra apparmor-profiles-kicksecure
sudo aa-enforce /etc/apparmor.d/*
sudo apt-get install apparmor-profile-torbrowser
sudo apt-get install apparmor-profile-xchat
sudo apt-get install apparmor-profile-icedove
sudo apt-get install apparmor-profile-virtualbox

cat <<EOF
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


==> Go TO Debian Host script and PRESS <Enter> Key to continue....
EOF

read -p "## 1st step VM Workstation FINITO ##
Press <Enter> Key to conclude"
