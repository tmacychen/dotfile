#!/bin/bash

action=$(echo -e "lock\nlogout\nshutdown\nreboot" | rofi -config ~/.config/i3/rofi -dmenu -p "power:")

if [[ "$action" == "lock" ]]
then
    dde-lock
fi

if [[ "$action" == "logout" ]]
then
    i3-msg exit
fi

if [[ "$action" == "shutdown" ]]
then
    shutdown now
fi

if [[ "$action" == "reboot" ]]
then
    reboot
fi
