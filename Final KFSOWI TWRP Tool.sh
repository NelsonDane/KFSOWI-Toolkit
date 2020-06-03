#!/usr/bin/env bash
# KFSOWI Tool-Kit
# by Nelson Dane

# Color Variables
bold=$(tput bold)
normal=$(tput sgr0)
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blue=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

clear
echo " # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo " #                                                                           #"
echo " #                              KFSOWI Tool-Kit                              #"
echo " #                                                                           #"
echo " #                               by Nelson Dane                              #"
echo " #                                                                           #"
echo " # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo ""
echo "Your Kindle ${bold}must${normal} be in Fastboot mode."
echo "${blue}Due to some bugs in Fastboot, you will need to unplug and replug in your kindle after every command. Don't worry though, there will be prompts telling you when to do it.${normal}"
sleep 1
read -p "Press [Enter] when you are ready to begin the TWRP installation..."

# Begin downloading necessary files and check if they're already there...
clear
echo "${blue}First we need to download a few files...${normal}"
echo ""
# CD into Downloads folder...
cd Downloads
# Check for files already downloaded...
# SuperSU
if [ -e SuperSU.zip ] ; then
  echo "${blue}You already have SuperSU. Moving on...${normal}"
  echo ""
else
  echo "${blue}Downloading SuperSU...${normal}"
  curl -o SuperSU.zip https://s3-us-west-2.amazonaws.com/supersu/download/zip/SuperSU-v2.82-201705271822.zip
fi
# Exploit
# Can't figure out how to download this right now...

# FireOS
## FireOS download menu
function menu () {
echo "${blue}Which version of FireOS would you like to download?${normal}"
echo "1. FireOS 4.5.5.3"
echo "2. FireOS 4.5.5.2"
echo "3. FireOS 4.5.5.1"
echo "4. FireOS 3.5.2"

read -p "${blue}Enter your choice: ${normal}" num;
}
function  menujob () {
  case $num in
    1)
    installFireOS=4.5.5.3
    if [ -e FireOS4.5.5.3.zip ] ; then
      echo "${blue}You already have FireOS 4.5.5.3 downloaded. Moving on...${normal}"
      echo ""
    else
      echo "Dowloading FireOS 4.5.5.3..."
      curl -o FireOS4.5.5.3.zip https://fireos-tablet-src.s3.amazonaws.com/SAsacHmumgrMpCXPdw6oykKMaw/update-kindle-11.4.5.5_user_455006120.bin
    fi
        sleep 2
        break
    ;;

    2)
    installFireOS=4.5.5.2
    if [ -e FireOS4.5.5.2.zip ] ; then
      echo "${blue}You already have FireOS 4.5.5.2 downloaded. Moving on...${normal}"
      echo ""
    else
      echo "Downloading FireOS 4.5.5.2..."
      curl -o FireOS4.5.5.2.zip https://kindle-fire-updates.s3.amazonaws.com/KynfkjCCIcnvbdhpwFlQ4xjyiw/update-kindle-11.4.5.5_user_455004220.bin
    fi
        sleep 2
        break
    ;;

    3)
    installFireOS=4.5.5.1
    if [ -e FireOS4.5.5.1.zip ] ; then
      echo "${blue}You already have FireOS 4.5.5.1 downloaded. Moving on...${normal}"
      echo ""
    else
      echo "Downloading FireOS 4.5.5.1..."
      curl -o FireOS4.5.5.1.zip https://us.softpedia-secure-download.com/dl/09672409ae89d7cc4c29f662f34a326f/59d7f021/300487321/drivers/tablets/update-kindle-11.4.5.5_user_455002120.bin
    fi
        sleep 2
        break
    ;;

    4)
    installFireOS=3.5.2
    if [ -e FireOS3.5.2.zip ] ; then
      echo "${blue}You already have FireOS 3.5.2 downloaded. Moving on...${normal}"
      echo ""
    else
      echo "Downloading FireOS 3.5.2..."
      curl -o FireOS3.5.2 https://kindle-fire-updates.s3.amazonaws.com/update-kindle-11.3.2.5_user_325001620.bin
    fi
        sleep 2
        break
    ;;
  esac
  clear
}

function pause(){
   read -p "$*"
}

printf '\e[8;25;100t'

i=0;while [ $i -le 5 ];
do
menu
menujob $num
done
## FireOS download menu done

# CD back up...
cd ..
clear
# Installing TWRP!
# First 4 Commands

