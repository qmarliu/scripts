#!/bin/bash

feh --bg-scale ~/Pictrue/background/5.jpg
xsetroot -name qmarliu
picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
fcitx5 &
/home/liul/Exe/squashfs-root/AppRun &
xfce4-power-manager &

/bin/bash ~/scripts/wp-autochange.sh &

