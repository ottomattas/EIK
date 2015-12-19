#!/bin/bash
#Otto Mättas
#See skript jagab etteantud grupile uue kausta

#Vers. tabel
# v0.1 Poolik skript aine materjalidest lisatud Otto GIT reposse. Source: https://wiki.itcollege.ee/index.php/Bash_n%C3%A4ide
# v0.1.1 Parandatud vorming

#NB See skript on pooleli ja sisaldab mitmeid ebatäpsuseid
#mõeldud alustamiseks ja parandamiseks

export LC_ALL=C

#Kontrollib, kas skript on käivitatud juurkasutajana
	if [ $UID -ne 0 ]
		then
			echo "käivita skript $(basename $0) juurkasutaja õigustes"
		exit 1
	fi

#Kontrollib, kas on ette antud õige arv muutujaid

	if [ $# -eq 2 ]
		then
			KAUST=$1
			GRUPP=$2
		else
		if [ $# -eq 3 ]
			then
				KAUST=$1
				GRUPP=$2
				SHARE=$3
			else
				echo "kasuta sktipti $(basename $0) KAUST GRUPP [SHARE]"
			exit 1
		fi
	fi

#Kontrollib, kas samba on paigaldatud (vajadusel paigaldab)
type smbd > /dev/null 2>&1

	if [ $? -ne 0 ]
		then
		apt-get update > /dev/null 2>&1 && apt-get install samba -y || exit 1 
	fi

#Kontrollib, kas kaust on olemas (vajadusel loob)

test -d $KAUST || mkdir -p $KAUST

#Kontrollib, kas grupp on olemas (vajadusel loob)

getent group $GRUPP > /dev/null || addgroup $GRUPP  > /dev/null
