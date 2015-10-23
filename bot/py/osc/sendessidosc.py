#!/usr/bin/env python
# DEPENDS: python-liblo

import liblo, sys, time, random

#ip = "127.0.0.1"
OSCport = 57121
min=67
max=127
message='/ssid'
if len(sys.argv) == 5:
    (OSCport, message, min, max) = (sys.argv[1], sys.argv[2],  sys.argv[3], sys.argv[4] )
else:
    print '\033[1;32mexample:\033[m 57121 banana 59 123'

try:
    target = liblo.Address(OSCport)
except liblo.AddressError, err:
    print str(err)
    sys.exit("oioioi OSC address error")

while 1:
    msg = liblo.Message(message)
    #msg.add(ord(i)) for integer conversion
    #msg.add(i)
    #msg.add(chr(random.randint(34,127))
    msg.add(chr(random.randint(min, max)))
    liblo.send(target, msg)
    time.sleep(random.randint(1,9))

