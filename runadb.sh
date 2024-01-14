#!/bin/bash
echo "select option from below"
echo "1. connect to device"
echo "2. uninstall app from device"
echo "3. Memory info of device"
echo "4. Watch Running Services in your device"
echo "5. Watch Running Activities in your device"
echo "6. Pm clear"
echo "7. Toggle Wifi"
echo "8. List Installed App in Device"
echo "9. Show Debug Layout"
echo "10. Get Version Details of App"
echo "11. Pm path"


read -p "Enter your choice (1-11): " choice
case $choice in 
1) echo "Enter Ip address of device"
read tv
adb connect $tv ;;

2) echo "Enter Package name"
read packageName
adb uninstall $packageName
;;

3) echo "Enter time interval (Seconds)"
read seconds
watch -n$seconds "adb shell dumpsys meminfo"
;;

4) echo "Enter Time interval"
read seconds
 watch -n$seconds "adb shell dumpsys activity services | grep "ServiceRecord" | awk '{print $4}' | sed 's/.$//' | sort" 
;;

5) echo "Enter time Interval for running activities"
read seconds
watch -n$seconds "adb shell dumpsys activity activities | sed -En -e '/Running activities/,/Run #0/p'"

;;

6) echo "Enter Package Name to clear"
read packageName
adb shell pm clear $packageName 
;;

7) echo "Enter Time Interval to Toggle wifi"
read time
adb shell svc wifi disable
sleep $time
adb shell svc wifi enable
;;

8) echo "1. List all the packages"
  echo  "2. Only Cloudwalker Apps"
  read -p "enter you choice: " subchoice

  case $subchoice in
  1) adb shell pm list packages ;;
  2) adb shell pm list packages | grep tv.cloudwalker

  esac
;;

9) adb shell setprop debug.layout true
;;

10) echo "Enter Package Name"
  read packageName
adb shell dumpsys package $packageName | grep versionName
;;
 
 11) echo "Enter Package Name"
 read packageName
 adb shell pm path $packageName
 ;;


 *) echo "Invalid Input..try Again"

esac
