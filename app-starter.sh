#! /bin/bash
# 命令调用脚本

set_vol() {
    # case $1 in
    #     up) pactl set-sink-volume 0 +5% ;;
    #     down) pactl set-sink-volume 0 -5% ;;
    case $1 in
        up) amixer -D pulse sset Master 5%+
            volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
            notify-send " 🔉   音量升高 ${volume}" -t 2000
          ;;
        down) amixer -D pulse sset Master 5%-
            volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
            notify-send " 🔉   音量降低 ${volume}" -t 2000
          ;;
    esac
    ~/scripts/dwm-status-update.sh
}

# 检查是否已经启动，如果启动就不启动了。
start_single_app() {
  if [ $(ps -ef | grep $1 | grep -vc grep) -eq 0 ]; then $2
  fi
}
case $1 in
    killw) kill -9 $(xprop | grep "_NET_WM_PID(CARDINAL)" | awk '{print $3}') ;;
    filemanager) thunar ;;
    alacritty) alacritty ;;
    st) st ;;
    rofi_run) rofi -show run ;;
    rofi_window) rofi -show window -show-icons ;;
    rofi_calc) rofi -show calc ;;
    rofi_emoji) rofi -show emoji ;;
    rofi_drun) rofi -show drun -show-icons ;;
    rofi_combi) rofi -show combi -show-icons ;;
    rofi_menu) rofi -show menu -modi "menu:~/scripts/rofi.sh"  ;;
    keepass) keepass;;
    xlock) xlock -mode puzzle ;;
    lock)  betterlockscreen -l ;;
    chrome) google-chrome-stable --proxy-server=socks5://localhost:1081 ;;
    flameshot) flameshot gui -c -p ~/Pictures/screenshots ;;
    open_last_screenshot) eog ~/Pictures/screenshots/$(ls -t ~/Pictures/screenshots | sed '2,9999d') >> /dev/null 2>&1 & ;;
    set_vol) set_vol $2 ;;
    change_wallpaper) ~/scripts/wp-change.sh ;;
    # wechat) /opt/apps/com.qq.weixin.deepin/files/run.sh ;;
    wechat) start_single_app WeChat.exe /opt/apps/com.qq.weixin.deepin/files/run.sh ;;
    # qq) /opt/apps/com.qq.office.deepin/files/run.sh ;;
    qq) start_single_app TIM.exe /opt/apps/com.qq.office.deepin/files/run.sh ;;
    music) netease-cloud-music ;;
    dingtalk) dingtalk ;;
    dbeaver) dbeaver ;;
    keepassxc) keepassxc ;;
    picom) picom --experimental-backends --config ~/scripts/config/picom.conf >> /dev/null 2>&1 & ;;
esac
