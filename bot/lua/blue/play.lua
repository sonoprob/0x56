require('pwmsnd')
require('ws2812')

function soundLightSequence1(tmrid, spin, lpin, speed, amt)
    tmr.stop(tmrid)
    tmr.alarm(tmrid, 1000 / speed, 1, function() 
        m = math.random(1,100)
        tone(spin, m)
        -- ws2812.writergb(lpin, string.char(m, 0, math.random(0,4)*30))
        -- ws2812.writergb(lpin, string.char(math.random(0,3)*100, 0, math.random(0,2)*100))
        ws2812.writergb(lpin, string.char(255, 0, math.random(0,2)*100))
        amt = amt - 1
        if amt == 0 then tmr.stop(tmrid); pwm.stop(spin); ws2812.writergb(lpin, string.char(0,0,0)) end
    end)
end

function soundLightSequence2(tmrid, spin, lpin, speed, amt, root)
    tmr.stop(tmrid)
    tmr.alarm(tmrid, 1000 / speed, 1, function() 
        local mul = math.random(0,2)
        tone(spin, root * (mul+1))
        -- ws2812.writergb(lpin, string.char(m, 0, math.random(0,4)*30))
        -- ws2812.writergb(lpin, string.char(math.random(0,3)*100, 0, math.random(0,2)*100))
        ws2812.writergb(lpin, string.char(255, 0, mul * 125 ))
        amt = amt - 1
        if amt == 0 then tmr.stop(tmrid); pwm.stop(spin); ws2812.writergb(lpin, string.char(0, 0, 0)) end
    end)
end