[ -f ~/.xprofile ] && . ~/.xprofile
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# set scrolling and input delay to 150ms
xset r rate 150

# make second screen display a second workspace
xrandr --output HDMI1 --right-of eDP1

# Set the compose key
# setxkbmap -option "compose:caps"
# xmodmap ~/.Xmodmap

# Fire up i3
exec i3 -V >> ~/logs/i3log-$(date +'%F-%k-%M-%S') 2>&1
