#!/bin/bash

s2d_reset="^d^"
s2d_fg="^c"
s2d_bg="^b"

# https://tool.oschina.net/commons?type=3 选颜色
DarkSlateGray="#2F4F4F^"
Black="#000000^"
LightCyan4="#7A8B8B^"
Moccasin="#FFE4B5^"
RosyBrown1="#FFC1C1^"
Orchid1="#FF83FA^"
SteelBlue1="#63B8FF^"

  bat_color="$s2d_fg$LightCyan4$s2d_bg$Black"
  mem_color="$s2d_fg$SteelBlue1$s2d_bg$Black"
  vol_color="$s2d_fg$RosyBrown1$s2d_bg$Black"
 time_color="$s2d_fg$Orchid1$s2d_bg$Black"


print_volume() {
	volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	# volume="$(pactl get-sink-volume 0 | head -n1 | sed -r 's/.* (.*)% .*/\1/')"
  if [ "$volume" -eq 0 ];
  then vol_icon="ﱝ ";
  else vol_icon=" ";
	fi
  text=" $vol_icon$volume "
  color=$vol_color
  if [ "$(bluetoothctl devices Connected | wc -l)" -gt 0 ];
  then text=" 🎧$text";
  fi
  printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_bat() {
  bat_text=$(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+")
  [ ! "$bat_text" ] && bat_text=$(acpi -b | sed 2d | awk '{print $5}' | grep -Eo "[0-9]+")
  [ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] && charge_icon=""
  if  [ "$bat_text" -ge 95 ]; then charge_icon=""; bat_icon="";
  elif [ "$bat_text" -ge 90 ]; then bat_icon="";
  elif [ "$bat_text" -ge 80 ]; then bat_icon="";
  elif [ "$bat_text" -ge 70 ]; then bat_icon="";
  elif [ "$bat_text" -ge 60 ]; then bat_icon="";
  elif [ "$bat_text" -ge 50 ]; then bat_icon="";
  elif [ "$bat_text" -ge 40 ]; then bat_icon="";
  elif [ "$bat_text" -ge 30 ]; then bat_icon="";
  elif [ "$bat_text" -ge 20 ]; then bat_icon="";
  elif [ "$bat_text" -ge 10 ]; then bat_icon="";
  else bat_icon=""; fi

  if [[ -z $bat_text ]]; then
    return
  fi
  bat_icon=$charge_icon$bat_icon
  text=" $bat_icon $bat_text "
  color=$bat_color
  printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_mem() {
  mem_total=$(cat /proc/meminfo | grep "MemTotal:"|awk '{print $2}')
  mem_free=$(cat /proc/meminfo | grep "MemFree:"|awk '{print $2}')
  mem_buffers=$(cat /proc/meminfo | grep "Buffers:"|awk '{print $2}')
  mem_cached=$(cat /proc/meminfo | grep -w "Cached:"|awk '{print $2}')
  men_usage_rate=$(((mem_total - mem_free - mem_buffers - mem_cached) * 100 / mem_total))
  mem_icon=""
  mem_text=$(echo $men_usage_rate | awk '{printf "%02d%", $1}')
  text=" $mem_icon $mem_text "
  color=$mem_color
  printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_time() {
  time_text="$(date '+%m/%d %H:%M %a')"
  case "$(date '+%I')" in
    "01") time_icon="" ;;
    "02") time_icon="" ;;
    "03") time_icon="" ;;
    "04") time_icon="" ;;
    "05") time_icon="" ;;
    "06") time_icon="" ;;
    "07") time_icon="" ;;
    "08") time_icon="" ;;
    "09") time_icon="" ;;
    "10") time_icon="" ;;
    "11") time_icon="" ;;
    "12") time_icon="" ;;
  esac

  text=" $time_icon $time_text "
  color=$time_color
  printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

# xsetroot -name "$(print_bat)$(print_mem)$(print_volume)$(print_time)"
xsetroot -name "$(print_bat)$(print_volume)$(print_time)"
