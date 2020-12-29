#!/bin/bash
#Otto Mättas
#See skript vaatab võrguliiklust

#Vers. tabel
# v0.1 Skripti põhja ülesseadmine
# v0.2 TCPdumpi käivitamine, esmane

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
			INTERFACE=$1
			PORT=$2
		else
			echo "Kasuta skripti järgmiselt: "$(basename $0) [interface] [port]""
		exit 1
	fi

#Kontrollib, kas tcpdump on paigaldatud (vajadusel paigaldab)
	type tcpdump > /dev/null 2>&1 
 
	if [ $? -ne 0 ]
		then
			echo "TCPDumpi esmakordne paigaldamine..."
			yum update > /dev/null 2>&1
#			yum dist-upgrade > /dev/null 2>&1 <Funktsionaalsus arendamata
			yum install tcpdump -y
		exit 1
	fi

#TCPDumpi argument analüüsimise jaoks
	TCPDUMPARG="tcp port $PORT and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)"

#TCPDumpi käivitamine
tcpdump -s 0 -A -i $INTERFACE $TCPDUMPARG
