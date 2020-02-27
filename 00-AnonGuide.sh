#!/bin/bash
## Starter ##

#############
PANICX(){
echo "Lets Config a PANIC PASSWORD ;)"
sleep 2

sudo apt install -y git make build-essential libpam0g-dev libssl1.1 libssl-dev
git clone https://github.com/Lqp1/pam_duress
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
 ScriptLoc="$PWD/pam_duress/examples/delete-all.sh"
else
 read -p " Your User: $USER
 PanicPswd: $PANICPSWD
 Script: $ScriptLoc
 
 Are you SURE?? .. <Enter> "
fi

sudo pam_duress_adduser $USER $PANICPSWD $ScriptLoc
read -p "$USER Panic Password Created with execution script: $ScriptLoc
Press <Enter> Key to continue"
}

MENU(){
echo "Detecting OS ..." && sleep 1
if [ -f /etc/os-release ]
then
 . /etc/os-release
 case $ID in
  qubes)
   echo "$NAME $VERSION DETECTED" && sleep 1
   . Qubes.sh
  ;;
  debian)
   printf 'Debian Installation\n'
   echo "$NAME $VERSION DETECTED" && sleep 1
   echo && read -p "What you will use:
   1- Virtual Box
   2- Qemu/KVM
   " VMCHOICE
   case "$VMCHOICE" in
    1) echo "VMBOX"
       . Debian/Debian-starter.sh
       . Debian/Debian-VBox-starter.sh
       . Debian/Debian-ender.sh
       . Hows/00-InstructionExec.sh
       vbcompact
       . Hows/01-InstructionExec.sh
       vbcompact
       sleep 2
    ;;
    2) echo "qemu"
       . Debian/Debian-starter.sh
       . Debian/Debian-Qemu-starter.sh
       . Debian/Debian-ender.sh
       . Debian/Debian-Qemu-Continue.sh
       . Hows/00-InstructionExec.sh
       . Hows/01-InstructionExec.sh
       sleep 2
    ;;
    *) echo "FAIL"
    ;;
    esac
  ;;
  fedora)
   printf 'Fedora Installation\n'
   echo "$NAME $VERSION DETECTED" && sleep 1
   . Fedora.sh
  ;;
  *)
    printf 'Only PURE Linux ..\n'
    ;;
 esac
else
        echo "ONLY PURE LINUX"
        exit
fi
}

##########
## MAIN ##
##########
source .ChangeMe
PANICX
MENU
