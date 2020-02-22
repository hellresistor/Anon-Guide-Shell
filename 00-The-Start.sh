#!/bin/bash
## 00-The-Start.sh
## Preparations To The Start of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 

read -p "What you will use?

1- Virtual Box
2- KVM (qemu)" OPTION

if [ "$OPTION" == "1" ] then;
 echo "Running VM"
elif [ "$OPTION" == "2" ] then;
 echo "Running QEMU"
else
 echo "Wrong OPTION"
fi
