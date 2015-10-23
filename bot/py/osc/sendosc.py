#!/usr/bin/env python
# DEPENDS: python-liblo

import liblo, sys, time, random

#ip = "127.0.0.1"
OSCport = 57124

if len(sys.argv) == 4:
    (OSCport, message, i) = (sys.argv[1], sys.argv[2], sys.argv[3])
else:
    print '\033[1;32mexample:\033[m 57121 banana'

try:
    target = liblo.Address(OSCport)
except liblo.AddressError, err:
    print str(err)
    sys.exit("oioioi OSC address error")

while 1:
    msg = liblo.Message(message)
    #msg.add(ord(i)) for integer conversion
    #msg.add(i)
    msg.add(chr(random.randint(34,127))
    liblo.send(target, msg)
    time.sleep(random.randint(1,9))

