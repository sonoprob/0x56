#! /usr/bin/env python

"""
    stats -- Prints some channel information.
    disconnect -- Disconnect the bot.  The bot will try to reconnect
                  after 60 seconds.
    die -- Let the bot cease to exist.
"""

import liblo
import irc.bot
import irc.strings
from irc.client import ip_numstr_to_quad, ip_quad_to_numstr

class TestBot(irc.bot.SingleServerIRCBot):
    def __init__(self, channel, nickname, server, port=6667, OSCport=57120):
        irc.bot.SingleServerIRCBot.__init__(self, [(server, port)], nickname, nickname)
        self.server = server
        self.channel = channel
        self.nickname = nickname

        try:
			self.target = liblo.Address(OSCport)
        except liblo.AddressError, err:
            print str(err)
            sys.exit("OSC address error")

    def on_nicknameinuse(self, c, e):
        c.nick(c.get_nickname() + "_")

    def on_welcome(self, c, e):
        c.join(self.channel)
        print "connected to:\t" + self.server

    def on_privmsg(self, c, e):
        self.do_command(e, e.arguments[0])

    def on_pubmsg(self, c, e):
        a = e.arguments[0].split(":", 1)
        if len(a) > 1 and irc.strings.lower(a[0]) == irc.strings.lower(self.connection.get_nickname()):
            self.do_command(e, a[1].strip())
        return

    def do_command(self, e, cmd):
        nick = e.source.nick
        c = self.connection
        target = self.target
        c.notice(nick, "--- Channel statistics ---")

        msg = liblo.Message(self.nickname)   # nickname is osc tag...
        #msg.add(nick)
        #~ if nick == "iow":
			#~ for i in cmd:
				#~ #msg.add(ord(i)) #ord: char's ascii number
				#~ msg.add(i)
			#~ liblo.send(target, msg)

        #~ for i in cmd:
			#~ msg.add(ord(i))
			#~ liblo.send(target, msg)
			#~ print msg
        for i in cmd:
            msg.add(ord(i))

        liblo.send(target, msg)

        if cmd == "disconnect":
            self.disconnect()
        elif cmd == "die":
            self.die()
        elif cmd == "stats":
            print 'stats?'
            for chname, chobj in self.channels.items():
                c.notice(nick, "--- Channel statistics ---")
                c.notice(nick, "Channel: " + chname)
                users = chobj.users()
                users.sort()
                c.notice(nick, "Users: " + ", ".join(users))
                opers = chobj.opers()
                opers.sort()
                c.notice(nick, "Opers: " + ", ".join(opers))
                voiced = chobj.voiced()
                voiced.sort()
                c.notice(nick, "Voiced: " + ", ".join(voiced))
        else:
            c.notice(nick, "Not understood: " + cmd)

def main():
    import sys

    nickname =      "p1n1"
    #channel =       "#mode+v"
    server =        "127.0.0.1"
    IRCport =       6667
    OSCport =       57120

    print len(sys.argv)

    if len(sys.argv) != 5:
        print("Usage: Dtestbot <server[:port]> <channel> <nickname> <oscport>")
        print("$ ./ircbot.py 127.0.0.1 \"mode+v\" jk 57124")
        sys.exit(1)

    s = sys.argv[1].split(":", 1)
    server = s[0]
    if len(s) == 2:
        try:
            port = int(s[1])
        except ValueError:
            print("Error: Erroneous port.")
            sys.exit(1)
    else:
        port = 6667

    channel = sys.argv[2]
    nickname = sys.argv[3]
    OSCport = sys.argv[4]
    #print nickname

    #bot = TestBot(channel, nickname, server, port)
    bot = TestBot("#mode+v", nickname, "127.0.0.1", 6667, OSCport)
    #bot = TestBot(channel, nickname, server, IRCport, OSCport)
    bot.start()
    print 'started...'

if __name__ == "__main__":
    main()

