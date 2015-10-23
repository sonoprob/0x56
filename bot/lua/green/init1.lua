dofile('irc.lua') -- shared functions
dead = true
debug = true
rc=0

mac = wifi.sta.getmac()
ip = wifi.sta.getip()
initDevice(mac)
chnl = "#bschan"
nick = id or 'e'

tmr.alarm(3, 10000, 1, function()     
    if ip == nil then
        ready = false
        local essid="newlucht-students"; local psw="kabk@air"
        -- local essid="AJJKT3"; local psw="1012dl231"
        print()
        ip = wifi.sta.getip()
        connect(essid, psw) -- alarm 2: getting ip
    else
        ready=true
        if dead == true then
            print(id .. '(' .. mac ..') online: ' .. ip)
            dofile('ircoverload.lua') -- custom functions
            connectPulsecode() -- tmr id:4, 10 sec ircd connect loop
            print(' - ' .. node.heap() .. ' bytes remaining')
        else
            send_message('#bschan', 'hi!')
        end
    end
end)
