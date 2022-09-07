#!/bin/bash

clash > ~/.config/clash/log.txt 2>&1 &
picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
fcitx5 &
/bin/bash ~/scripts/wp-autochange.sh &
/bin/bash ~/scripts/dwm-refresh-status.sh &
/bin/bash ~/scripts/tap-to-click.sh &
/bin/bash ~/scripts/inverse-scroll.sh &

