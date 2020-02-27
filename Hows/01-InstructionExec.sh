#!/bin/bash
#

echo -e "DEBIAN WITH WHONIX ON USB COMPLETED INSTALLED \n Shutdown and Rest a Little.. OR PRESS <Enter> Key to Continue ;)"
read -p

echo "checking securely updates to Host"
dist-upgrade

cat 'EOF'
#############################
## BOOT/RUN Whonix Gateway ##
#############################
sudo apt-get-update-plus dist-upgrade && sudo apt-get clean

#############################################################
## Every time you run updates AND installing, NEED DO THIS ##
#############################################################
# Shutdown - Boot in Recovery Mode - Put Password #
# type this commands:

$ mount -o remount,ro /dev/sda1 /
$ zerofree -v /dev/sda1 
$ shutdown now

# Take Snapshot and Start Gateway Again #
##############################################################
EOF

read -p "AFTER Succefully runned of Whonix Gateway...
Press <Enter> Key to Continue.."

cat 'EOF'
#################################
## BOOT/RUN Whonix Workstation ##
##   Execute this on Terminal  ##
#################################
sudo apt-get-update-plus dist-upgrade && sudo apt-get clean

#############################################################
## Every time you run updates AND installing, NEED DO THIS ##
#############################################################
# Shutdown - Boot in Recovery Mode - Put password #
# type this commands:

$ mount -o remount,ro /dev/sda1 /
$ mount -o remount,ro /dev/sdb1 /home/user/storage 
$ zerofree -v /dev/sda1 
$ zerofree -v /dev/sdb1 
$ shutdown now

# Take Snapshot ONLY #
##############################################################
EOF

read -p "### VERIFY WHONIXes VMs ARE ALL SHUTDOWN!!! ###"
