#!/bin/bash
##
sudo -i
source ../ChangeMe

echo "IF you REALLY are Using Anon-Guide...
well.... you need answer this question..
  -- What CHAPTER have you walked? -- 
1 - Chapter 2A
2 - Chapter 2B" 
read CHPTROPT

if [ "$CHPTROPT" == "1" ];then
 echo "Are you Using this METHOD: Debian (Encrypted Boot USB)" && sleep 1
 ### wait for this ###
elif [ "$CHPTROPT" == "2" ];then
 echo "Are you Using this METHOD: Debian (USB / Internal HDD) + BootKey (USB)" && sleep 1
 dd if=/dev/urandom of=/keyfile bs=512 count=16
 YourDeviceName=$(awk '{print $2}' /etc/crypttab)
 sed -i 's+none luks+/boot/keyfile.gpg luks,keyscript=/lib/cryptsetup/scripts/decrypt_gnupg+' /etc/crypttab
 cryptsetup luksAddKey /dev/$YourDeviceName /keyfile
 echo "Set Password... Same has BOOT" && sleep 2
 gpg -c --cipher-algo AES256 /keyfile 
 mv /keyfile.gpg /boot/keyfile.gpg 
 update-initramfs -u
 cryptsetup luksKillSlot /dev/$YourDeviceName 0 --key-file /keyfile
 shred -n 30 -uv /keyfile 

 echo "Chapter 2C Finished!!" 
 read -p "Press <Enter> key to continue..."
else
 echo "FAIL COCKSUCKER" && exit 0
fi

echo "Disable SOUNd"
gnome-control-center sound
read -p "Press <Enter> key to continue..."
echo "Disable IPv6"
gnome-control-center network
read -p "Press <Enter> key to continue..."
echo "Disable History & Usage + Purge Trash"
gnome-control-center privacy
read -p "Press <Enter> key to continue..."

echo "net.ipv4.tcp_timestamps = 0" > /etc/sysctl.d/tcp_timestamps.conf
sysctl -p /etc/sysctl.d/tcp_timestamps.conf

if [ -f /etc/systemd/system/bluetooth.target.wants/bluetooth.service ]
then
 systemctl stop bluetooth.service && systemctl disable bluetooth.service
 echo "Bluetooth Service disabled!" && sleep 1
else
 echo "No bluetooth service" && sleep 1
fi

apt-get install ufw
cp /etc/ufw/before.rules /etc/ufw/before.rules.original
sed -i /etc/ufw/before.rules -e '/# ok icmp codes for INPUT/,/# allow dhcp client to work/s/ACCEPT/DROP/g'
ufw enable

apt-get install tor apt-transport-tor
cp /etc/apt/sources.list /etc/apt/sources.list.original 
sudo sed -i 's|https|tor+https|g' /etc/apt/sources.list
echo "deb tor+https://deb.debian.org/debian-security $ID_CODENAME/updates main contrib non-free" | sudo tee -a /etc/apt/sources.list
apt-get update
apt-get install -y linux-headers-$(dpkg --print-architecture) software-properties-common

read -p "IF you want config a PANIC PASSWORD write OK " PAMDUR
if [ "$PAMDUR" == "OK" ]; then
echo "Lets Config a PANIC PASSWORD ;)"
sleep 2
sudo apt install -y git make build-essential libpam0g-dev libssl1.1 libssl-dev
torsocks git clone https://github.com/Lqp1/pam_duress
# apt install libcurl4-openssl-dev libpam-cracklib ## check if REALLY needed installed..
cd pam_duress
make
sudo make install
make clean
sudo cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bck
echo "auth    [success=3 default=ignore]      pam_unix.so nullok_secure
auth    [success=2 default=ignore]      pam_duress.so disallow
auth    sufficient                      pam_duress.so
auth    requisite                       pam_deny.so
auth    required                        pam_permit.so
" | sudo tee -a /etc/pam.d/common-auth
sudo ln -s /usr/lib/security /lib/security
read -p -s "WRITE a Panic Password to your user: $USER" PANICPSWD
if [ -z "$ScriptLoc" ]; then
 ScriptLoc="$PWD/AnonPanic.sh"
 echo "sudo" > $PWD/AnonPanic.sh  ################################# CREATE SHRED SCRIPT ###########################
else
 read -p " Your User: $USER
 PanicPswd: $PANICPSWD
 Script: $ScriptLoc
 
 Are you SURE?? .. <Enter> "
fi
sudo pam_duress_adduser $USER $PANICPSWD $ScriptLoc
read -p "$USER Panic Password Created with execution script: $ScriptLoc
Press <Enter> Key to continue"
else
 echo "NOT Use PAM DURESS aKa Panic Password"
fi

echo "REBOOT the Debian Host and RUN.  Anon-Guide-Shell/Debian/Debian-VBox-starter.sh "
