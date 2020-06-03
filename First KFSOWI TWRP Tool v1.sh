#!/usr/bin/env bash
# KFSOWI Tool-Kit
# by Nelson Dane

echo "          # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "          #                                                                           #"
echo "          #                              KFSOWI Tool-Kit                              #"
echo "          #                                                                           #"
echo "          #                               by Nelson Dane                              #"
echo "          #                                                                           #"
echo "          # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"

echo "Your Kindle must be in Fastboot mode."
sleep 2
read -p "Press [Enter] when you are ready to begin the TWRP installation..."



# First 4 Commands
./fastboot -i 0x1949 oem format
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"

./fastboot -i 0x1949 flash boot TWRP/hijack.img
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"

./fastboot -i 0x1949 flash system TWRP/system.img
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"

./fastboot -i 0x1949 continue
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you see the Amazon logo with an orange underline"

# Next 3 steps before booting into TWRP
./fastboot -i 0x1949 flash boot TWRP/recovery.img
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"

./fastboot -i 0x1949 oem format
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"

./fastboot -i 0x1949 continue
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"

echo "You will now boot into TWRP, but you aren't done yet!"
read -p "Press [Enter] once you've booted into TWRP"
echo "You will now be greeted by TWRP asking if you would like to keep /system read only. You do not. Tick never show this screen during boot again and then swipe to allow modifications."
read -p "Press [Enter] once you've swiped to allowed modifications"

# Now we're in TWRP
# Wipe cache and dalvik
./adb shell twrp wipe cache
./adb shell twrp wipe dalvik

echo "If TWRP says it failed to unmount /data or whatever it's ok. If it worked, great!"
read -p "Press [Enter] to continue..."

# ADB Sideload Fire OS
./adb shell twrp sideload
sleep 5
./adb sideload FireOS/update.zip

echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"
read -p "Now we have to sideload SuperSU. Press [Enter] to continue..."
sleep 3

# ADB Sideload SuperSU
./adb shell twrp sideload
sleep 5
./adb sideload SuperSU/SuperSU.zip
echo "Almost done installing TWRP!"
sleep 2
echo "PLEASE UNPLUG AND REPLUG IN YOUR KINDLE"
read -p "Press [Enter] once you've unplugged and replugged in your kindle"
sleep 2
read -p "ONCE YOUR KINDLE POWERS DOWN UNPLUG THE FASTBOOT CABLE SO IT DOESN'T BOOT INTO FASTBOOT! Ready? (Press [Enter] once ready)"

# Reboot into system
./adb reboot
sleep 3
echo "Wait for the Kindle to reboot and then unlock it"
read -p "Press [Enter] once you see the Kindle Fire Home Screen"
read -p "NOW PLUG THE KINDLE BACK IN. Press [Enter] when you have."
sleep 3
read -p "You will soon see SuperSU come up and ask if you would like to allow some ADB shell commands root privileges. Click allow. Press [Enter] when you are ready."
sleep 3

# ADB Shell Commands
./adb push TWRP/recovery.img /sdcard/recovery.img
sleep 3
./adb shell su -c "dd if=/sdcard/recovery.img of=/dev/block/platform/omap_hsmmc.1/by-name/recovery"
sleep 3
./adb push TWRP/exploit.img /sdcard/exploit.img
sleep 3
./adb shell su -c "dd if=/sdcard/exploit.img of=/dev/block/platform/omap_hsmmc.1/by-name/exploit"
sleep 3
./adb shell rm /sdcard/recovery.img /sdcard/exploit.img
echo "Congradulations!! You should have a fully working TWRP on your Kindle!"
echo "To reboot into TWRP recovery, Power down the Kindle. Then press and hold the Volume Down button. Then press the Power Button to turn it on, still holding in Volume Down. Release the Volume Down when you see the Amazon logo."
