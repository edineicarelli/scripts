#!/bin/bash

DADOS=$(yad --form --field='Hora':TEXT '')
NOME=$(echo "$DADOS" | cut -d'|' -f1)

sudo rtcwake --mode mem --seconds 5
mplayer musicapath
