# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . ~/.xprofile
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# set scrolling and input delay to 200ms
xset r rate 150

# make second screen display a second workspace
xrandr --output HDMI1 --right-of eDP1

# Set the compose key
setxkbmap -option "compose:caps"

# Fire up i3
exec i3 -V >> ~/i3logs/i3log-$(date +'%F-%k-%M-%S') 2>&1
