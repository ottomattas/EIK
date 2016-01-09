#!/bin/bash
#Otto Mättas
#Skript, mis
#* Skript saab käsurealt kolm parameetrit. 1. Sisendfail 2. Väljundfail 3. otsitav
#* Skript kontrollib, et sisendfail on fail ja loetav. (vastasel juhul exit 1)
#* Skript kontrollib, kas väljundfaili saab kirjutamiseks avada. (vastasel juhul exit 2)
#* Skript kontrollib, kas parameetreid on täpselt kolm (vastasel juhul exit 3)
#* Skript loeb sisendfailist failide ja kataloogide nimekirja (näiteks kujul:
#
#/etc/passwd
#/etc/
#/var/log
#/sedapoleolemas
#
#)

#Vers. tabel
# v0.1 Skriptikäivitus kontrollid on pärit ainekursuse materjalidest. Source: https://wiki.itcollege.ee/index.php/Bash_n%C3%A4ide

export LC_ALL=C

#Kontrollib, kas skript on käivitatud juurkasutajana
        if [ $UID -ne 0 ]
                then
                        echo "Käivita skript $(basename $0) juurkasutaja õigustes!"
                exit 1
        fi

#Kontrollib, kas on ette antud õige arv muutujaid
        if [ $# -eq 3 ]
                then
                        SISENDFAIL=$1
                        VALJUNDFAIL=$2
			OTSITAV=$3
                else
                        echo "Kasuta skripti järgmiselt: "$(basename $0) [SISENDFAIL] [VÄLJUNDFAIL] [OTSITAV]""
                exit 1
        fi
