#!/bin/bash
## 02-VM-Gateway.sh
## Continue of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
## This script its the 1st STEP TO DO
## After your Whonix Gateway Boot 1st Time

read -s -p "Set Root Password:" RTPASS
read -s -p "Set $USER Password:" RTUSER
echo "changeme\n$RTPASS\n$RTPASS" | sudo passwd root
echo "changeme\n$RTUSER\n$RTUSER" | passwd

sudo apt-get-update-plus dist-upgrade && sudo apt-get clean
sudo apt-get install zerofree

cat 'EOF'
1)Create Shortcuts Favoritos 
  - Onion Circuits
  
2) Go TO Debian Host script and PRESS <Enter> Key to continue....
EOF

read -p "## 1ST Prep VM GATEWAY FINITO ##
Press <Enter> Key to conclude"
