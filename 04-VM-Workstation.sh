#!/bin/bash
## 04-VM-Workstation.sh
## Continue of Anonguide-Debian.sh
## Hellrezistor Contribution to Anonguide.pdf
## Respect and support Anon
## V2.21
## 
## This script its the 2nd STEP TO DO
## After your Whonix Workstation 1ST Step
##

# PART II #
read -p "PLEASE FOLLOW THIS RECOMMENDATIONS!!!!!! Press <Enter> Key to continue..."

cat 'EOF'
Open KeePassXC:
 - Tools 
 - Settings 
 - Security 
   -- (v) Lock databases after inactivity xxxx security
 - Create new databases 
   -- /home/user/storage 
   -- Enter PASSWORD
 - Entries
   -- Add new Entry AND Fill the fields: 
      ---Title 
      --- Username 
      --- URL 
      --- CLICK symbol frente a Repeat pwd 
      --- Put Length: 32 
      --- Able SpecialChars
      --- UNcheck Exclude look-like chars
      --- CLICK APPLY
    -- OK
Close KeePassXC

######################################################################################
## More info about a forgotten changed password CHECK anonguide.pdf pages. 345 a 13 ##
######################################################################################
EOF

read -p "When FINICHED KeePassXC Press <Enter> Key to continue"

cat 'EOF'
Go to above site do Register an new email with Tor Browser
http://danielas3rtn54uwmofdo3x2bsdifr47huasnmbgqzfrec5ubupvtpid.onion/mail/postfixadmin/register.php
Thank you danwin!!!

When creating usermail Dont forget create a new entry on KeePassXC AND GENERATE Password

Open Thunderbird
 - Fill: Alias 
   -- usermail@danielas3rtn54uwmofdo3x2bsdifr47huasnmbgqzfrec5ubupvtpid.onion 
   -- NO PASSWORD 
   -- UNCHECK Remember password 
   -- Advanced
     ---Check POP3: danielas3rtn54uwmofdo3x2bsdifr47huasnmbgqzfrec5ubupvtpid.onion

 - Email Settings 
   -- ServerSettings
     --- Remove configs (check anonguide.pdf)
   -- Copies & Folders - LocalFolders 
     --- SMTP Edit 
       ---- Port: 25 
       ---- ConnectSec None 
       ---- Pwd, insecure
       ---- usermail 
 - Enigmail
   -- Create Cert to usermail
   -- Create Revoke Cert (Set a EasyNameToRevokeCert.asc)
   -- Upload PGP Keyservers
EOF

read -p "When these step finished. Press <Enter> Key to continue..."

read -p "What is your EasyNameToRevokeCert.gpg" EasyNameToRevokeCert
mkdir storage/gpg-revoke 
gpg --cipher-algo AES256 --symmetric $EasyNameToRevokeCert
mv *.gpg storage/gpg-revoke

## To revoke a KEY
##$ gpg -o $EasyNameToRevokeCert.asc -d ~/storage/gpg-revoke/$EasyNameToRevokeCert.gpg

cat 'EOF'
Preferences 
 -- Advanced
  --- General 
   ---- Config Editor
    ----- Search to “network.dns.blockDotOnion” set TRUE
   ---- UNCHECK Global Search 
   ---- Return Receipts 
    ----- CHECK "Never send a return receipt"
  --- Network & Disk Space 
   ---- Connection Setting 
    ----- CheckBox ON “Proxy DNS 
  --- Data Choices 
   ---- UNCHECK Crash Reporter
 -- Privacy
  --- UNCHECK "Remember websites.."
 -- OpenPGP Sec 
  --- CHECK "Encrypt msgs defalt" -
  --- UNCHECK PGP/MIME 
  --- CHECK "Sign encrpt msgs"
##############################################
## ###### DONT CLICK "OK" BUTTON YET ###### ##
##############################################
EOF

read -p "When these step finished. Press <Enter> Key to continue..."

cat 'EOF'
 Enigmail
  - Preferences 
   -- Sending
    --- CHECK "Manually cnfg encrpt settng"
    --- "Confirm before sending" ALWAYS

