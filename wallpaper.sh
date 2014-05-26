#!/bin/bash
#Rafael da Silva Lima - rafael.liverpool@gmail.com

IMG_PATH='/home/rafaellima/Imagens'
IMG_FULLPATH='/home/rafaellima/Imagens/Telas/'


ls IMG_FULLPATH/ > /tmp/listagem

cd $IMG_FULLPATH 
array=( ${array[@]} `cat /tmp/listagem` )
cd $IMG_PATH

cp $IMG_FULLPATH/* .


for palavra in ${array[@]}; do
	#echo $palavra
	mv $palavra .$palavra	

done
