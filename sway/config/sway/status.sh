date_formatted=$(date "+%m/%d/%Y - %l:%M %p - ")

battery_status=$(cat /sys/class/power_supply/BAT0/capacity)

if [ -f "$battery_status_file" ]; then
  echo $battery_status% - $date_formatted 
else
  echo $date_formatted 
fi
