#!/bin/bash
#Otto Mättas
#See skript loob uue veebikodu

#Vers. tabel
# v0.1 Skripti põhja ülesseadmine
# v0.2 Skripti sisu kirjutamine Ubuntu peal töötamiseks
# v0.2.1 Veebisaidi aktiveerimine parandatud

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
	if [ $# -eq 1 ]
		then
			URL=$1
		else
			echo "Kasuta skripti järgmiselt: "$ sudo sh $(basename $0) [URL]""
		exit 1
	fi

#IP aadressi tuvastamine
	IP="$(ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://')"

#Nimelahendus /etc/hosts faili
	echo "$IP $URL" >> /etc/hosts
	echo "127.0.0.1 $URL" >> /etc/hosts

#Apache paigaldamine
	sudo apt-get update > /dev/null
#	sudo apt-get dist-upgrade > /dev/null  <Funktsionaalsus arendamata
	sudo apt-get install apache2

#Veebisaidi sisu loomine
	mkdir -p /var/www/$URL
	cp /var/www/html/index.html /var/www/$URL
	cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/"$URL".conf

#Veebisaidi aktiveerimine
	a2ensite $URL
	service apache2 reload
