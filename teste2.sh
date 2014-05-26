#!/bin/sh
aux=0
#command -v clementine >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
#type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
hash foo 2>/dev/null || { echo >&2 "I require foo but it's not installed.  Aborting."; aux=1; }

echo $aux
