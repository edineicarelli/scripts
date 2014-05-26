#!/usr/bin/python
# coding: utf-8

import os, sys, getopt

def main(argv):

    try:
        opts, args = getopt.getopt(argv,"hac")
    except getopt.GetoptError:
        print "\nModo de uso: \n-a : Atualizar Repositórios, Pacotes E Distribuição\n-c : Remover pacotes desnecessários\nObs: sem nenhuma parâmetro o sistema irá apenas atualizar os repositórios "
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print "\nModo de uso: \n-a : Atualizar Repositórios, Pacotes E Distribuição\n-c : Remover pacotes desnecessários\nObs: sem nenhuma parâmetro o sistema irá apenas atualizar os repositórios "
            sys.exit()
        elif opt in ("-a"):
            os.system("sudo apt-get update")
            print "Repositórios atualizados"
            os.system("sudo apt-get upgrade -y")
            print("Pacotes atualizados")
            os.system("sudo apt-get dist-upgrade -y")
            print("Distribuição atualizada")
        elif opt in ("-c"):
            os.system("sudo apt-get autoremove")
            print("Sistema atualizado, e limpo")

        
    print set(opts)
    print "\nE também\n"
    print arg        
if __name__ == "__main__":
    main(sys.argv[1:])