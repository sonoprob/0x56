

tmr.alarm(4, 10000, 1, function()
    tmr.alarm(5, math.random(100, 10000), 0, function() 
        if ready == true and dead == false then
            send_message(chnl, 'I\'d say: ' .. math.random(100,999))
        end
    end)

end)

----

accept a string and put the string into Lua interpretor.
same as pcall(loadstring(str)) but support multi seperated line.
node.input(str)
Parameters
str: Lua chunk

        -- Never use node.input() in console. No effect.
    sk:on("receive", function(conn, payload) 
        node.input([[print("hello blublube")]]) 
      end
    )




-- create hello.lua file.
  file.open("hello.lua","w+")
  file.writeline([[print("hello nodemcu")]])
  file.writeline([[print(node.heap())]])
  file.close()

  -- compile this file. A file named hello.lc is generated.
  node.compile("hello.lua")
  dofile("hello.lua")
  dofile("hello.lc")


    
    -- register callback function for long press node key.
    -- here callback is "print('hello world').
    node.key("long", function() 
        print('hello world') 
      end
    )


    v = node.readvdd33() / 1000
    print(v)
    v=nil
    
    ----------------------------------------------------------------------------------

tmr.alarm(3, 10000, 1, function() 
    if ready == true and dead == true then -- connected to internet AND irc server
        if rc > 7 then node.restart() end
        nick = id .. math.random(10,400)
        irc = net.createConnection(net.TCP, 0)
        irc:on("connection", connection)
        irc:on("receive", receive)
        irc:on("disconnection", disconnection)
        irc:connect(4567, "78.47.95.83")
        print('- ' .. id .. ': trying to connect to irc')
        rc = rc + 1
    end
end)

----------------------------------------------------------------------------------

-- tmr.stop(1) -- stop trying to connect to irc
print(node.heap())

-- r,u,t=file.fsinfo() 
-- print("Total : "..t.." bytes\r\nUsed  : "..u.." bytes\r\nRemain: "..r.." bytes\r\n") 
-- r=nil u=nil t=nil

print(nick)
-- function blue(x) nick = 'blue'; print('bbblue') end -- override
--connect("newlucht-students","kabk@air")


----------------------------------------------------------------------------------
function handle_message(usr, chnl, msg)
    if chnl == nick then chnl = usr 
    end
    if msg:find(nick) then
        send_message(chnl, usr .. ': ' .. getgreet())
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
    elseif cmd == "overload" then
        dofile('ircoverload.lua')
    elseif cmd == "play" then      
        dofile('play.lua') 
    elseif cmd == "reboot" then
        send_message(chnl, "rebooting, I'll be back")
        node.restart()
    elseif cmd == "mac" then
        send_message(chnl, wifi.sta.getmac())
    elseif cmd == "update" then        
        Upgrader.update('test2.lua', 'http://78.47.95.86/test2.lua')
    end
end
