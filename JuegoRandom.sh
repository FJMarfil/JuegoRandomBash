#!/bin/bash
clear

#¡Script de juego mejorado!

#Variables utilizadas en el Script:
#	NOMBRE		->	Nombre de nuestro personaje
#	NENEMIGO	->	Nombre del enemigo
#	JUGAR		->	Mientras tenga un valor determinado, repetirá el juego en bucle
#	REPETIR		->	Condición para que el juego siga ejecutándose
#	VIDA		->	Vida de nuestro personaje
#	VENEMIGO	->	Vida del enemigo
#	DANO		->	Daño de nuestro personaje
#	BLOQ		->	Daño de nuestro personaje disminuido a la mitad por bloqueo del enemigo
#	DENEMIGO	->	Daño del enemigo
#	PCRITICO	->	Probabilidad de ataque crítico de nuestro personaje
#	PCENEMIGO	->	Probabilidad de ataque crítico del enemigo
#	ACCION		->	Almacena la acción que elijamos utilizar con nuestro personaje
#	AENEMIGO	->	Almacena la acción que vaya a utilizar el enemigo
#	VICTORIAS	->	Número de victorias acumuladas
#	DERROTAS	->	Número de derrotas acumuladas


#Leemos el nombre del personaje.
read -p "Escribe el nombre de tu personaje: " NOMBRE
clear

#Declaramos las variables donde se almacenarán los nombres de nuestros dos protagonistas.
NOMBRE="\e[0;35m$NOMBRE \"Er Puñalaítas\"\e[0m"
NENEMIGO="\e[0;31mPapu Máximo (Nivel 50 - BOSS)\e[0m"

#Variable donde almacenamos la condición para seguir jugando o terminar el juego.
JUGAR=1
 
