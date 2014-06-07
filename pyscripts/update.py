#!/usr/bin/env python
# coding: utf-8

import os, sys
import gmail

comandos = sys.argv
comando = comandos.pop()

if comando=="-all" :
    os.system("sudo apt-get update")
    print "Repositórios atualizados"
    os.system("sudo apt-get upgrade -y")
    print("Pacotes atualizados")
    os.system("sudo apt-get dist-upgrade -y")
    print("Distribuição atualizada")

# else:
#     os.system("sudo apt-get update")
#     print "Os repositórios foram atualizados"
#
#     os.system("sudo apt-get autoremove")
#     print("Sistema atualizado, e limpo")


if comando=="-gmail":


  g = gmail.login("rafael.liverpool@gmail.com", "senha  )

  if g.logged_in:

    print dir(g)


    # for email in folder:
    #   print email.id, len(email), email.subject
    #   for msg in email:
    #     print "  ", msg.id, msg.number, msg.subject
    #     print msg.source
