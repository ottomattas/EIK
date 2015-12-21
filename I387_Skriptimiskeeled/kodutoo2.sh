#!/bin/bash
#Otto Mättas
#See skript loob uue veebikodu

#Vers. tabel
# v0.1 Skripti põhja ülesseadmine

#NB See skript on pooleli ja sisaldab mitmeid ebatäpsuseid
#mõeldud alustamiseks ja parandamiseks

export LC_ALL=C

#Kontrollib, kas skript on käivitatud juurkasutajana
	if [ $UID -ne 0 ]
		then
			echo "Käivita skript $(basename $0) juurkasutaja õigustes!"
		exit 1
	fi

#Kontrollib, kas on ette antud õige arv muutujaid
	if [ $# -eq 2 ]
		then
			URL=$1
		else
			echo "Kasuta skripti järgmiselt: "# bash $(basename $0) [URL]""
		exit 1
	fi
