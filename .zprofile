if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx > ~/logs/xstartlog-$(date +'%F-%k-%M-%S')
fi
