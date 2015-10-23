function ws2812seq1(tmrid, pin, speed)
    index = 0
    tmr.stop(tmrid)
    tmr.alarm(tmrid, speed, 1, function() 
        if index == 0 then
            ws2812.writergb(pin, string.char(0, 0, 255))
        elseif index ==1 then
            ws2812.writergb(pin, string.char(0, 255, 0))
        elseif index == 2 then
            ws2812.writergb(pin, string.char(255, 0, 0))
        else
            ws2812.writergb(pin, string.char(0, 0, 0))
        end
        index = (index + 1) % 4
    end)
end

function ws2812seq2(tmrid, pin, speed, amt)
    index = 0
    tmr.stop(2)
    amt = amt or 10
    tmr.alarm(tmrid, speed, 1, function() 
        if index < amt then
            r = math.random(0,255)
            g = math.random(0,255)
            b = math.random(0,255)
            ws2812.writergb(pin, string.char(r, g, b))
            index = index + 1
        else
            ws2812.writergb(pin, string.char(0, 0, 0))
            tmr.stop(tmrid)
        end   
    end)
end

-- random: r g b either on or off
function ws2812seq3(tmrid, pin, speed, amt)
    index = 0
    tmr.stop(2)
    amt = amt or 10
    tmr.alarm(tmrid, speed, 1, function() 
        if index < amt then
            r = math.random(0,1) * 255
            g = math.random(0,1) * 255
            b = math.random(0,1) * 255
            ws2812.writergb(pin, string.char(r, g, b))
            index = index + 1
        else
            -- ws2812.writergb(4, string.char(0, 0, 0))
            ws2812.writergb(pin, string.char(0, 0, 0))
            tmr.stop(tmrid)
        end   
    end)
end
