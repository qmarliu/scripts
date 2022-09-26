#! /bin/bash
# 蓝牙连接脚本

AirPods=54:2B:8D:49:CC:7C

ls() {
    echo h1  bluetoothctl connect AirPods
    echo dh1  bluetoothctl disconnect AirPods
}
blconnect() {
    bluetoothctl connect $1
    notify-send 蓝牙设备 "$1已连接"
    ~/scripts/dwm-status.sh
}
bldisconnect() {
    bluetoothctl disconnect $1
    notify-send 蓝牙设备 "$1已断开"
    ~/scripts/dwm-status.sh
}
case $1 in
    h1)   blconnect $AirPods;;
    dh1)  bldisconnect $AirPods;;
    *)    ls ;;
esac
