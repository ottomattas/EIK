#!/bin/python
# -*- coding: utf-8 -*-
#Otto Mättas
#Skript, mis leiab sisendfailist inimeste nimed, ning annab tulemuse, milleks on nimest tuletatud EIKga seotud spetsiifiline info, väljundfailis.

#Vers. tabel
# v0.1 Ülesande defineerimine
# v0.1.1 Kondikava ülespanek
# v0.1.2 Sisendfailist saame vähendatud listi
# v0.1.3 Koodi vormingu seadmine
# v0.2 Ees- ja perekonnanime leidmine lisatud
# v1.0 Valmistoode
# v1.0.1 Formaati parandatud

import sys
import random
import string
import csv

#print "################################################################################"
#print "###PROGRAMM EI TÖÖTA KAUGELTKI VEEL NII NAGU ÜLESANDE LÄHTETEKST SEDA SOOVIB!###"
#print "################################################################################"


#Programm kontrollib argumentide arvu
if len(sys.argv) != 3:
	print "Argumentide arv on vale!"
	print "Kasuta programmi järgmiselt:", sys.argv[0], "[SISENDFAIL] [VÄLJUNDFAIL]"
	sys.exit(1)

#Ava SISENDFAIL listina ilma tühjade ridadeta (lisaks kontroll selle faili avamise võimalikkusele)
try:
	with open(sys.argv[1], 'r') as SISENDFAIL:
		data = filter(None, (line.rstrip() for line in SISENDFAIL))
		#Eraldame listist nimed
		data = data[1:]
		for elem in data:
			elem = elem[2:]
			elem = elem.split (' ')
			nimed = elem[:2]
			#Leiame eesnime
			eesnimi = nimed[0]
			#Leiame perekonnanime
			perekonnanimi = nimed[1]
			#Leiame täisnime
			taisnimi = eesnimi + " " + perekonnanimi
			#Leiame kasutajanime (eesnime esitäht + perekonnanimi, max 8 tähemärki)
			kasutajatunnus = eesnimi[:1].lower()+ perekonnanimi[:7].lower()
			#Leiame e-maili aadressi 
			email = eesnimi.lower() + "." + perekonnanimi.lower() + "@itcollege.ee"
			#Leiame 20st suvalisest tähemärgist koosneva tokeni
			token = "".join(random.SystemRandom().choice(string.ascii_letters + string.digits) for _ in range(20))
			##########################################################################
			##########################################################################
			# Vali endale kahest meelepärasem meetod CSV failis väärtuste kuvamiseks:#
			##########################################################################
			# 1) CSV faili väljastatav tulemus // täisnime variant (ühes väärtuses on mõlemad, nii ees- kui ka perekonnanimi)
			tulemus = kasutajatunnus, taisnimi, email, token
			##########################################################################
			# 2) CSV faili väljastatav tulemus // eraldi nimede variant (ühes väärtuses on eesnimi, teises perekonnanimi)
			#tulemus = kasutajatunnus, eesnimi, perekonnanimi, email, token
			##########################################################################
			##########################################################################
			try:
				output_file = open(sys.argv[2], 'a')
				valjund = csv.writer(output_file, quoting=csv.QUOTE_ALL)
				valjund.writerow(tulemus)
				output_file.close()
			except IOError:
				print "Väljundfaili ei saa kirjutada..."
				sys.exit(3)
except IOError:
	print "Sisendfaili ei saa avada..."
	sys.exit(2)

#Tulemuse raport kasutajale
print "Programm lõpetas töö."
