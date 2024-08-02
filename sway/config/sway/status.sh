date_formatted=$(date "+%m/%d/%Y - %l:%M %p - ")
battery_status_file="/sys/class/power_supply/BAT0/capacity"

if [ -f "$battery_status_file" ]; then
  battery_status=$(cat $battery_status_file)
  echo "$battery_status% - $date_formatted"
else
  echo "$date_formatted"
fi
