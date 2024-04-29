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

tput civis # Oculta el marcador
# Solicitar al usuario el límite de errores
echo -en "${bold}Ingrese el límite de errores: ${colorend}"
read error_amount

# Función para manejar la entrada del usuario
handle_input() {
    if [ "$input" = "q" ] || [ "$input" = "Q" ]
    then
        rm $HOME/.steroidette/.prev_out.txt && exit
    fi
}
# Guardar la salida actual en un archivo temporal
echo "" > $HOME/.steroidette/.prev_out.txt

while true; do
    # Almacena la salida en una variable
    output=$(bash -c 'clear && norminette 2>&1' | grep -v OK)
    output_filtered=$(echo "$output" | awk '{gsub(/^Error/, "\033[0;91mError\033[0;39m"); gsub(/^Notice/, "\033[0;94mNotice\033[0;39m"); if (!/^Error/) {print "\033[0;92m" $0 "\033[0m"}}' | head -n $(($error_amount + 1)))
    error_counter=$(echo "$output" | grep -e "^Error" | wc -l)
    notice_counter=$(echo "$output" | grep -e "^Notice" | wc -l)

    # Comparar el archivo temporal con la salida actual
    if ! diff -q $HOME/.steroidette/.prev_out.txt <(echo "$output_filtered") >/dev/null; then
        # Si hay diferencias, actualizar la información en pantalla
        clear
        echo -e "$output_filtered"
        # Guardar la salida actual como la salida anterior
        echo "$output_filtered" > $HOME/.steroidette/.prev_out.txt
        if [ "$error_counter" -gt 0 ]
        then
            echo -e "\n${red}${bold}$error_counter${colorend}${white} errores encontrados${colorend}"
            if [ "$notice_counter" -gt 0 ]
            then
                echo -e "\r${purple}${bold}$notice_counter${colorend}${white} Notices encontrados${colorend}"
            fi
            echo -e "${bold}\nPresiona ${red}q${colorend}${bold} para salir${colorend}"
        else
            echo -e "${green}No se han encontrado errores${colorend}"
            echo -e "${bold}\nPresiona ${red}q${colorend}${bold} para salir${colorend}"
        fi
    fi


    # Lee la entrada del usuario con un tiempo de espera de 1 segundo
    read -rsn1 -t 1 input
    handle_input

done
# Activar la visibilidad del cursor
tput cnorm
