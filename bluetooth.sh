#! /bin/bash
# 蓝牙连接脚本

AirPods=A3:D3:B4:53:A3:E2

ls() {
    echo h1  bluetoothctl connect AirPods
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
    *)    ls ;;
esac
