#!/bin/bash
# Screenshot: http://s.natalian.org/2013-08-17/dwm_status.png
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

# This function parses /proc/net/dev file searching for a line containing $interface data.

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.

print_volume() {
	# volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	volume="$(pactl get-sink-volume 0 | head -n1 | sed -r 's/.* (.*)% .*/\1/')"
  if [ "$volume" -eq 0 ];
  then echo -e "ﱝ";
  else echo -e "🔈 ${volume}";
	fi
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
  echo "$bat_icon $bat_text%"
}

print_mem() {
  mem_total=$(cat /proc/meminfo | grep "MemTotal:"|awk '{print $2}')
  mem_free=$(cat /proc/meminfo | grep "MemFree:"|awk '{print $2}')
  mem_buffers=$(cat /proc/meminfo | grep "Buffers:"|awk '{print $2}')
  mem_cached=$(cat /proc/meminfo | grep -w "Cached:"|awk '{print $2}')
  men_usage_rate=$(((mem_total - mem_free - mem_buffers - mem_cached) * 100 / mem_total))
  mem_icon=""
  mem_text=$(echo $men_usage_rate | awk '{printf "%02d%", $1}')
  echo "$mem_icon $mem_text"
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

  echo "$time_icon $time_text"
}

xsetroot -name "$(print_bat)$(print_mem)$(print_volume)$(print_time)"
