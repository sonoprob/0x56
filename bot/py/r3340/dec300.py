#!/usr/bin/env python
#
# skeleton for an awesome dec300 class :)
# Many thanks to ejh for the kickstart!


from telnetlib import Telnet
import random, time

# class to talk to a 'REMOTE' port of a decserver
class dec(Telnet):
        # ansi prefix
        def ansicmd(self,cmd):
                self.write("\x1b[%s" % cmd)
        # ansi goto
        def goto(self,x,y):
                self.ansicmd("%d;%dH" % (y,x))
        # setup terminal
	def send(self,str,x,y):
		for chr in str:
			self.goto(x,y)
			self.write(chr)
			x = x + 1
        def init(self):
                self.ansicmd("2J")  # clear screen
                self.ansicmd("3g")  # clear tabs
                self.ansicmd("?7l") # clear autowrap
                self.ansicmd("?1h") # clear cursor
                self.ansicmd("?4l") # smooth scrolling
                self.ansicmd("?25l") # no cursor!


# TODO: put me in a self test
#T1 = dec('192.168.1.103', 2002)
#T1.init()

#while True:
#	T1.send("poo",3,2)

#y = 1

#screen = ["?5l", "?5h"]

