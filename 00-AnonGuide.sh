#!/bin/bash
## Starter ##
#############

MENU(){
echo "Detecting OS ..." && sleep 1
if [ -f /etc/os-release ]
then
 . /etc/os-release
 case $ID in
  qubes)
   echo "$NAME $VERSION DETECTED" && sleep 1
   . Qubes/Qubes.sh
  ;;
  debian)
   printf 'Debian Installation\n'
   echo "$NAME $VERSION DETECTED" && sleep 1
   echo && read -p "What you will use:
   1- Virtual Box (working)
   2- Qemu/KVM    (developing...)
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
STARTER
