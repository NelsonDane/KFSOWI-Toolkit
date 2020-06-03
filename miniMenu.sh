#!/usr/bin/env bash
# KFSOWI Tool-Kit
# by Nelson Dane

function menu () {
echo "Menu"


read -p "Enter your choice: " num;
}
function  menujob () {
  case $num in
    1) echo "1"
        echo ""
        sleep 2
    ;;

    2) echo "2"
    ;;

    3) echo "3"
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