echo "${blue}Now we're ready to start installing TWRP!${normal}"

./fastboot -i 0x1949 oem format
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"

clear
echo "${blue}Flashing boot...${normal}"
./fastboot -i 0x1949 flash boot TWRP/hijack.img
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"

clear
echo "${blue}Flashing system...${normal}"
./fastboot -i 0x1949 flash system TWRP/system.img
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"

clear
echo "${blue}Continuing boot...${normal}"
./fastboot -i 0x1949 continue
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you see the ${bold}Amazon logo with an orange underline${normal} on your kindle screen"

# Next 3 steps before booting into TWRP
clear
echo "${blue}Flashing TWRP...${normal}"
./fastboot -i 0x1949 flash boot TWRP/recovery.img
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"

clear
./fastboot -i 0x1949 oem format
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"

clear
echo "${blue}Booting into TWRP...${normal}"
./fastboot -i 0x1949 continue
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"

clear
echo "${blue}You will now boot into TWRP, but you aren't done yet!"
read -p "Press [Enter] when you've booted into TWRP"

clear
echo "${blue}When TWRP boots up for the first time it will ask if you'd like to allow system modifications. Tick never show this screen again and the swipe to allow modifications.${normal}"
read -p "Press [Enter] when you've swiped to allowed modifications"

# Now we're in TWRP
# Wipe cache and dalvik
clear
echo "${blue}Wiping Cache and Dalvik cache...${normal}"
./adb shell twrp wipe cache
./adb shell twrp wipe dalvik

echo "${blue}Now we need to sideload the FireOS you downloaded.${normal}"
read -p "Press [Enter] to continue..."

# ADB Sideload Fire OS
clear
echo "${blue}Sideloading FireOS...${normal}"
./adb shell twrp sideload
sleep 3

# Checking to see what FireOS to install, based on users download...
if [ $installFireOS == 4.5.5.3 ] ; then
  ./adb sideload Downloads/FireOS4.5.5.3.zip
fi
if [ $installFireOS == 4.5.5.2 ] ; then
  ./adb sideload Downloads/FireOS4.5.5.2.zip
fi
if [ $installFireOS == 4.5.5.1 ] ; then
  ./adb sideload Downloads/FireOS4.5.5.1.zip
fi
if [ $installFireOS == 3.5.2 ] ; then
  ./adb sideload Downloads/FireOS3.5.2.zip
fi


echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"
clear
echo "${blue}Now we have to sideload SuperSU.${normal}"
read -p "Press [Enter] to continue..."

# ADB Sideload SuperSU
clear
echo "${blue}Sideloading SuperSU...${normal}"
./adb shell twrp sideload
sleep 3
./adb sideload Downloads/SuperSU.zip
echo "${blue}You're almost done!${normal}"
echo ""
echo "${red}PLEASE UNPLUG AND REPLUG IN YOUR KINDLE${normal}"
read -p "Press [Enter] when you've unplugged and replugged in your kindle"
sleep 2

# Reboot into system
clear
echo "${blue}Rebooting into System...${normal}"
./adb reboot
sleep 3
clear
echo "${blue}Wait for the Kindle to reboot and then unlock it/set it up.${normal}"
read -p "Press [Enter] when you have set up the Kindle and are on the Kindle Fire Home Screen."
clear
read -p "${blue}NOW PLUG THE KINDLE BACK IN. Press [Enter] when you have plugged in the Kindle...${normal}"
sleep 3
clear
echo "${blue}When SuperSU asks if you would like to allow some ADB Shell commands root privileges, click allow.${normal}"
read -p "Press [Enter] when you are ready to continue..."
sleep 2
clear

# Return variable installFireOS to nothing
installFireOS=Null

# ADB Shell Commands
./adb push TWRP/recovery.img /sdcard/recovery.img
sleep 2
./adb shell su -c "dd if=/sdcard/recovery.img of=/dev/block/platform/omap_hsmmc.1/by-name/recovery"
sleep 2
./adb push TWRP/exploit.img /sdcard/exploit.img
sleep 2
./adb shell su -c "dd if=/sdcard/exploit.img of=/dev/block/platform/omap_hsmmc.1/by-name/exploit"
sleep 2
./adb shell rm /sdcard/recovery.img /sdcard/exploit.img
clear
echo "${blue}Congradulations! You now have a fully working TWRP and Root on your Kindle!${normal}"
