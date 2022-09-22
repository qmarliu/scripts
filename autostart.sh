#!/bin/bash

clash -f ~/.config/clash/config_aliyun.yaml > ~/.config/clash/log.txt 2>&1 &
~/scripts/app-starter.sh picom
fcitx5 &
/bin/bash ~/scripts/wp-autochange.sh &
/bin/bash ~/scripts/dwm-refresh-status.sh &
/bin/bash ~/scripts/tap-to-click.sh &
/bin/bash ~/scripts/inverse-scroll.sh &

