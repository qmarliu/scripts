# rofi -show 自定义 -modi "自定义:~/rofi.sh"
#   1: 上述命令可调用rofi.sh作为自定义脚本
#   2: 将打印的内容作为rofi的选项
#   3: 每次选中后 会用选中项作为入参再次调用脚本
#   4: 当没有输出时 整个过程结束

# !!! 确保所有item没有重复的 !!!
main_menu_item[1]="set wallpaper"        ; main_cmd[1]='~/scripts/wp-change.sh; main_menu'
main_menu_item[2]="wifi"                 ; main_cmd[2]='rofi-wifi-menu'
main_menu_item[3]="picom"                ; main_cmd[3]='killall picom || ~/scripts/app-starter.sh picom'
main_menu_item[4]="open last screenshot" ; main_cmd[4]='~/scripts/app-starter.sh open_last_screenshot'
main_menu_item[5]="bluetooth"            ; main_cmd[5]='bluetooth_menu'

bluetooth_menu_item[1]="connect airpod" ; bluetooth_cmd[1]='~/scripts/bluetooth.sh h1 >> /dev/null &'

main_menu() {
    echo -e "\0prompt\x1fmenu"
    for item in "${main_menu_item[@]}"; do
        echo "$item"
    done
}
bluetooth_menu() {
    echo -e "\0prompt\x1fbluetooth"
    for item in "${bluetooth_menu_item[@]}"; do
        echo "$item"
    done
}

[ ! "$*" ] && main_menu
for i in "${!main_menu_item[@]}"; do
    [ "$*" = "${main_menu_item[$i]}" ] && eval "${main_cmd[$i]}"
done
for i in "${!bluetooth_menu_item[@]}"; do
    [ "$*" = "${bluetooth_menu_item[$i]}" ] && eval "${bluetooth_cmd[$i]}"
done
