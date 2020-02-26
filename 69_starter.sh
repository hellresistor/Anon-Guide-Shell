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
   . Debian.sh
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
        echo "ONLY PURER LINUX"
        exit
fi
