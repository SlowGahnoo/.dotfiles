#!/bin/bash

# xrandr --dpi 96 &

# Export parameters for IME
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Export parameters for Ripcord to use system libraries
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/qt/plugins
export QT_QPA_PLATFORMTHEME=qt5ct
export RIPCORD_STYLE_ENGINE=wrong

export DVTM_EDITOR=vim

setxkbmap -option caps:escape &

# Daemons
sxhkd &
dunst &
clipmenud &
xset r rate 300 60 &
unclutter &
fcitx -d &

# Receive notifications from android phone
an2linuxserver.py &

feh --bg-max $HOME/Wallpapers/qwe_download.jpg &

# Run compositor
picom --config $HOME/.config/picom/picom.conf &

source /etc/X11/xinit/xinitrc.d/*
exec dwm
