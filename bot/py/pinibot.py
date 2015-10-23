#! /usr/bin/env python
# DEPENDS: python-liblo, python-irclib, r3340

import liblo, sys, r3340
from ircbot import SingleServerIRCBot
from irclib import nm_to_n, nm_to_h, irc_lower, ip_numstr_to_quad, ip_quad_to_numstr

nickname =      "p1n2"
channel =       "#mode+v"
server =        "127.0.0.1"
IRCport =       6667
OSCport =       57120
mybotsynth =    "/p1n2"

server =        "78.47.95.83"
IRCport =       4567
channel =       "#bschan"

# send to OSC server <port> on localhost
if len(sys.argv) == 1:
	print '\033[1;31mUsage:\033[m pinibot.py [OSC port, nickname, server])'
	print '\033[1;34mno arguments, using defaults:\033[m'
elif len(sys.argv) == 2:
    OSCport = sys.argv[1]
    #print 'OSC port:\t' + OSCport
# use nickname if given
elif len(sys.argv) ==3:
    (OSCport, nickname) = (sys.argv[1], sys.argv[2])
elif len(sys.argv) ==4:
    (OSCport, nickname, server) = (sys.argv[1], sys.argv[2], sys.argv[3])
else:
    print 'nope ... :)'

print 'OSC port:\t' + str(OSCport) + '\nnickname:\t' + nickname # + '\nserver:\t\t' + server

class mini(SingleServerIRCBot):
    def __init__(self, channel, nickname, server, IRCport, OSCport, mybotsynth):
        SingleServerIRCBot.__init__(self, [(server, IRCport)], nickname, nickname)
        self.mybotsynth = mybotsynth
        self.server = server
        self.channel = channel
        self.OSCport = OSCport
        self.modep = 0
        self.patternDict = {
            '4':        '!_!!..@.!_!!..j.!_!!..@.!_!!..j.!_!!..@.!_!!..j.%#^#',
            'sape':     '4139',
            '67':       'JKJJKJJKJJKJOPOOPOOPOOPOXYZOPOXYZ29090',
            '3':        '!_!!..@.!_!!..j.!_!!..@.!_!!..j.', '1': '!_!!..@.',
            'bass4': '.3890000....0000....................,,,,,,,,,,,,....0000,,,,....0000,,,,....00998877.',
            'bass5': '3890000....0000....................,,,,,,,,,,,,....0000,,,,....0000,,,,....',
            '2':        '!_!!..j.',
            'bass2':    '.3890000....0000....................,,,,,,,,,,,,....0000,,,,....0000,,,,'
        }

        try:
            self.target = liblo.Address(self.OSCport)
        except liblo.AddressError, err:
            print str(err)
            sys.exit("oioioi OSC address error")

    def on_nicknameinuse(self, c, e):
        c.nick(c.get_nickname() + "_")

    def on_welcome(self, c, e):
        c.join(self.channel)
        print "connected to:\t" + self.server

    def on_pubmsg(self, c, e):
        a = e.arguments()[0].split(":", 1)
        if len(a) == 1 :
            self.do_command(e, a[0])
        return

    def check4p(self, c, cmd):
        # go in p mode
        if cmd == "mode+p" :
            if not self.modep :
                r3340.notify(0, '\033[1;32m entering mode+p \033[m')
                c.notice(self.channel, '\033[1;32m entering mode+p \033[m')
                #c.notice(self.channel, "commands: save show")
                #c.notice(self.channel, "save rock01 9999666600003333")
                #c.notice(self.channel, "save rock02 AAAA####&&&&@@@@")
                #c.notice(self.channel, "loading:")
                #c.notice(self.channel, "rock2")
                #c.notice(self.channel, "rock1 rock2 rock1")
                #c.notice(self.channel, "tip: use Control-a to go to the beginning of the line and write pattern name (don't forget one whitespace")

            self.is_Preset(c, cmd)
            return 1
        elif cmd == "mode-p":
            self.modep = 0
            print '\033[1;32m leaving mode+p \033[m'
            r3340.notify(1, '\033[1;32m leaving mode+p \033[m')
            c.notice(self.channel, '\033[1;32mleaving mode+p \033[m')
            return 1
        else:
            if self.modep == 1:
                self.is_Preset(c, cmd)
                return 1
            else:
                return 0

    def do_command(self, e, cmd):
        nick = nm_to_n(e.source())
        c = self.connection
        msg = liblo.Message(self.mybotsynth)

        if nick == "c":
            if not self.check4p(c, cmd):
                for i in cmd:
                    msg.add(ord(i))
                liblo.send(self.target, msg)
                r3340.notify(1, "sent: " + cmd)
            else:
                self.is_Preset(c, cmd)

        elif nick == "d":
            #patt = cmd.partition(" ")[2]
            string = r3340.cervelle(cmd)
            string.scry(100)
            #self.patternDict["currentScry"] = string.message
            #if not self.check4p(c, cmd):

            for i in string.message:
                msg.add(ord(i))
            liblo.send(self.target, msg)
            r3340.notify(1, nick + ':' + string.message)
            c.notice(self.channel, string.message)

        elif cmd == "help":
            c.notice(self.channel, "commands: master super mode+p")
        else:
            r3340.notify(0, nick + ':' + cmd)

    def is_Preset(self, c, cmd):
        pdict = self.patternDict
        msg = liblo.Message(self.mybotsynth)
        self.modep = 1
        if cmd == "mode+p":
            5 + 9
        elif cmd == "show":
            c.notice(self.channel, pdict)

        elif cmd.find("save") == 0:

            cmd = cmd.replace("save ", "")
            name = cmd.partition(" ")[0]
            patt = cmd.partition(" ")[2]
            command = ""

            patt_array = patt.rsplit(" ")
            if len(patt_array) > 1:
                # check sentence for words/patterns from dict, concatenate the words' patterns
                for word in patt_array:
                    if word in pdict:
                        command = command + pdict[word]
                    else:
                        command = command + word
                # store in dict
                pdict[name] = command
                c.notice(self.channel, command + " -> " + name)
            else:
                pdict[name] = patt
                c.notice(self.channel, patt + " -> " + name)

            for i in pdict[name]:
                msg.add(ord(i))
            liblo.send(self.target, msg)


        # is the cmdstring a key ?
        elif cmd in pdict:
            c.notice(self.channel, " <- " + pdict[cmd])
            command = pdict[cmd]
            for i in command:
                msg.add(ord(i))
            liblo.send(self.target, msg)

        # maybe there's a key hidden somewhere within the string ?
        else:
            #c.notice(self.channel, " <- " + pdict[cmd])
            command = ""
            patt_array = cmd.rsplit(" ")

            if len(patt_array) > 1:
                # check sentence for words/patterns from dict, concatenate the words' patterns
                for word in patt_array:
                    if word in pdict:
                        command = command + pdict[word]
                    else:
                        command = command + word
                c.notice(self.channel, "composed: " + command)
            else:
                command = cmd


            for i in command:
                msg.add(ord(i))
            liblo.send(self.target, msg)


# minibot go!
minibot = mini(channel, nickname, server, IRCport, OSCport, mybotsynth)
minibot.start()
