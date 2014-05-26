#!/bin/bash
#Rafael da Silva Lima - rafael.liverpool@gmail.com
#Script para busca e separação de variaveis de arquivos

array=( ${array[@]} `cat arquivo.txt` )
x=0
for palavra in ${array[@]}; do
	echo $palavra
	
	if [ $x == 0 ]; then
		status=$palavra;
	fi
	if [ $x == 1 ]; then
		player=$palavra;
	fi
	
	x=$[$x + 1]
	#echo "Agora é: [$x]"
done
status=0

echo "$status""$palavra" > arquivo.txt
echo "O script está com status: $status e o player é o $player"
