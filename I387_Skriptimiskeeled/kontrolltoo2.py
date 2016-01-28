#!/bin/python
# -*- coding: utf-8 -*-
#Otto Mättas
#Skript, mis leiab sisendfailist inimeste nimed, ning annab tulemuse, milleks on nimest tuletatud EIKga seotud spetsiifiline info, väljundfailis.

#Vers. tabel
# v0.1 Ülesande defineerimine
# v0.1.1 Kondikava ülespanek
# v0.1.2 Sisendfailist saame vähendatud listi
# v0.1.3 Koodi vormingu seadmine

import sys

print "################################################################################"
print "###PROGRAMM EI TÖÖTA KAUGELTKI VEEL NII NAGU ÜLESANDE LÄHTETEKST SEDA SOOVIB!###"
print "################################################################################"


#Programm kontrollib argumentide arvu
if len(sys.argv) != 3:
	print "Argumentide arv on vale!"
	print "Kasuta programmi järgmiselt:", sys.argv[0], "[SISENDFAIL] [VÄLJUNDFAIL]"
	sys.exit(1)

#Määra SISENDFAIL (lisaks kontroll selle faili avamise võimalikkusele)
try:
	input_file = open(sys.argv[1], 'r')
	#Leiame sisendfailist listid
	for line in input_file:
		#Eraldame listist vajaliku info
		data = line.split(' ')
		data = data[0:2]
		#TESTPRINT
		print data
		#Sulgeme SISENDFAILI
	input_file.close()
except IOError:
	print "Sisendfaili ei saa avada..."
	sys.exit(2)

#Määra VÄLJUNDFAIL (lisaks kontroll selle faili avamise võimalikkusele)
try:
	output_file = open(sys.argv[2], 'w')
#	print t2ht+perenimi','t2isnimi','eesnimi'.'perenimi'@itcollege.ee,'token
	#Sulgeme VÄLJUNDFAILI
	output_file.close()
except IOError:
	print "Väljundfaili ei saa kirjutada..."
	sys.exit(3)

#Tulemuse raport kasutajale
print "Programm lõpetas töö."
