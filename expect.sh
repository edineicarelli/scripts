#!/usr/bin/expect

spawn su
expect {
	"*Senha:*"	{
			sleep 2
			send "lotaxi0132@*\r"
			sleep 2
			send "/etc/init.d/networking restart ; exit\r"
			exp_continue
			}
	}