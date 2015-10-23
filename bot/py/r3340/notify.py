# notify.py
# couple of def to print pretty things

def notify(state, msg):
    if state == 1:
        print '\033[1;32m:) \033[m' + msg
    else:
        print '\033[1;31m:( \033[m' + msg
