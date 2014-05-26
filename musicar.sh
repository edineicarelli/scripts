#!/bin/sh
# Script para musicar este sistema para um momento de tranquilidade
# Rafael Lima
#Proximo passo é verificar se os programas existem, usando um arquivo de instalação para passar os programas existentes para este script
#maneira de verificação é if ["$(which clementine)" = ""] 

DPATH='/home/rlima/scripts/'
cd $DPATH

if [ -s 'arquivo.txt' ]; then
	
	
	array = (${array[@]} `cat arquivo.txt`);
fi
	##Leitura do arquivo de configuração do app

		x=0

		for id in ${array[@]}; do
			#echo $id
			
			if [ $x == 0 ]; then
				status=$id;
			fi
			if [ $x == 1 ]; then
				app=$id;
			fi
			
			x=$[$x + 1]
			#echo "Agora é: [$x]" Debug do leitor 
			
		done
		##
	#echo "0 nada" > arquivo.txt	
	echo "Leitura de dados completa...."
	echo "Agora o player $app esta tocando. \o/"

	##Status 0 para que o programa seja executado com apenas uma instancia
	if [ $status == 0 ]; then
		status=1
		
		echo "$status" "$app" > arquivo.txt
		
		##YAD gerando uma form com gtk , fork do Zenity
		DATA=$(yad --width 300 --on-top --center --entry --title "Apolo" \
			  --image=stock_media-play           \
			  --button="_Qual ouvir:2"                     \
			  --button="gtk-media-play:0" --button="gtk-media-stop:1"    \
			  --text "Escolha um player:"                       \
			  --entry-text                                  \
			  "Clementine" "Musique" "Nightingale")
		ret=$?
		

		if [ $ret -eq 1 ]; then
			killall $app
			app="nada"
			status=0
			echo "$status" "$app" > arquivo.txt
			#exit 0		#Condição de saida
		fi

		if [ $ret -eq 2 ]; then		#Utilizando api do grooveshark 
			status=0
			
			if yad --form --title='Pergunto-lhe..' --columns=3 --center \
			--text='Deseja parar outros tocadores?' --button='Não':1 --button='Sim':0
				then
					killall $app
					status=0
					app="nada"
				fi	
				
				if [ "$app" != "java" ]; then	
					app="java"				
					echo "$status" "$app" > arquivo.txt					
					java -jar "$HOME"/scripts/Extra/GrooveDown.jar 
				fi
				echo "$status" "$app" > arquivo.txt	
		fi

		if [ $ret -eq 0 ]; then
			if [ "$app" != "java"]; then
			killall $app
			fi
			case $DATA in
				
				Clementine*) cmd="clementine & clementine -p" app="clementine";;
				Musique*) cmd="musique" app="musique";;
				Nightingale*) cmd="/usr/share/nightingale/nightingale-bin -pause" app="nightingale-bin";; #Só possivel com instalação da extensão do Nightingale Command Line
				#Nada*) 	;;    	

			esac  
			#Saindo do app, permitindo novas instancias com status = 0
			status=0
			echo "$status" "$app" > arquivo.txt
			#Executa ação final
			eval exec $cmd
		fi
		
	fi
else
	status=0
	app="nada"
	echo "$status" "$app" > arquivo.txt
	echo "Estava vazio, mas agora não mais"
	#executa o mesmo script novamente
fi

