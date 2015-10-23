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
        print(l .. ' ')
        -- soundLightSequence2(3, 2, 4, l, l, l * 100) -- tmrid, spin, lpin, speed, amt, root    
    end
    
    if msg:find(nick) then
        send_message(chnl, usr .. getgreet())
        -- send_message(chnl, usr .. ": hey")
    elseif msg:find("~") == 1 then
        local cmd = split(msg)
        handle_command(chnl, cmd[1]:sub(2), {select(2, unpack(cmd))})
    end
end
