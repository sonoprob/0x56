require('std')
require('irc')
debug = false
ready = false
play = false
-- essid="newlucht-students"; psw="kabk@air"
essid="AJJKT3"; psw="1012dl231"; dofile('net.lua') -- tmr 2
tmr.alarm(3, 20000, 1, function ()
    if ready == true then
        if dead == true then
            connectPulsecode(4, 'ircoverload.lua')
        else 
            play = true
            tmr.stop(4)
        end
    end
end
)
node.heap()