#!/usr/bin/env python
# quick hack of the pyliblo simple server example

import liblo, sys

if len(sys.argv) == 2:
    (port) = (sys.argv[1])
else:
    print '\033[1;31mUsage:\033[m ./dumpOSC.py <port>'
    sys.exit(1)

# create server, listening on <port>
try:
    server = liblo.Server(port)
except liblo.ServerError, err:
    print str(err)
    sys.exit()

def fallback(path, args, types, src):
    print "got message '%s' from '%s'" % (path, src.get_url())
    for a, t in zip(args, types):
        print "argument of type '%s': %s" % (t, a)

# register method for everything
server.add_method(None, None, fallback)

# loop and dispatch messages every 100ms
while True:
    server.recv(100)

