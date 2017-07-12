# Make sure this is before the 'exec' command or it won't be sourced.
# [ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# set scrolling and input delay to 200ms
xset r rate 150

# make second screen display a second workspace
xrandr --output HDMI1 --right-of eDP1

# Set the compose key
setxkbmap -option "compose:rctrl"

# Fire up my beloved window manager
exec i3 -V >> ~/i3logs/i3log-$(date +'%F-%k-%M-%S') 2>&1
