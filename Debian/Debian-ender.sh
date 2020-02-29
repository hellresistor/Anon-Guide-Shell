#!/bin/bash
#
source ../ChangeME

sudo systemctl disable tor.service

echo "alias dist-upgrade='sudo systemctl start tor.service && sleep 30 && sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get clean && sudo systemctl stop tor.service && test -f /var/run/reboot-required && tput setaf 1 && echo NEW SOFTWARE REQUIRES A REBOOT. && tput setaf 2 && echo Press ENTER to reboot your && read -sp computer: && echo If prompted by Debian, type your password and press ENTER. && sudo reboot'" >> .bashrc 
echo "function apt-install() { sudo systemctl start tor.service; sleep 30; sudo apt-get update; sudo apt-get install "\$@"; sudo apt-get clean; sudo systemctl stop tor.service; }" >> .bashrc 
echo "alias vbcompact='find ~/VirtualBox\ VMs/ -type f -mtime -1 -size +10M -name *.vdi -exec vboxmanage modifymedium --compact {} \;'" >> .bashrc

source .bashrc
dist-upgrade 

read -p "Os Updated!
Press <Enter> Key to Continue..."
