#!/bin/bash

# xrandr --dpi 96 &

# Export parameters for IME
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Export parameters for Ripcord to use system libraries
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/qt/plugins
export QT_QPA_PLATFORMTHEME=qt6ct
export RIPCORD_STYLE_ENGINE=wrong

source /etc/X11/xinit/xinitrc.d/*

# Daemons
sxhkd &
dunst &
clipmenud &
xset r rate 300 60 &
unclutter &
QT_QPA_PLATFORMTHEME=qt5ct fcitx5 -d &
clight &

# Receive notifications from android phone
# an2linuxserver.py &

feh --bg-fill "$HOME/Wallpapers/1422455757637-4.png" &
     

# Run compositor
picom --config $HOME/.config/picom/picom.conf &


$HOME/.scripts/acpi_notifications &
# python $HOME/.scripts/acpi_handler.py &

setxkbmap -option caps:escape 
exec dwm
