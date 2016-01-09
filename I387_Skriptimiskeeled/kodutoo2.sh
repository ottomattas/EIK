#!/bin/bash
#Otto Mättas
#See skript loob uue veebikodu

#Vers. tabel
# v0.1 Skripti põhja ülesseadmine
# v0.2 Skripti sisu kirjutamine Ubuntu peal töötamiseks
# v0.2.1 Veebisaidi aktiveerimine parandatud
# v0.2.2 Veebisaidi sisu loomine parandatud
# v1.0 Valmistoode
# v1.0.1 Näpuveaparandus

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
			echo "Kasuta skripti järgmiselt: "$(basename $0) [URL]""
		exit 1
	fi

#IP aadressi tuvastamine
	IP="$(ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://')"

#Nimelahendus /etc/hosts faili
	if grep --quiet $URL /etc/hosts
		then
			echo -e "\e[1;4m$URL\e[0m on /etc/hosts failis juba varem defineeritud. Kindel, et samanimeline veebikodu juba loodud pole?" 
		else
			echo "$IP $URL" >> /etc/hosts
			echo "127.0.0.1 $URL" >> /etc/hosts

#Apache paigaldamine
			sudo apt-get update > /dev/null
#			sudo apt-get dist-upgrade > /dev/null  <Funktsionaalsus arendamata
			sudo apt-get install apache2

#Veebisaidi sisu loomine
			if [ -d /var/www/$URL ]
				then
					echo -e "Kaust /var/www/\e[1;4m$URL\e[0m on juba olemas. Kindel, et samanimeline veebikodu juba loodud pole?"
				else
					mkdir -p /var/www/$URL
					cp /var/www/html/index.html /var/www/$URL
					if [ -f /etc/apache2/sites-available/"$URL".conf ]
						then
							echo -e "Fail /etc/apache2/sites-available/\e[1;4m"$URL"\e[0m.conf on juba olemas. Kindel, et samanimeline veebikodu juba loodud pole?"
						else					
							cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/"$URL".conf
							sed -i "s:/var/www/html:/var/www/$URL:" /etc/apache2/sites-available/"$URL".conf

#Veebisaidi aktiveerimine
							a2ensite $URL
							service apache2 reload

#Tulemuse raport kasutajale
							echo -e "Veebikodu \e[1;4m$URL\e[0m loomine õnnestus!"
 
						exit 1
					fi
				exit 1
			fi
		exit 1
	fi
