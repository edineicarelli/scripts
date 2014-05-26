#!/bin/sh
# Script para musicar este sistema para um momento de tranquilidade
# Rafael Lima

zenity --question --text=Musicar? --ok-label=Ja --cancel-label=Nicht --title=Hallo!
ans=0
if [ $? -eq 0 ] ; then	
	clementine & clementine -p
else
	echo "Saindo..."
	exit
fi

