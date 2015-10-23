#! /usr/bin/env python

"""
	NIEUW:
	choose OSC recipient

	DENK AAN REPL EN ALLE AANTEKENINGEN
	EERST IETS ANDERS: COMMANDS
"""

# self.connection.notice

import sys, liblo
import irc.bot, irc.strings
from irc.client import ip_numstr_to_quad, ip_quad_to_numstr


class AutoBot2(irc.bot.SingleServerIRCBot):
	def __init__(self, channel, nickname, listeningTo, ircserver, port, osc_recipient, OSCport, osctag):
		irc.bot.SingleServerIRCBot.__init__(self, [(ircserver, port)], nickname, nickname)
		self.server = ircserver
		self.channel = channel
		self.nickname = nickname
		self.oscport = OSCport
		self.oscrecipient = osc_recipient
		self.osctag = osctag
		self.listeningto = listeningTo

		try:
			self.target = liblo.Address(self.oscrecipient, self.oscport)
		except liblo.AddressError, err:
			print str(err)
			sys.exit("OSC address error")

	def on_nicknameinuse(self, c, e):
		c.nick(c.get_nickname() + "_")

	def on_welcome(self, c, e):
		c.join(self.channel)
		c.notice(self.channel, 'Hi everybody, my name is '+c.get_nickname()+' I are understand: stats, change, start_synth and stop_synth')
		print "irc server:\t" + self.server
		print 'room:\t\t' + self.channel
		print "sc client:\t" + str(self.oscrecipient) + ':' + str(self.oscport)
		print 'botnick:\t' + c.get_nickname()
		print "listens to:\t" + self.listeningto

	def on_privmsg(self, c, e):
		self.do_command(e, e.arguments[0])

	def on_pubmsg(self, c, e):
		a = e.arguments[0];
		if len(a) > 0 :
			cmd = a #[0].strip()
			self.do_command(e, cmd)
		return

	def do_command(self, e, cmd):
		nick = e.source.nick
		c = self.connection
		target = self.target
		c.notice(nick, "--- Channel statistics ---")

		# global commands
		if cmd == "stats":
			for chname, chobj in self.channels.items():
				c.notice(self.channel, chname)
				users = chobj.users()
				users.sort()
				c.notice(self.channel, ", ".join(users))

		# commands for botmaster only
		elif nick == self.listeningto:
			print e.source.nick + ": ", str(cmd), len(cmd)
			if cmd == "change":
				self.change(c, target)
			elif cmd == "disconnect":
				self.disconnect()
			elif cmd == "die":
				bot.target.free
				self.die()
			elif cmd == "start_synth":
				liblo.send(target, liblo.Message("/start"))
				print 'osc: start synth'
				c.notice(nick, "starting sc")
			elif cmd == "stop_synth":
				liblo.send(target, liblo.Message("/stop"))
				print 'osc: stop synth'
			else:
				msg = liblo.Message(self.osctag)
				for i in cmd:
					msg.add(ord(i))
				liblo.send(target, msg)
				#c.notice(self.channel, len(cmd))
				
		## send it, regardless of who is typing
		#msg = liblo.Message(self.osctag)
		#for i in cmd:
		#		msg.add(ord(i))
		#liblo.send(target, msg)
		#c.notice(self.channel, len(cmd))

	def change(self, c, target):
		c.notice(self.channel, "waiting for input in bot terminal...")
		#print '\nchanging parameters, press return to keep the current value\n'
		print 'changing OSC recipient values:'

		new_recipient = raw_input("IP/hostname (default=" + self.oscrecipient + ")\t:")
		if(new_recipient):
			self.oscrecipient = new_recipient

		new_oscport = raw_input("port (default=" + str(self.oscport) + ")\t\t:")
		if(new_oscport):
			self.oscport = new_oscport

		new_osctag = raw_input("tag (default=" + self.osctag + ")\t\t:")
		if(new_osctag):
			self.osctag = new_osctag

		try:
			self.target = liblo.Address(self.oscrecipient, self.oscport)
			print "sending /" + self.osctag + " messages to " + self.target.hostname + ":" + str(self.target.port)
			c.notice(self.channel, "now sending /"  + self.osctag + " messages to " + self.target.hostname + ":" + str(self.target.port))
		except liblo.AddressError, err:
			print str(err)
			sys.exit("OSC address error")

def main():
	nickname =		"p1"
	ircserver =		"127.0.0.1"
	IRCport =		6667
	channel =		"#mode+v"
	osc_recipient = "127.0.0.1"
	OSCport =		57120

	if len(sys.argv) == 1:
	    print '\033[1;34mno arguments (nickname/osctag, ircserver) given, using defaults:', nickname, ircserver, '\033[m'
	elif len(sys.argv) == 2:
	    nickname = sys.argv[1]
	elif len(sys.argv) ==3:
	    (nickname, ircserver) = (sys.argv[1], sys.argv[2])
	else:
	    print 'nope ... :)'

	osctag = 		nickname
	listeningTo =	"mr" + nickname

	bot = AutoBot2(channel, nickname, listeningTo, ircserver, IRCport, osc_recipient, OSCport, osctag)
	bot.start()

if __name__ == "__main__":
	main()
