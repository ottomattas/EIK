#!/bin/python
# -*- coding: utf-8 -*-
#Otto Mättas
#Skript, mis leiab sisendfailist inimeste nimed, ning annab tulemuse, milleks on nimest tuletatud EIKga seotud spetsiifiline info, väljundfailis.

#Vers. tabel
# v0.1 Ülesande defineerimine
# v0.1.1 Kondikava ülespanek
# v0.1.2 Sisendfailist saame vähendatud listi
import sys

#Skript kontrollib argumentide arvu
if len(sys.argv) != 3:
	print "Argumentide arv on vale!"
	print "Kasuta programmi järgmiselt:", sys.argv[0], "[SISENDFAIL] [VÄLJUNDFAIL]"
	sys.exit(1)

#Määra sisendfail
try:
	input_file = open(sys.argv[1], 'r')

#	lines = input_file.read().split('\t')
#	x = lines
#	x = x[2:]
#	print x
#	with open(sys.argv[1], 'r') as myfile:
#		data=myfile.read().replace('\n', '')
#		data[0: data.find(' ') ]
#	print data

#	with open(sys.argv[1]) as f:
#		lines = f.readlines()
#		lines.partition('\t')[0]

#	for number in input_file.read().split('\t'):
#		print number
#	for nimi in input_file.read().split():
#		print nimi
#	input_file.close

except IOError:
	print "Sisendfaili ei saa avada..."
	sys.exit(2)
#Määra väljundfail
try:
	output_file = open(sys.argv[2], 'w')
	output_file.write('hasdi there :)\n')
	output_file.close()
except IOError:
	print "Väljundfaili ei saa kirjutada..."
	sys.exit(3)

#Eemalda väljundist numbrid
data = input_file.read().split('\t')
#Eemalda väljundist päis
data = data[2:]
print data


#Tulemuse raport kasutajale
print "Programm lõpetas töö."
