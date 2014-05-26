ans=0
aux=0
zenity --question --text=Musicar? --ok-label=Sim --cancel-label=Não --title=Pergunto-te...  --window-icon=update.png 

if [ $? -eq 0 ] ; then	
	ans=1
else	
	killall clementine
fi

if [ $ans -eq 1 ] ; then	
	## Clementine ##	
	hash clementine 2>/dev/null || { echo >&2 "Clementine não encontrado"; aux=1; }
	echo "O valor da variavel é $aux"
	if [ $aux -eq 0 ] ; then
		DISPLAY=:0
		clementine --quiet & clementine -p
	fi
	###			 ###
else	
	notify-send Musicator "Musicar não mais..."
fi



--------------------------------------------------------------------------------------------

#Outro pedaço
"Clementine") 
		ans=0
		aux=0
			if [ $ret -eq 0 ] ; then	
			ans=1
		else	
			killall clementine
		fi

		if [ $ans -eq 1 ] ; then	
		
			hash clementine 2>/dev/null || { echo >&2 "Clementine não encontrado"; aux=1; }
			echo "O valor da variavel é $aux"
			if [ $aux -eq 0 ] ; then
				DISPLAY=:0
				clementine --quiet & clementine -p
			fi
					 
		else	
			notify-send Musicator "Musicar não mais..."
		fi
	;;
	"Musique") 
		ans=0
		aux=0
			if [ $ret -eq 0 ] ; then	
			ans=1
		else	
			killall musique
		fi

		if [ $ans -eq 1 ] ; then	
		
			hash musique 2>/dev/null || { echo >&2 "Musique não encontrado"; aux=1; }
			echo "O valor da variavel é $aux"
			if [ $aux -eq 0 ] ; then
				DISPLAY=:0
				musique 
			fi
					 
		else	
			notify-send Musicator "Musicar não mais..."
		fi
	;;
	"Nightingale") 
		ans=0
		aux=0
			if [ $ret -eq 0 ] ; then	
			ans=1
		else	
			killall nightingale
		fi

		if [ $ans -eq 1 ] ; then	
		
			hash nightingale 2>/dev/null || { echo >&2 "Nightingale não encontrado"; aux=1; }
			echo "O valor da variavel é $aux"
			if [ $aux -eq 0 ] ; then
				DISPLAY=:0
				nightingale
			fi
					 
		else	
			notify-send Musicator "Musicar não mais..."
		fi
	;;
