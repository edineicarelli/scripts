#!/bin/bash
#Adicionando usuário linux
 
addUsuario (){
	[ `whoami` = root ] || exec su -c $0 root
	

	if [ $(id -u) -eq 0 ]; then
		
		
		egrep "^$1" /etc/passwd >/dev/null
		if [ $? -eq 0 ]; then
			echo "$1 existe!"
			exit 1
		else
			# $2=$(perl -e 'print crypt($ARGV[0], "password")' $2) -- Não criar usuário com senha, devido restrições de segurança
			useradd $1
			[ $? -eq 0 ] && echo "O usuário foi adicionado ao sistema!" || echo "Falhou em adicionar um usuário!"
		fi
	else
		echo "Apenas um administrador é permitido de modificar dados de usuário, assim como a criação, edição e remoção dos mesmos"
		echo "Execute este script com sudo"
		exit 2
	fi
}

echo "Ola"
addUsuario "josemar" 
