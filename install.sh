#!/bin/bash

# Colores
green="\033[0;32m"
colorend="\033[0m"
red="\033[0;91m"
blue="\033[0;34m"
yellow="\033[0;33m"
cursivo="\033[3m"
orange="\033[1;30m"
gray="\033[0;37m"
purple="\033[0;35m"
cyan="\033[0;36m"
white="\033[0;37m"
bold="\033[1m"
underline="\033[4m"

shell=$(echo $SHELL | awk -F'/' '{print $3}');

chmod 700 steroidette.sh && echo -e "Dando ${red}${bold}700${colorend} a steroidette.sh"
mkdir $HOME/.steroidette && echo -e "Creando directorio ${green}${bold}.steroidette${colorend}"
cp steroidette.sh $HOME/.steroidette/steroidette.sh && echo -e "Copiando ${red}${bold}steroidette.sh${colorend} a ${green}${bold}.steroidette${colorend}"

if [ "$shell" = "bash" ]
then
	echo -e "Creando alias en ${purple}${bold}.bashrc${colorend} ..."
	echo "alias steroidette='bash $HOME/.steroidette/steroidette.sh'" >> $HOME/.bashrc
elif [ "$shell" = "zsh" ]
then
	echo -e "Creando alias en ${purple}${bold}.zshrc${colorend} ..."
	echo "alias steroidette='bash $HOME/.steroidette/steroidette.sh'" >> $HOME/.zshrc
else
	echo -e "No se pudo crear el alias en ${red}${bold}$shell${colorend}"
	exit
fi

echo -e "Disfruta de ${green}${bold}Steroidette${colorend} con el comando ${purple}${bold}steroidette${colorend}!"

