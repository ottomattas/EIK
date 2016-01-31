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

import sys

print "################################################################################"
print "###PROGRAMM EI TÖÖTA KAUGELTKI VEEL NII NAGU ÜLESANDE LÄHTETEKST SEDA SOOVIB!###"
print "################################################################################"


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
			eesnimi = nimed[0]
			perekonnanimi = nimed[1] 
#			print ("Eesnimi:", eesnimi, "Perekonnanimi:", perekonnanimi)
except IOError:
	print "Sisendfaili ei saa avada..."
	sys.exit(2)

#Määra VÄLJUNDFAIL (lisaks kontroll selle faili avamise võimalikkusele)
try:
	output_file = open(sys.argv[2], 'w')
#	print t2ht+perenimi','t2isnimi','eesnimi'.'perenimi'@itcollege.ee,'token
	#Sulgeme VÄLJUNDFAILI
#	output_file.close()
except IOError:
	print "Väljundfaili ei saa kirjutada..."
	sys.exit(3)

#Tulemuse raport kasutajale
print "Programm lõpetas töö."
