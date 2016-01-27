#!/bin/python
# -*- coding: utf-8 -*-
#Otto Mättas
#Skript, mis leiab sisendfailist inimeste nimed, ning annab tulemuse, milleks on nimest tuletatud EIKga seotud spetsiifiline info, väljundfailis.

#Vers. tabel
# v0.1 Ülesande defineerimine
# v0.1.1 Kondikava ülespanek
import sys

#Skript kontrollib argumentide arvu
if len(sys.argv) != 3:
        print "Argumentide arv on vale!"
        print "Kasuta programmi järgmiselt:", sys.argv[0], "[SISENDFAIL] [VÄLJUNDFAIL]"
        sys.exit(1)

#Määra sisendfail
try:
        input_file = open(sys.argv[1], 'r')
except IOError:
        print "Sisendfaili ei saa avada..."
	sys.exit(2)
#Määra väljundfail
try:
        output_file = open(sys.argv[2], 'w')
	output_file.write('hi there :)\n')
	output_file.close()
except IOError:
        print "Väljundfaili ei saa kirjutada..."
	sys.exit(3)







#Tulemuse raport kasutajale
print "Programm lõpetas töö."