#Mientras $JUGAR sea 1, nuestra aplicación seguirá ejecutándose.
while [ $JUGAR -eq 1 ]
do
	#Presentamos a nuestro personaje y a su adversario.
	echo -e "Eres $NOMBRE.\n"

	echo -e "¡Entras en una cueva y te encuentras con un $NENEMIGO!\n\n\n"

	#Aquí declaramos e inicializamos las variables de vida de nuestros personajes.
	VENEMIGO=100
	VIDA=100

	#Declaramos e inicializamos las variables referentes al daño, que usaremos más adelante.
	DANO=0
	DENEMIGO=0
	BLOQ=0

	#Bucle que se repetirá mientras los dos personajes estén con vida.
	while [ $VENEMIGO -gt 0 ] && [ $VIDA -gt 0 ]
	do
		#Aquí restamos la vida de los personajes según su último ataque recibido.
		VENEMIGO=$(($VENEMIGO-($DANO-$BLOQ)))
		VIDA=$(($VIDA-$DENEMIGO))

		#En el caso de que el enemigo haya sido derrotado.
		if [ $VENEMIGO -le 0 ]
		then
			echo -e "¡Victoria para "$NOMBRE"!"

			#Guardaremos un registro de victorias y derrotas en el archivo "FGsusMarfilasosGame.txt".
			if [ -a FGsusMarfilasosGame.txt ]
			then
			#En el caso de que el archivo exista, leeremos los datos de este y le añadiremos la nueva victoria.
				VICTORIAS=$((grep "Victorias" FGsusMarfilasosGame.txt) | (cut -d ";" -f 2))
				DERROTAS=$((grep "Derrotas" FGsusMarfilasosGame.txt) | (cut -d ";" -f 2))

				let VICTORIAS++

				echo -e "Victorias;"$VICTORIAS"\nDerrotas;"$DERROTAS"">FGsusMarfilasosGame.txt
				echo
				cat FGsusMarfilasosGame.txt
			#En el caso de que el archivo no exista, lo crearemos y comenzaremos el contador con una victoria.
			else
				echo -e "Victorias;1\nDerrotas;0">FGsusMarfilasosGame.txt
				echo
				cat FGsusMarfilasosGame.txt
			fi

			#Desde aquí podremos jugar nuevamente.
			echo -e "\n¿Desea jugar nuevamente?\n"

			select REPETIR in "Sí" "No"
			do
				case $REPETIR in
					"Sí")
						clear
						break
					;;
					"No")
						JUGAR=0
						break
					;;
					*)
						echo -e "\nLa opción elegida no existe, inténtalo nuevamente.\n"
					;;
				esac
			done
		#Si nuestro enemigo nos derrota.
		elif [ $VIDA -le 0 ]
		then
			echo -e "¡"$NOMBRE" ha sido derrotado por "$NENEMIGO"!"

			#Guardaremos un registro de victorias y derrotas en el archivo "FGsusMarfilasosGame.txt".
			if [ -a FGsusMarfilasosGame.txt ]
			then
			#En el caso de que el archivo exista, leeremos los datos de este y le añadiremos la nueva victoria.
				VICTORIAS=$((grep "Victorias" FGsusMarfilasosGame.txt) | (cut -d ";" -f 2))
				DERROTAS=$((grep "Derrotas" FGsusMarfilasosGame.txt) | (cut -d ";" -f 2))

				let DERROTAS++

				echo -e "Victorias;"$VICTORIAS"\nDerrotas;"$DERROTAS"">FGsusMarfilasosGame.txt
				echo
				cat FGsusMarfilasosGame.txt
			else
			#En el caso de que el archivo no exista, lo crearemos y comenzaremos el contador con una derrota.
				echo -e "Victorias;0\nDerrotas;1">FGsusMarfilasosGame.txt
				echo
				cat FGsusMarfilasosGame.txt
			fi

			#Desde aquí podremos jugar nuevamente.
			echo -e "\n¿Desea jugar nuevamente?\n"

			select REPETIR in "Sí" "No"
			do
				case $REPETIR in
					"Sí")
						clear
						break
					;;
					"No")
						JUGAR=0
						break
					;;
					*)
						echo -e "\nLa opción elegida no existe, inténtalo nuevamente.\n"
					;;
				esac
			done
		#Si ambos personajes siguen con vida, el juego continúa.
		else
			#Si la vida del enemigo se encuentra entre 80 y 100.
			if [ $VENEMIGO -ge 80 ]
			then
				echo -e "      $NENEMIGO\n"
				echo "        ▓▓▓▓▓▓▓     .|.   ▒▒▒▒▒▒"
				echo "      ▓▓▒▒▒▒▒▒▒▓▓        ▒▒░░░░░░▒▒"
				echo "    ▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓    ▒▒░░░░░░░░░▒▒▒"
				echo "   ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒░░░░░░░░░░░░░░▒"
				echo "  ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒"
				echo "  ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒▀▀▀▀▀███▄▄▒▒▒░░░▄▄▄██▀▀▀▀▀░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒▒▄▀████▀███▄▒░▄████▀████▄░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒█──▀█████▀─▌▒░▐──▀█████▀─█░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒▒▀▄▄▄▄▄▄▄▄▀▒▒░░▀▄▄▄▄▄▄▄▄▀░░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒"
				echo "  ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒"
				echo "   ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▀▀░░░░░░░░░░░░░░▒"
				echo "    ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒"
				echo "     ▓▓▒▒▒▒▒▒▒▒▒▒▄▄▄▄▄▄▄▄▄░░░░░░░░▒▒"
				echo "      ▓▓▒▒▒▒▒▒▒▄▀▀▀▀▀▀▀▀▀▀▀▄░░░░░▒▒"
				echo "       ▓▓▒▒▒▒▒▀▒▒▒▒▒▒░░░░░░░▀░░░▒▒"
				echo "        ▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒"
				echo "          ▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒"
				echo "           ▓▓▒▒▒▒▒▒▒▒░░░░░░░▒▒"
				echo "             ▓▓▒▒▒▒▒▒░░░░░▒▒"
				echo "               ▓▓▒▒▒▒░░░░▒▒"
				echo "                ▓▓▒▒▒░░░▒▒"
				echo "                  ▓▓▒░▒▒"
				echo "       k mira tú   ▓▒░▒   t mato la"
				echo "       payaso       ▓▒    la bida tt"
				echo -e "\n"
				echo -e "	 	 \e[0;34mHP = $VENEMIGO\e[0m\n"
				echo "               HP (yo) = $VIDA"
			#Si la vida del enemigo se encuentra entre 50 y 79.
			elif [ $VENEMIGO -ge 50 ]
			then
				echo -e "      $NENEMIGO\n"
				echo "        ▓▓▓▓▓▓▓     .|.   ▒▒▒▒▒▒"
				echo "      ▓▓▒▒▒▒▒▒▒▓▓        ▒▒░░░░░░▒▒"
				echo "    ▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓    ▒▒░░░░░░░░░▒▒▒"
				echo "   ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒░░░░░░░░░░░░░░▒"
				echo "    ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒"
				echo "  ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒"
				echo "  ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒"
				echo "  ▓▓▒▒▒▒▒▒▀▀▀▀▀███▄▄▒▒▒░░░▄▄▄██▀▀▀▀▀░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒▒▄▀████▀███▄▒░▄████▀████▄░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒█──▀█████▀─▌▒░▐──▀█████▀─█░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▀▄▄▄▄▄▄▄▄▀▒▒░░▀▄▄▄▄▄▄▄▄▀░░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒"
				echo "     ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒"
				echo "   ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▀▀░░░░░░░░░░░░░░▒"
				echo "      ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒"
				echo "     ▓▓▒▒▒▒▒▒▒▒▒▒▄▄▄▄▄▄▄▄▄░░░░░░░░▒▒"
				echo "      ▓▓▒▒▒▒▒▒▒▄▀▀▀▀▀▀▀▀▀▀▀▄░░░░░▒▒"
				echo "       ▓▓▒▒▒▒▒▀▒▒▒▒▒▒░░░░░░░▀░░░▒▒"
				echo "        ▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒"
				echo "             ▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒"
				echo "           ▓▓▒▒▒▒▒▒▒▒░░░░░░░▒▒"
				echo "            ▓▓▒▒▒▒▒▒░░░░░▒▒"
				echo "               ▓▓▒▒▒▒░░░░▒▒"
				echo "                ▓▓▒▒▒░░░▒▒"
				echo "                  ▓▓▒░▒▒"
				echo "       ven pacá    ▓▒░▒   k te vi a da"
				echo "       arbóndigo    ▓▒    dos guantá"
				echo -e "\n"
				echo -e "	 	 \e[0;32mHP = $VENEMIGO\e[0m\n"
				echo "               HP (yo) = $VIDA"
			#Si la vida del enemigo se encuentra entre 25 y 49.
			elif [ $VENEMIGO -ge 25 ]
			then
				echo -e "      $NENEMIGO\n"
				echo "        ▓▓▓▓▓▓▓     .|.   ▒▒▒▒▒▒"
				echo "        ▓▓▒▒▒▒▒▒▒▓▓   ▒▒░░░░░░▒▒"
				echo "    ▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓     ▒▒░░░░░░░░░▒▒▒"
				echo "   ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓ ▓▒▒░░░░░░░░░░░░░░▒"
				echo "    ▓▓▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒"
				echo "  ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░ ░░░░░░░░░▒"
				echo "  ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒"
				echo "  ▓▓▒▒▒▒▒▒▀▀ ▀▀▀███▄▄▒▒▒░░░▄▄▄ ██▀▀▀▀▀░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒▒▄▀████▀███▄▒░▄████▀███▄░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒█──▀█████▀─▌▒░▐──▀█████▀─█░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▀▄▄▄▄▄▄▄▄▀▒▒░░▀▄▄▄▄▄▄▄▄▀░░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒"
				echo "     ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░ ░░░░░░░░░░░░▒"
				echo "   ▓▓▒▒▒▒▒ ▒▒▒▒▒▒▒▒▀▀▀░░░░░░░░░░░░░░▒"
				echo "      ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒"
				echo "     ▓▓▒▒▒▒▒▒▒▒▒▒▄▄▄▄▄▄▄▄▄░░░░░░░░▒▒"
				echo "       ▓▓▒▒▒▒▒▒▒▄▀▀▀▀▀▀▀▀▀▀▀▄░░░░░▒▒"
				echo "       ▓▓▒▒▒▒▒▀▒▒▒▒▒▒░░░░░░░▀░░░▒▒"
				echo "        ▓▓▒▒▒▒▒▒▒▒▒▒▒░░ ░░░░░░░░▒▒"
				echo "             ▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒"
				echo "           ▓▓▒▒▒▒▒▒▒▒░░░░░░░▒▒"
				echo "            ▓▓▒▒▒▒▒▒░░░░▒▒"
				echo "               ▓▓▒▒▒▒░░░░▒▒"
				echo "                ▓▓▒▒▒░░░▒▒"
				echo "                   ▓▓▒░▒▒"
				echo "       a que llamo ▓▒░▒   k er kike está"
				echo "       a mi primo   ▓▒    to loko t aviso"
				echo -e "\n"
				echo -e "	 	 \e[0;33mHP = $VENEMIGO\e[0m\n"
				echo "               HP (yo) = $VIDA"
			#Si la vida del enemigo se encuentra por debajo de 25.
			else
				echo -e "      $NENEMIGO\n"
				echo "        ▓▓▓▓▓▓▓     .|.   ▒▒▒▒▒▒"
				echo "        ▓▓▒▒▒▒▒▒▒▓▓   ▒▒░░░░░░▒▒"
				echo "    ▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓     ▒▒░░░░░░░░░▒▒▒"
				echo "   ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓ ▓▒▒░░░░░░░░░░░░░░▒"
				echo "    ▓▓▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒"
				echo "      ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░ ░░░░░░░░░▒"
				echo "   ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒"
				echo "  ▓▓▒▒▒▒▒▒▀▀ ▀▀▀███▄▄▒▒▒░░░▄▄▄ ██▀▀▀▀▀░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒▒▄▀████▀███▄▒░▄████▀███▄░░░░░░░▒"
				echo "▓▓▒▒▒▒▒▒█──▀█████▀─▌▒░▐──▀█████▀─█░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▀▄▄▄▄▄▄▄▄▀▒▒░░▀▄▄▄▄▄▄▄▄▀░░░░░░░▒"
				echo " ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒█▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒"
				echo "     ▓▓▒▒▒▒▒▒█▒▒▒▒▒▒▒▒▒░░░░░██░░░░░░░░░░░░▒"
				echo "   ▓▓▒▒▒▒▒ ▒▒▒▒▒█▒▒▀▀▀░░░░░░░░░█░░░░░▒"
				echo "      ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░█░░░░░▒▒"
				echo "     ▓▓▒▒▒▒▒▒▒▒▒▒▄ ▄▄▄▄▄  ▄░░░░░░░░▒▒"
				echo "       ▓▓▒▒▒▒▒▒▒▄▀▀▀▀▀ ▀▀▀▀▀▀▄░░░█░░▒▒"
				echo "       ▓▓▒▒▒▒▒▀▒▒▒▒▒▒░░░░░░░▀░░░▒▒"
				echo "        ▓▓▒▒▒▒▒▒▒▒▒▒▒░░ ░░░░░░░░▒▒"
				echo "             ▓▓ ▒▒▒▒▒▒▒░░░░░░░░▒▒"
				echo "           ▓▓▒▒▒ ▒▒▒▒▒░░░░░░░▒▒"
				echo "            ▓▓▒▒▒▒▒▒░░░░▒▒"
				echo "               ▓▓▒▒▒▒░░░░▒▒"
				echo "                ▓▓▒▒▒░░░▒▒"
				echo "                   ▓▓▒░▒▒"
				echo "       illo illo   ▓▒░▒   estaba de broma"
				echo "       yasta pisha   ▓▒   no sea malahe"
				echo -e "\n"
				echo -e "	 	 \e[0;31mHP = $VENEMIGO\e[0m\n"
				echo "               HP (yo) = $VIDA"
			fi
			echo -e "\n\n"

			#Menú donde se nos presentan las distintas acciones que podemos realizar.
			echo -e "¿Qué deseas hacer?\n"

			select ACCION in "Coger piedra del suelo y lanzarla." "Insultar a su progenitora." "Ataque con arma blanca."
			do
				#En el caso de los números aleatorios de rango [0 a X], utilizaremos: VAR=$(( $RANDOM % $NUMEROMAYOR )).
				#En el caso de los números aleatorios de rango [1 a X], utilizaremos: VAR=$(( $RANDOM % $NUMEROMAYOR + 1 )).
				#En el caso de los números aleatorios de rango [X a X], utilizaremos: VAR=$(( $RANDOM % ($NUMEROMAYOR - $NUMEROMENOR + 1) + $NUMEROMENOR )).

				#Variable que utilizaremos para calcular la probabilidad de que un ataque sea crítico, en cuyo caso, valdrá el doble.
				PCRITICO=$(( $RANDOM % 100 + 1 ))

				#Aquí programamos lo que ocurre según la opción elegida.
				#Aplicamos un daño aleatorio, según el tipo de ataque, con una probabilidad de que sea un ataque crítico.
				#Los ataques más poderosos tienen menos probabilidades de ser críticos.
				case $ACCION in
					"Coger piedra del suelo y lanzarla.")
						DANO=$(( $RANDOM % (18 - 5 + 1) + 5 ))
						if [ $PCRITICO -le 12 ]
						then
							let DANO=($DANO*2)
							echo -e "\n¡La piedra fue a parar a una ceja! Ataque crítico: -"$DANO"HP"
						else
							echo -e "\n¡Buen lanzamiento! -"$DANO"HP"
						fi
						break
					;;
					"Insultar a su progenitora.")
						DANO=$(( $RANDOM % (35 - 1 + 1) + 1 ))
						if [ $PCRITICO -le 15 ]
						then
							let DANO=($DANO*2)
							echo -e "\n¡Tu insulto fue muy original, lo has dejado hundido! Ataque crítico: -"$DANO"HP"
						else
							echo -e "\n¡Eso no se lo esperaba! -"$DANO"HP"
						fi
						break
					;;
					"Ataque con arma blanca.")
						DANO=$(( $RANDOM % (33 - 20 + 1) + 20 ))
						if [ $PCRITICO -le 10 ]
						then
							let DANO=$DANO*2
							echo -e "\n¡Hiciste el Fatality \"Puñalaíta en el costao\"! Ataque crítico: -"$DANO"HP"
						else
							echo -e "\n¡Buen tajo! -"$DANO"HP"
						fi
						break
					;;
					*)
						echo -e "\nLa opción elegida no existe, inténtalo nuevamente.\n"
					;;
				esac
			done

			#El enemigo elegirá una acción aleatoria.
			AENEMIGO=$(( $RANDOM % 4 + 1 ))
			#Probabilidad de ataque crítico del enemigo.
			PCENEMIGO=$(( $RANDOM % 100 + 1 ))
			#Variable que almacenará el daño que recibirá el enemigo en caso de que lo bloquee.
			BLOQ=0

			#El enemigo atacará si sigue con vida después de un ataque (también en el caso de que haya bloqueado un ataque que lo hubiera matado sin bloqueo).
			if [ $(( $VENEMIGO - $DANO )) -gt 0 ] || [ $(( $VENEMIGO - $DANO )) -le 0 -a $(( $VENEMIGO - $DANO / 2 )) -gt 0 -a $AENEMIGO -eq 4 ]
			then
				case $AENEMIGO in
					#Ataque débil del enemigo.
					1)
						DENEMIGO=$(( $RANDOM % (20 - 6 + 1) + 6 ))
						if [ $PCENEMIGO -le 15 ]
						then
							let DENEMIGO=($DENEMIGO*2)
							echo -e "\n¡El enemigo te escupió en un ojo! Ataque crítico: -"$DENEMIGO"HP"
						else
							echo -e "\n¡El enemigo te dio un tortazo en la oreja! -"$DENEMIGO"HP"
						fi
					;;
					#Ataque extraño.
					2)
						DENEMIGO=$(( $RANDOM % (25 - 1 + 1) + 1 ))
						if [ $PCENEMIGO -le 16 ]
						then
							let DENEMIGO=($DENEMIGO*2)
							echo -e "\n¡El enemigo te empezó a moñear! Ataque crítico: -"$DENEMIGO"HP"
						else
							echo -e "\n¡El enemigo te intimidó poniendo caras extrañas! -"$DENEMIGO"HP"
						fi
					;;
					#Ataque fuerte del enemigo.
					3)
						DENEMIGO=$(( $RANDOM % (30 - 22 + 1) + 22 ))
						if [ $PCENEMIGO -le 6 ]
						then
							let DENEMIGO=($DENEMIGO*2)
							echo -e "\n¡El enemigo utilizó su Fatality \"Mataleones inverso\"! Ataque crítico: -"$DENEMIGO"HP"
						else
							echo -e "\n¡El enemigo utilizó \"Peste boca\"! -"$DENEMIGO"HP"
						fi
					;;
					#Bloquear.
					4)
						DENEMIGO=0
						let BLOQ=$DANO/2
						echo -e "\n¡El enemigo logró bloquear tu último ataque, reduciéndolo a: -"$BLOQ"HP!"
					;;
				esac
			fi

			echo

			#Una pausa para que podamos continuar pulsando una tecla.
			read -p "Presiona Enter para continuar..."
			clear
		fi
	done
done

clear

#RAFA, DAME MÍNIMO 3 POSITIVOS!!!

#By FGsusMarfilasso