#!/bin/sh

SINK=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1 )
NOW=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )


if [ "$1" = "inc" ]
then
    pactl set-sink-volume $SINK +5%;
    volnoti-show $NOW;
elif [ "$1" = "dec" ]
then
    pactl set-sink-volume $SINK -5%;
    volnoti-show $NOW;
elif [ "$1" = "toggle" ]
    then
        MUTED=$(pactl list sinks | grep Mute | cut -d " " -f 2)
        pactl set-sink-mute $SINK toggle;
        if [ $MUTED = "no" ]
        then
            volnoti-show -m;
        else
            volnoti-show $NOW;
        fi
fi


