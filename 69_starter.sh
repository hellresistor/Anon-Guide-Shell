#!/bin/bash
## Starter ##
source .ChangeMe
#############
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
    ;;
    2) echo "qemu"
    ;;
    *) echo "FAIL"
    ;;
   . 01-Anonguide-Debian.sh
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
