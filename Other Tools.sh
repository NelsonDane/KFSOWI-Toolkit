#!/usr/bin/env bash
# KFSOWI Tool-Kit
# by Nelson Dane

# Color variables in case I want to add colors
bold=$(tput bold)
normal=$(tput sgr0)
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

function menu ()
{
echo "          # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "          #                                                                           #"
echo "          #                         Other Tools for the KFSOWI                        #"
echo "          #                                                                           #"
echo "          #                               by Nelson Dane                              #"
echo "          #                                                                           #"
echo "          # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"

echo ""
echo "                                   1. Flash GAPPS to get Google Play "
echo "                                   2. Install Xposed "
echo "                                   3. Install Nova Launcher"
echo ""
echo "                                       REBOOT OPTIONS"
echo ""
echo "                                   4. Reboot"
echo "                                   5. Reboot Recovery"
echo "                                   6. Get out of Fastboot"
echo ""
echo "                                     UNINSTALL OPTIONS"
echo ""
echo "                                   7. Uninstall GAPPS"
echo "                                   8. Uninstall Xposed"
echo "                                   9. Uninstall Nova Launcher"
echo "                                  10. Return Kindle to Stock"


echo ""



read -p "                Enter your choice : " num;

}

function menujob ()
{
	case $num in

		1)  echo " Flashing GAPPS..."

            echo ""

            ./adb reboot recovery
            read -p "Press [Enter] once you are in TWRP"
            sleep 1
            ./adb shell twrp sideload
            sleep 3
            ./adb sideload Gapps/KFSOWIgapps.zip
            sleep 2
            ./adb shell twrp wipe cache
            sleep 1
            ./adb shell twrp wipe dalvik
            sleep 1
            echo "Please unplug and replug in your Kindle"
            read -p "Press [Enter] once you unplugged and replugged in your Kindle"
            sleep 3
            ./adb reboot
            ;;

        2)  echo " Installing Xposed... "

            echo ""

						cd Downloads
						curl -o XposedInstaller_v2.6.1_by_SolarWarez_20151129.apk https://forum.xda-developers.com/attachment.php?attachmentid=3559144&d=1448805545
						cd ..
						./adb install Downloads/XposedInstaller_v2.6.1_by_SolarWarez_20151129.apk
            ./adb reboot recovery
            read -p "Press [Enter] when you are in TWRP"
            ./adb shell twrp install Downloads/Xposed-Installer-Recovery.zip
            sleep 1
            ./adb reboot

            ;;


        3)  echo " Installing Nova Launcher..."

            echo ""

            curl -o novalauncher.apk http://teslacoilsw.com/tesladirect/download.pl?packageName=com.teslacoilsw.launcher
            ./adb install novalauncher.apk

            file="novalauncher.apk"

            if [ -f $file ] ; then
            rm $file
            fi

            ;;

        4)  echo " Rebooting..."

            echo ""

            ./adb reboot
            ;;

        5) echo " Rebooting into TWRP Recovery..."

            echo ""

            ./adb reboot recovery
            ;;

        6)  echo " Booting into System..."

            echo ""

            ./fastboot -i 0x1949 continue
            ;;

        7) echo " Uninstalling GAPPS... "

            echo ""

            ./adb reboot recovery

            ;;

        8) echo " Uninstalling Xposed..."

            echo ""

            ./adb uninstall de.robv.android.xposed.installer
            sleep 3
            ./adb reboot recovery
            read -p "Press [Enter] when you are in TWRP"
            ./adb shell twrp install Xposed/Xposed-Disabler-Recovery.zip
            sleep 2
            ./adb reboot

            ;;

        10)  echo " Returning to Stock..."

            read -p "Are you sure you wish to return your Kindle to stock? THIS WILL ERASE ALL YOUR DATA AND WILL UNROOT YOUR DEVICE AND YOU WILL LOSE ACCESS TO TWRP. Press [Enter] to continue..."

            echo ""

            ./adb reboot recovery
            read -p "Press [Enter] once you are in TWRP"
            # Wiping in TWRP

            sleep 2
            ./adb shell twrp wipe factoryreset
	    ./adb shell twrp wipe system
            sleep 2
            # Install Fire OS
            ./adb shell twrp sideload
            sleep 5
            ./adb sideload ./files/Downloads/FireOS4.5.5.3.zip
            sleep 5
            ./adb reboot

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
