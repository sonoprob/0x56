# cervelle is a class that contains various string methods used by r3340
# Usage:
#seq = cervelle("!___!---!___!--##")
#serviette = {'!': "!_!", 'x': "xxxx", '_': "sdfghj"}
#seq.debains(serviette)
#print seq.message

import random

class cervelle:
    def __init__(self, message):
        self.message = message
    
    def remix(self):
        '''remix() shuffle the message'''
        self.message = ''.join(random.sample(self.message, len(self.message)))

    def cornucopia(self, length):
        '''cornucopia() randomly pick characters
        from the message and produce a new 
        string of the given length'''
        cornucopia = ''
        for i in range(int(length)):
            cornucopia = cornucopia + random.choice(self.message)
        self.message = cornucopia

    def scry(self, length):
        '''scry() turns the message into a
        simple markov chain that can be used
        to generate a new message at a given length.'''
        if len(self.message) > 1 :
            
            markov, table = '', {}
            char1, char2 = self.message[0], self.message[1]

            for char in self.message:
                table.setdefault((char1, char2), []).append(char)
                char1, char2 = char2, char

            # Shitty trick to make the chain loop
            table.setdefault((char1, char2), []).append(self.message[0])
            table.setdefault((char2, self.message[0]), []).append(self.message[1])

            for i in range(int(length)):
                newchar = random.choice(table[(char1, char2)])
                markov = markov + newchar
                char1, char2 = char2, newchar

            self.message = markov

    def shift(self):
        '''shift() will shift up one ascii char'''
        shifted = ''
        for char in self.message:
            shifted = shifted + chr(ord(char) + 1)
        self.message = shifted

    def stretch(self, length):
        '''stretch() will repeat the number 
        of characters in the message by the 
        given multiplier while preserving the 
        order'''
        stretched = ''
        for char in self.message:
            stretched = stretched + char * int(length)
        self.message = stretched
        
    def mushroom(self):
        '''mushroom() turns all the capital 
        letters in the message into small 
        letters and vice-versa'''
        self.message = self.message.swapcase()

    def freeze(self):
        '''freeze() fills a new string of the
        same length as the message and only 
        using a random character from the message'''
        self.message = random.choice(self.message) * len(self.message)

    def debains(self, serviette):
        '''replace string with dictionary from string 
        if possible  // and recurse???????'''

        self.message = wrap(self.message, serviette, 4)
#        print self.message

    def null(self):
        '''nothing'''
        self.message = self.message


def wrap(message, serviette, recur):
    torchon = ''
    if recur < 1: 
        return message
    else:
        for char in message:
            if char in serviette:            
                torchon = torchon + serviette[char]
            else:
                torchon = torchon + char
        return wrap(torchon, serviette, recur-1)
