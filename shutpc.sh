#!/usr/bin/env bash

CHOICE1=$(zenity --list \
    --height=220 \
    --title="List" \
    --text="Options" \
    --radiolist \
    --column="" --column="Option" \
    FALSE "Shutdown" \
    FALSE "Restart" \
    FALSE "Suspend" \
    TRUE "Hibernate")

case $CHOICE1 in
    "Shutdown")
        echo "shutdown..."
        sudo shutdown -h now
    ;;
    "Restart")
        echo "restart..."
        sudo reboot
    ;;
    "Suspend")
        echo "suspend..."
        gnome-screensaver-command -l
    ;;
    "Hibernate")
        echo "hibernate..."
        sudo s2disk
    ;;
esac  
