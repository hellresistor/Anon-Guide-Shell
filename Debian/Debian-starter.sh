#!/bin/bash
##
source .ChangeMe

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
apt-get install -y linux-headers-$(dpkg --print-architecture) software-properties-common cpu-checker

echo "Checking VM Support..."
sudo kvm-ok
read -p -r "Press any key to continue"
