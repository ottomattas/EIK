#!/bin/bash
#Otto Mättas
#See skript jagab etteantud grupile failiserveris uue kausta

#Vers. tabel
# v0.1 Poolik skript aine materjalidest lisatud Otto GIT reposse. Source: https://wiki.itcollege.ee/index.php/Bash_n%C3%A4ide
# v0.1.1 Parandatud vorming
# v0.1.2 SAMBA osa eemaldatud
# v0.2 Parandatud kasutajale väljastatavad suunised
# v0.3 Kaustale grupiõiguste andmine
# v0.3.1 Parandatud vorming
# v0.4 Parandatud kasutajale väljastatavad suunised
# v1.0 Valmistoode
# v1.1 Lisatud failiserveriga seotud toimingud

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
			KAUST=$1
			GRUPP=$2
		else
			echo "Kasuta skripti järgmiselt: "$(basename $0) [KAUST] [GRUPP]""
		exit 1
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

#Annab grupile kausta grupiõigused
sudo chgrp -R $GRUPP $KAUST

#Annab kaustale ainult grupil ligi pääseda
sudo chmod -R 770 $KAUST

#Iga kausta loodud fail on sama grupiõigusega kui kaust
chmod -R g+s $KAUST

#Samba failiserveri seadistusfaili uuendamine
cat <<EOT >> /etc/samba/smb.conf
[$KAUST.$GRUPP]
    path = $KAUST
    read only = no
    writeable = yes
    browseable = yes
    valid users = @$GRUPP
    create mask = 0640
    directory mask = 0750
EOT

#Samba failiserveri restart
sudo service smbd restart

#Tulemuse raport kasutajale
echo -e "Kausta \e[1;4m$KAUST\e[0m (grupi \e[1;4m$GRUPP\e[0m õigustega) leiad skriptiga failiserveri samast kaustast!"
