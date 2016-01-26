#!/bin/python
# -*- coding: utf-8 -*-
#Otto Mättas
#See skript leiab sisendfaili põhjal URLide lähtekoodist määratud stringid.

#Vers. tabel
# v0.1 - Esimesed baaselemendid

import sys
import urllib2

#NB See skript on pooleli ja sisaldab mitmeid ebatäpsuseid
#mõeldud alustamiseks ja parandamiseks


#Skript kontrollib argumentide arvu.
if len(sys.argv) != 3:
	print "Argumentide arv on vale!"
	print "Kasuta programmi:", sys.argv[0], "[sisendfail] [väljundfail]"
	sys.exit(1)

print "Argumentide arv on: ", len(sys.argv)

#Määra sisendfail
try:
	input_file = open(sys.argv[1], 'r')
except IOError: 
	print "Sisendfaili ei saa avada."
#Määra väljundfail
try:
        output_file = open(sys.argv[2], 'w')
except IOError:
        print "Väljundfaili ei saa kirjutada."

#Loe URLi lähtekoodi. (Skript loeb ainult 20000 tähemärki, et mitte liigse koormuse alla sattuda.)
#data = urllib2.urlopen("http://www.itcollege.ee").read(20000)
#Tee lähtekoodist read, et neid võimalik lugeda oleks.
#data = data.split("\n")
#Prindi lähtekood.
#for line in data:
#    print line

#Kirjuta inputfailist read outputfaili
#for line in input_file.readlines():
#	output_file.write(line) 

print "Programm lõpetas töö"
