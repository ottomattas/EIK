#!/bin/bash
#Otto Mättas
#Skript, mis leiab etteantud kataloogist kõik failid, mida kasutaja saab kirjutamiseks avada ning esitab tulemuse väljundfailis.

#Vers. tabel
# v0.1 Skriptikäivituskontrollid on inspireeritud ainekursuse materjalidest. Source: https://wiki.itcollege.ee/index.php/Bash_n%C3%A4ide
# v0.2 Lisatud failiotsing kasutajale kirjutamiseks kättesaadavate failide nimekirja printimiseks väljundfaili ning väljundfaili avamise kontrolli täiustus.

export LC_ALL=C

#Kontrollib, kas skript on käivitatud juurkasutajana
        if [ $UID -ne 0 ]
                then
                        echo "Käivita skript $(basename $0) juurkasutaja õigustes!"
                exit
        fi

#Skript peab saama käsurealt kolm parameetrit: 1. Sisendfail 2.Väljundfail 3.Otsitav
        if [ $# -eq 3 ]
                then
                        KATALOOG=$1
                        KASUTAJANIMI=$2
			VALJUNDFAIL=$3
                else
                        echo "Kasuta skripti järgmiselt: "$(basename $0) [KATALOOG] [KASUTAJANIMI] [VÄLJUNDFAIL]""
                exit 3
        fi

#Skript kontrollib, et kataloog oleks olemas. (vastasel juhul exit 1)
	if [ ! -d $KATALOOG ]
		then
			echo "Kataloogi $KATALOOG ei leitud!"
		exit 1
	fi

#Skript kontrollib, et kasutaja oleks olemas. (vastasel juhul exit 1)
	id -u "$KASUTAJANIMI" > /dev/null 2>&1
	if [ $? -ne 0 ]
		then
			echo "Kasutajat $KASUTAJANIMI ei leitud!"
		exit 1 
	fi

#Skript kontrollib, kas väljundfaili saab kirjutamiseks avada. (vastasel juhul exit 2)
        if [ ! -f $VALJUNDFAIL ]
                then
                        echo "Väljunfaili ei leitud,loome selle!"
			touch $VALJUNDFAIL
				if [ ! -f $VALJUNDFAIL ]
					then
						echo "Väljundfaili ei saa avada!"
					exit 2
				fi
        fi

#Skript leiab kõik failid parameetriks küsitud kataloogist, millele parameetriks küsitud kasutajanimega kasutajal on kirjutamisõigus.
	find $KATALOOG \( -type f \) \
		\( \
			\( -user $KASUTAJANIMI -perm -u=w \) -or \
			\( -group $KASUTAJANIMI -perm -g=w \) -or \
			-perm -o=w \
		\) \
	-print > $VALJUNDFAIL

##############################################
##############################################
# Järgnev langeb arvestustöö skoobist välja, #
# kuid on äärmiselt kasulik võimalus sellise #
# skripti puhul. Vajadusel saab arendada #####
# optsioonivõimaluse lisaparameetri näol. ####
##############################################
##############################################
#Skript leiab kõik failid ja kaustad parameetriks küsitud kataloogist, millele parameetriks küsitud kasutajanimega kasutajal on kirjutamiseõigus.
#	find $KATALOOG \( -type f -or -type d \) \
#		\( \
#			\( -user $KASUTAJANIMI -perm -u=w \) -or \
#			\( -group $KASUTAJANIMI -perm -g=w \) -or \
#			-perm -o=w \
#		\) \
#	-print
##############################################
##############################################

#Tulemuse raport kasutajale
echo -e "KATALOOG: \e[1;4m$KATALOOG\e[0m || KASUTAJANIMI: \e[1;4m$KASUTAJANIMI\e[0m || TULEMUSED : \e[1;4m$VALJUNDFAIL\e[0m"
