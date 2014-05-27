#!/bin/bash

DADOS=$(yad --title "Alarme GNU Waker" --form --field='Dormir por (horas):':TEXT '' \
--field='Dormir depois (minutos):':TEXT '')
ACORDE=$(echo "$DADOS" | cut -d'|' -f1)
DEPOIS=$(echo "$DADOS" | cut -d'|' -f2)

tempoa=$((ACORDE * 3600))
tempob=$((DEPOIS * 60))
sleep $tempob

sudo rtcwake --mode mem --seconds $tempoa
amixer -c 0 set Master playback 100% unmute
mplayer alarme.mp3
echo "Bom dia Rafael"
