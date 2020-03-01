#!/bin/bash
# 00-InstructionExec.sh
source ../ChangeMe

cat 'EOF'
Open Oracle Virtual Box
You will execute scripts into VMs:
 - 02-VM-Gateway.sh       (Execute on Whonix Gateway - Unique step)
 - 03-VM-Workstation-1.sh (Execute on Whonix Workstation - 1st step)
 - 03-VM-Workstation-2.sh (Execute on Whonix Workstation - 2nd step)
 - 04-VM-Workstation-1.sh (Execute on Whonix Workstation - 3rd step)
 
TIP: Run within the respective Whonix VirtualMachines
   wget $ANONRep/WhonixVMs/0*-VM-*.sh
   chmod 770 $ANONRep/WhonixVMs/0*-VM-*.sh
 
-------------------------------------------
-----   STOP HERE THIS SIDE TO NOW    ----- 
-----   RUN Whonix Gateway and back   -----
-----  when 02-VM-Gateway.sh Finished -----
-------------------------------------------
EOF

read -p "Press <ENTER> Key to continue..."

cat 'EOF'
2)Restart and Boot Whonix GATEWAY ON Advanced and Recovery Mode
  Enter Password of root and ENTER this commands:
  
$ mount -o remount,ro /dev/sda1 /
$ zerofree -v /dev/sda1
$ shutdown now

3) ## Take Snapshot And Run Whonix Gateway Again and minimize it ;) ##

----- STOP HERE  NOW And back here when 03-VM-Workstation-1.sh Finished -----
EOF

read -p "Press <ENTER> Key to continue..."

cat 'EOF'
5)Restart and Boot Whonix WORKSTATION ON Advanced and Recovery Mode
  Enter Password of root and RUN:
  
$ mount -o remount,ro /dev/sda1 /
$ zerofree -v /dev/sda1
$ shutdown now

6) ## Take Snapshot And Run Whonix WORKSTATION with script 04-VM-Workstation-1.sh ;) ##

----- STOP HERE  NOW And back here when 04-VM-Workstation-1.sh Finished -----
EOF

read -p "Press <ENTER> Key to continue..."

read -p "SHUTDOWN WHONIX workstation AND 
THAN SHUTDOWN WHONIX Gateway
###############################################
### VERIFY WHONIXes VMs ARE ALL SHUTDOWN!!! ###
###      Press <Enter> key to continue      ###
###############################################"
