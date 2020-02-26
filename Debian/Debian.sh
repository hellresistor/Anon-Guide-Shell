#!/bin/bash
##
source .ChangeMe

starter(){
# root session #
sudo -i

echo "net.ipv4.tcp_timestamps = 0" > /etc/sysctl.d/tcp_timestamps.conf
sysctl -p /etc/sysctl.d/tcp_timestamps.conf

if [ -f /etc/systemd/system/bluetooth.target.wants/bluetooth.service ]
then
systemctl stop bluetooth.service && systemctl disable bluetooth.service
echo "Bluetooth Service disabled && sleep 1"
else
echo "No bluetooth service" && sleep 1
fi

apt-get install ufw
cp /etc/ufw/before.rules /etc/ufw/before.rules.original
sed -i /etc/ufw/before.rules -e '/# ok icmp codes for INPUT/,/# allow dhcp client to work/s/ACCEPT/DROP/g'
ufw enable

apt-get install tor apt-transport-tor
cp /etc/apt/sources.list /etc/apt/sources.list.original 
echo "deb tor+https://deb.debian.org/debian-security $ID_CODENAME/updates main contrib non-free" | sudo tee -a /etc/apt/sources.list
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

starter
. InstructionExec.sh
ender

echo "COMPLETED!!!!!!"
exit
