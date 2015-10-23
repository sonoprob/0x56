Usage

LuaSrcDiet myscript.lua -o myscript_.lua
lua LuaSrcDiet.lua myscript.lua -o myscript_.lua

-- for maximum code size reduction and maximum verbosity, use: 
LuaSrcDiet --maximum --details myscript.lua -o myscript_.lua

When run without arguments, LuaSrcDiet prints a list of options. 
Check the Makefile for some examples of command lines to use. 




        -- getgreet() not ther
            -- local t = id .. ' ' .. uptime() .. ' s'
            -- print(t)
            -- send_message(chnl, t .. getgreet() )        
    
-- irc:send("NAMES" .. "\r\n")
-- irc:send("NAMES" .. "\r\n")

-- tmr.stop(3)

-- snd and light -- ws, pwm, play
-- if dead == false
-- require('pwmsnd'); require('ws2812'); require('play')

-- dofile('ircoverload.lua')



    -- soundLightSequence1(3, 2, 4, l+1,  l+1)
            -- soundLightSequence1(3, 2, 4, l, l * l) -- tmrid, spin, lpin, speed, amt        
            -- soundLightSequence2(3, 2, 4, l + 1, l + 2, 100 * l) -- tmrid, spin, lpin, speed, amt, root
        -- soundLightSequence1(3, 2, 4, l, l * l) -- tmrid, spin, lpin, speed, amt                


function getGreet()
	local greets = { 'hi', 'hoi', 'bonjour', 'ni hao', 'guten morgen', 'oh, the light' }
	return greets[ math.random( #greets ) ]
end

-- no infinite timers !
-- use nested timers
-- irc hooks
-- sta table with events reactions
-- talking


send_message('#bschan', 'hi!')
-- tmr.stop(1) -- stop trying to connect to irc
-- function blue(x) id = 'blue'; ws2812seq2(50, 100) end -- override

print(string.char(123))

for letter in 'dds' do
    print(string.byte(letter))
end

charToTone()
    
    
soundLightSequence2(5, 2, 4, 3, 23, 300) -- tmrid, spin, lpin, speed, amt, root
soundLightSequence2(5, 2, 4, 8, 32, 100) -- tmrid, spin, lpin, speed, amt, root
tmr.alarm(id, interval, repeat, function do())
-- id: 0~6, alarmer id. 
-- interval: alarm time, unit: millisecond
-- repeat: 0 - one time alarm, 1 - repeat
-- function do(): callback function for alarm timed out

-- fire at 4 seconds in future
tmr.alarm(5, 4000, 0, function () print('hi') end)
tmr.stop(5)
stoptone(2)

step=0
tmr.alarm(5, 500, 1, function ()
    -- soundLightSequence2(5, 2, 4, 8+step, 3, 100) -- tmrid, spin, lpin, speed, amt, root
    tone(2, 100 * step)
    step=step+1
    if step == 9 then tmr.stop(5) end
end)


tone


------------------------------



tmr.alarm(id, interval, repeat, function do())
print(mod(tmr.time() / 1000,100)) -- return rtc time since start up in second, uint31 form.
print(tmr.time()) -- return rtc time since start up in second, uint31 form.
print(tmr.now()) -- return the current value of system counter: uint31, us.
-- msec
print(tmr.now() / 1000) -- return the current value of system counter: uint31, us.
-- sec

print( tmr.now() / 1000000 ) -- return the current value of system counter: uint31, us.


function mstep() return  end

-- seconds 16
function step()
    -- return { mod(tmr.now() / 1000000, 16), mod(tmr.now() / 1000, 1000) }
    return mod(tmr.now() / 1000, 16000)
end


local msec = tmr.now() / 1000
local secs = msec / 1000-- seconds since boot
print(step()[1] .. ' ' .. step()[2])
print(mstep()); print(step())
print(step())
tempo = 1
tempo = 2


print(  ) -- return the current value of system counter: uint31, us.

-- should call tmr.wdclr() in a long loop to avoid hardware reset caused by watchdog
for i=1,10000 do 
    print(i)
    tmr.wdclr()   
end 



dofile('init0.lua') -- wifi
dofile('init1.lua') -- irc
dofile('init2.lua') -- ws, pwm¬

-- 
soundLightSequence1(3, 2, 4, 1) -- tmrid, spin, lpin, speed
soundLightSequence2(5, 2, 4, 3, 23, 300) -- tmrid, spin, lpin, speed, amt, root
-- 
tmr.stop(3)


tmr.alarm(4, 1000, 1, function()
    if ready then
        ws2812seq1(3, 4, 100)
        -- ws2812seq2(2, 1000, 3) -- pin, speed, amt
        -- ws2812seq3(4, 300, 3)
        -- soundLightSequence1(3, 2, 4, 1) -- tmrid, spin, lpin, speed
        tmr.stop(4)
    end
end)


tmr.alarm(id, interval, repeat, function do())
print(mod(tmr.time() / 1000,100)) -- return rtc time since start up in second, uint31 form.
print(tmr.time()) -- return rtc time since start up in second, uint31 form.
print(tmr.now()) -- return the current value of system counter: uint31, us.
-- msec
print(tmr.now() / 1000) -- return the current value of system counter: uint31, us.
-- sec

print( tmr.now() / 1000000 ) -- return the current value of system counter: uint31, us.

function step()
    -- return { mod(tmr.now() / 1000000, 16), mod(tmr.now() / 1000, 1000) }
    return mod(tmr.now() / 1000, 16000)
end


local msec = tmr.now() / 1000
local secs = msec / 1000-- seconds since boot
print(step()[1] .. ' ' .. step()[2])
print(mstep()); 
print(step())
print(step())
tempo = 1
tempo = 2


print(  ) -- return the current value of system counter: uint31, us.

-- should call tmr.wdclr() in a long loop to avoid hardware reset caused by watchdog
for i=1,10000 do 
    print(i)
    tmr.wdclr()   
end 







--

function mod(a, b)
    return a - math.floor(a/b)*b
end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function monitor(interval)
    tmr.stop(0)
    tmr.alarm(0, interval*1000, 1, function() 
        print('heap: '..node.heap())
    end)
end

function splitstring(string, sep)
    if sep == nil then sep = "%s" end
    local t={} ; i=1
    for str in string.gmatch(string, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
   
print("-- fn-std.lua")

--