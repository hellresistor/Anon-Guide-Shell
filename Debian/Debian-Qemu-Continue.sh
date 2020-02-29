#!/bin/bash
#
source ../ChangeMe

virsh -c qemu:///system net-autostart default
virsh -c qemu:///system net-start default
sudo virsh autostart linuxconfig-vm
## To get the List od OS Types 
osinfo-query os > output.txt

## To EDIT  XML
#export VISUAL=nano
#virsh -c qemu:///system edit Whonix-Gateway
echo "Importing VM Templates ..."
virsh -c qemu:///system net-define Whonix_external*.xml
virsh -c qemu:///system net-define Whonix_internal*.xml
virsh -c qemu:///system net-autostart Whonix-External
virsh -c qemu:///system net-start Whonix-External
virsh -c qemu:///system net-autostart Whonix-Internal
virsh -c qemu:///system net-start Whonix-Internal
echo "Importing VM Images..."
virsh -c qemu:///system define Whonix-Gateway*.xml
virsh -c qemu:///system define Whonix-Workstation*.xml
echo "Moving VMs Images Files..."
sudo mv Whonix-Gateway*.qcow2 /var/lib/libvirt/images/Whonix-Gateway.qcow2
sudo mv Whonix-Workstation*.qcow2 /var/lib/libvirt/images/Whonix-Workstation.qcow2
echo "Copying VMs Images Files..."
sudo cp --sparse=always Whonix-Gateway*.qcow2 /var/lib/libvirt/images/Whonix-Gateway.qcow2
sudo cp --sparse=always Whonix-Workstation*.qcow2 /var/lib/libvirt/images/Whonix-Workstation.qcow2

##
echo "Encrypted containers"
sudo chmod og+xr /run/media/private/user/$container_name
#rm Downloads/Whonix*

if [ "$WNXFAC" == "CLI" ] then;
read -p "Will Run Whonix Gateway on CLI...
Press <Enter> Key to continue..."
sudo virsh start Whonix-Gateway

read -p "Will Run Whonix Workstation on CLI...
Press <Enter> Key to continue..."
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
sudo virsh start Whonix-Workstation

cat 'EOF'
Change this /etc/default/grub on VM Workstation to able console serial
 GRUB_CMDLINE_LINUX_DEFAULT=“console=tty0 console=ttyS0"
 GRUB_TERMINAL=“serial console"
update-grub
EOF
read -p "continue...."
virsh console Whonix-Workstation
else
cat 'EOF'
Go Start - Application - System - Virtual machine Manager
  - Run Gateway
  - Run Workstation
EOF
fi
read -p "Change screen Resolution: "
ls -la /var/run/libvirt/libvirt-sock
