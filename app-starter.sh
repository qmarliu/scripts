#! /bin/bash
# 命令调用脚本

set_vol() {
    # case $1 in
    #     up) pactl set-sink-volume 0 +5% ;;
    #     down) pactl set-sink-volume 0 -5% ;;
    case $1 in
        up) amixer -D pulse sset Master 5%+ ;;
        down) amixer -D pulse sset Master 5%- ;;
    esac
    ~/scripts/dwm-status-update.sh
}

case $1 in
    killw) kill -9 $(xprop | grep "_NET_WM_PID(CARDINAL)" | awk '{print $3}') ;;
    filemanager) thunar ;;
    alacritty) alacritty ;;
    st) st ;;
    rofi) rofi -show run ;;
    rofi_window) rofi -show window -show-icons ;;
    rofi_drun) rofi -show drun -show-icons ;;
    keepass) keepass;;
    xlock) xlock -mode puzzle;;
    chrome) google-chrome-stable --proxy-server=socks5://localhost:1081 ;;
    flameshot) flameshot gui -c -p ~/Pictures/screenshots ;;
    open_last_screenshot) eog ~/Pictures/screenshots/$(ls -t ~/Pictures/screenshots | sed '2,9999d') >> /dev/null 2>&1 & ;;
    set_vol) set_vol $2 ;;
    change_wallpaper) ~/scripts/wp-change.sh ;;
    wechat) /opt/apps/com.qq.weixin.deepin/files/run.sh ;;
    qq) /opt/apps/com.qq.office.deepin/files/run.sh ;;
    music) netease-cloud-music ;;
    dingtalk) dingtalk ;;
    dbeaver) dbeaver ;;
    keepassxc) keepassxc ;;
    picom) picom --experimental-backends --config ~/scripts/config/picom.conf >> /dev/null 2>&1 & ;;
esac
