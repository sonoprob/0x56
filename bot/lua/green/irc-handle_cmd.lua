function handle_command(chnl, cmd, args)
    if cmd == "google" then
        send_message(chnl, "http://google.com/search?q=" .. url_encode(table.concat(args, " ")))
    elseif cmd == "d" then
        if #args ~= 0 and #args ~= 1 then
            send_message(chnl, "Usage: ~d [sides] (default: 6)")
        end
        local n = math.floor(tonumber(args[1]) or 6)
        send_message(chnl, "d" .. n .. " roll: " .. math.random(n))
    elseif cmd == "reboot" then
        send_message(chnl, "rebooting, I'll be back")
        node.restart()
    elseif cmd == "who" then 
        send_message(chnl, "/names")    
    elseif cmd == "int" then 
        print('node.input() HERE')
        
    elseif cmd == "reload" then 
        dofile('ircoverload.lua')
    elseif cmd == "heap" then send_message(chnl, node.heap() .. ' bytes remaining')
    elseif cmd == "stop" then tmr.stop(5)
    elseif cmd == "mac" then
        send_message(chnl, wifi.sta.getmac())
    elseif cmd == "update" then 
        Upgrader.update('test2.lua', 'http://78.47.95.86/test2.lua')
    end

end
