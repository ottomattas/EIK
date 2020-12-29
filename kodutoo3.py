#!/bin/python
# -*- coding: utf-8 -*-
#Otto Mättas
#See skript leiab sisendfaili põhjal URLide lähtekoodist määratud stringid.

#Vers. tabel
# v0.1 Esimesed baaselemendid
# v1.0 Valmistoode
# v1.1 Optimaalsuse tõstmiseks toodud väljundfaili avamine tsüklist välja

import sys
import urllib2

#Skript kontrollib argumentide arvu.
if len(sys.argv) != 3:
	print "Argumentide arv on vale!"
	print "Kasuta programmi:", sys.argv[0], "[sisendfail] [väljundfail]"
	sys.exit(1)

#Väljundfaili avamine optimaalsuse tagamiseks (lisaks kontroll selle faili kirjutamise võimalikkusele)
try:
	output_file = open(sys.argv[2], 'a')
	#Ava SISENDFAIL ning eralda tekstist URLid / stringid (lisaks kontroll selle faili avamise võimalikkusele)
	try:
		with open(sys.argv[1], 'r') as input_file:
			for line in input_file.readlines():
				line = line.split(',')
				#Leiame URLi
				line_url = line[0]
				#Leiame otsitava stringi
				line_string = line[1].strip()
				#Ava URL ning leia lähtekoodist (HTMLi) otsitav string (lisaks kontroll selle URLi avamise võimalikkusele)
				try:
					url = urllib2.urlopen(line_url)
					sisu = url.read()
					tulemus = sisu.find(line_string)
					#Tulemus, kui string leiti
					if tulemus > 0:
						tulemus = "JAH"
					#Tulemus, kui stringi ei leitud
					else:
						tulemus = "EI"
					#Väljundfaili kirjutatava defineerimine
					valjund = line_url + "," + line_string + "," + tulemus
					#Teeme väljundfaili kirjutatavast stringi
					valjund = str(valjund)
					#Kirjutame tulemused väljundfaili eraldi ridadele
					output_file.write(valjund + "\n")
				except Exception:
					print "URLi", line_url, "ei saa avada!"
	except IOError:
		print "Sisendfaili ei saa avada..."
		sys.exit(2)
	output_file.close()
except IOError:
	print "Väljundfaili ei saa kirjutada..."
	sys.exit(3)

#Tulemuse raport kasutajale
print "Programm lõpetas töö."
