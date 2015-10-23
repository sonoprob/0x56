-- irc
nick = nick or 'huh'
server = {"78.47.95.83", 4567}
chnl = "#bschan"
dead = true
debug = false
rc = 0
irc = net.createConnection(net.TCP, 0)
irc:on("connection", connection)
irc:on("receive", receive)
irc:on("disconnection", disconnection)
tmr.alarm(0, 10000, 1, function()
    if dead then
        print("connecting irc ...")
        irc:connect(server[2], server[1])
        rc = rc + 1
        if rc > 5 then
            node.restart()
        end
    end
end)

function green(x) nick = 'green'; print('green') end
function red(x) nick = 'red'; print('rhohoed') end
function blue(x) nick = 'blue'; print('blue') end