################################################
###### ## On OpenPGP Sec Click "OK" !! ###### ##
################################################

 Enigmail
  - Keyserver 
   -- Search KEY ---> 81934E7B83E89CFD8C25F3D67FBD040886EC5FE0 <-- || Keyserver --> hkp://jirk5u4osbsr34t5.onion <-- 


########################################################################################################
##       C H E C K   A N O N G U I D E  T O  A D D  A L I A S E S
# VERIFY entry for "anonguide@vfemail.net" with a Key ID starting with "81934E7B"
## Double click on MyAlias <usermail@...>
## Manage User IDs - Add - MyAlias -usermail@danielas3rtn54uwmofdo3x2bsdifr47huasnmbgqzfrec5ubupvtpid.onion
##  Set primary usermail@danwin1210.com 
## Copy FingerPrint jijk A1B2 jkjh jijk C3F9 F9F9 F9AA SDVC 34lkj jkjh
## Upload Public Keys to Keyserver
#############################################################################################
EOF

read -p "When these step finished. Press <Enter> Key to continue..."

cat 'EOF'
 Thunderbird
  - Email Settings 
   -- Signature Text Add
    --- GPG Public Key: 0xF9AASDVC34lkjjkjh (THIS ARE THE LAST 4 blocks of Fingerprint in low-case)
    --- FingerPrint: jijk A1B2 jkjh jijk C3F9 F9F9 F9AA SDVC 34lkj jkjh

########################################################
## Try send mail to: anonguide@tt3j2x4k5ycaa5zt.onion ##
########################################################
EOF
read -p "When FINICHED Thunderbird Press <Enter> Key to continue"

echo "## HexChat TIME ##"
sleep 2

mkdir .config/hexchat/certs 
cd .config/hexchat/certs 
openssl req -x509 -new -newkey rsa:4096 -sha256 -days 1827 -nodes -out CGAN.pem -keyout CGAN.pem 
echo && echo "## Enter all defaults ##" && echo 
FNGROUTPUT=$(openssl x509 -sha1 -noout -fingerprint -in CGAN.pem | sed -e 's/^.*=//;s/://g;y/ABCDEF/abcdef/')

cat 'EOF'
Open Hexchat
- Settings 
  -- Preferences 
   --- Login
    ---- Uncheck Display scrollback 
    ---- UNcheck Enable Logging 
    ---- Uncheck enable URL grabber
   -- Advanced
    --- Uncheck Automaticclly reconnect 
   -- Click OK 
- Network List...
  -- Put "CGAN" 
  -- Click "Add"
  -- Click Edit
   --- Put "6dvj6v5imhny3anf.onion/6697" 
	 --- Uncheck Use global 
	 --- Put NICK 
	 --- CHECK Use SSL 
	 --- CHECK ACCEPT invalid 
	 --- Login method: SAS EXTERNAL (cert) 
	 --- CLOSE
  -- Select CGAN 
	 --- Connect
    ---- Check Nothing
    ---- Check Always show
   --- OK 
EOF

read -p "After These Config PRESS <Enter> Key to continue to how use HexChat"

cat 'EOF'
### After Connected ###
### Let's create and register your IRCNickname ###
/otr genkey IRCNickname@CGAN

## DONT FORGET!! USE SAME Email PASSWORD NICKNAME of the KEEPASSXC
/msg nickserv REGISTER YourENCRYPTEDPassword somefakemail@fakedom.com 
/msg nickserv cert add $FNGROUTPUT 

/j #vhost
!vhost some.fake.host 
## If settup right. You will KICKED from channel ... Close that window

Server 
  -List of Channels 
  - Download List 
  - Join a channel

############################################################
## PVT with a USER !!!REMEMBER!!!! Open pvt chat and RUN: ##
############################################################
/otr start
/otr trust
################################################################################
##  If DURING chatting returns "user not authenticated" maybe is a IMPOSTOR.  ##
################################################################################
/otr finish
EOF

read -p "When FINICHED HexChat IRC Press <Enter> Key to continue"

echo "CONGRATULATIONS!
YOU ARE FINISHED THE VM Whonix Workstation With a new IDentity"
sleep 3
read -p "Now BACK TO DEbian HOST and PRESS THE KEY to continue 01-Anonguide-Debian.sh "
