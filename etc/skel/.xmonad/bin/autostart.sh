#!/bin/env bash

# sets wallpaper using feh
bash $HOME/.xmonad/.fehbg

# polybar
$HOME/.xmonad/polybar/launch.sh

# Fix cursor
xsetroot -cursor_name left_ptr

# kill if already running
killall -9 picom xfce4-power-manager ksuperkey dunst sxhkd

# sets superkey
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# start hotkey daemon
sxhkd &

# Launch notification daemon
dunst \
-geom "280x50-10+38" -frame_width "1" -font "Source Code Pro Medium 10" \
-lb "#2E3440FF" -lf "#D8DEE9FF" -lfr "#4C566AFF" \
-nb "#2E3440FF" -nf "#D8DEE9FF" -nfr "#4C566AFF" \
-cb "#2E3440FF" -cf "#BF616AFF" -cfr "#BF616AFF" &

# start compositor and power manager
xfce4-power-manager &
picom --config $HOME/.xmonad/picom.conf &

# start polkit
if [[ ! `pidof xfce-polkit` ]]; then
    /usr/lib/xfce-polkit/xfce-polkit &
fi

# start udiskie
udiskie &

# replace neovim colorscheme
sed -i "s/theme =.*$/theme = \"norchad\",/g" $HOME/.config/nvim/lua/chadrc.lua
