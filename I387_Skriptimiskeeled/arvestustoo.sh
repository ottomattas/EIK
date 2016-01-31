#!/bin/bash
#Otto Mättas
#Skript, mis leiab sisendafailist otsitava ning annab tulemuse väljundfailis.

#Vers. tabel
# v0.1 Skriptikäivituskontrollid on inspireeritud ainekursuse materjalidest. Source: https://wiki.itcollege.ee/index.php/Bash_n%C3%A4ide
#

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
                exit 2
        fi

#Väljundfaili esimesele reale kirjutatakse 3. parameetrina antud string. 
#        echo $OTSITAV > $VALJUNDFAIL

#Skript loeb sisendfailist failide ja kataloogide nimekirja ning otsib nimekirja failide ja kataloogide seest (rekursiivselt) OTSITAVAT STRINGI.
#	while read F
#		do
#			if grep -qrnw "$OTSITAV" $F
#				then
#					echo $F",OLEMAS" >> $VALJUNDFAIL
#				else
#					echo $F",POLE OLEMAS" >> $VALJUNDFAIL
#			fi
#		done <$SISENDFAIL

#Tulemuse raport kasutajale
#echo -e "Faili-/katalooginimekiri: \e[1;4m$SISENDFAIL\e[0m || OTSITAV: \e[1;4m$OTSITAV\e[0m || TULEMUSED : \e[1;4m$VALJUNDFAIL\e[0m"
