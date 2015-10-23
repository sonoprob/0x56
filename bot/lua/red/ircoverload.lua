-- how to interpret commands ? /names
-- require('pwmsnd'); require('ws2812'); 
-- require('play')
--function getgreet()
--    local greets = { 'hi', 'hoi', 'bonjour', 'ni hao', 'guten morgen', 'oh, the light' }
--    return greets[ math.random( #greets ) ]
--end

play = false

dofile('irc-handle_cmd.lua')
dofile('irc-handle_msg.lua')

print('- fn overloads read')
