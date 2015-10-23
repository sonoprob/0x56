require('pwmsnd'); require('ws2812'); 
require('play')

function getgreet()
    local greets = { 'hi', 'hoi', 'bonjour', 'ni hao', 'guten morgen', 'oh, the light' }
    return greets[ math.random( #greets ) ]
end

function handle_message(usr, chnl, msg)
    if chnl == nick then chnl = usr end
    if debug == true then
        print('' .. usr .. ':\t' .. msg)
        words = split(msg, ' ')
        for word in words do
            -- local l = string.len(word)
            for letter in word do
                -- soundLightSequence2(3, 2, 4, l, l, l * 100)
                note = string.byte(letter)
                -- freq = 220 * 2^(note/12)
                -- timeHigh = period / 2 = 1 / (2 * toneFrequency)                
                tone(2, 100 * note )
            end
        end        
    end

    if play == true then
        l = string.len(msg)
        soundLightSequence2(3, 2, 4, l, l, l * 100) -- tmrid, spin, lpin, speed, amt, root    
    end
    
    if msg:find(nick) then
        send_message(chnl, usr .. getgreet())
        -- send_message(chnl, usr .. ": hey")
    elseif msg:find("~") == 1 then
        local cmd = split(msg)
        handle_command(chnl, cmd[1]:sub(2), {select(2, unpack(cmd))})
    end
end

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
    elseif cmd == "run" then 
        dofile('ircoverload.lua') 
    elseif cmd == "heap" then 
        send_message(chnl, node.heap())
    elseif cmd == "mac" then 
        send_message(chnl, wifi.sta.getmac())
    elseif cmd == "update" then 
        Upgrader.update('test2.lua', 'http://78.47.95.86/test2.lua')
    end

end

send_message(chnl, 'overload read')