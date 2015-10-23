chnl = chnl or "#bschan"
nick = id or 'e'

function connection(irc)
    dead = false
    irc:send("NICK " .. nick .. "\r\n")
    irc:send("USER " .. nick .. " 8 * :" .. nick .. "\r\n")
    irc:send("JOIN " .. chnl .. "\r\n")
end

function send_message(chnl, msg) irc:send("PRIVMSG " .. chnl .. " :" .. msg .. "\r\n") end

function receive(irc, text)
    if text:find("PING :") then
        irc:send("PONG :" .. string.sub(text, 7))
    elseif text:find("PRIVMSG") then
        local _, i = text:find("PRIVMSG")
        local chnl_msg = text:sub(i + 2)
        local i = chnl_msg:find(":")
        local v = text:find("!")
        if v then
            chnl_msg = chnl_msg:gsub("ACTION", text:sub(2, v - 1))
            handle_message(text:sub(2, v - 1), chnl_msg:sub(1, i - 2), chnl_msg:sub(i + 1))
        end
    elseif text:find("NICK") then
        local _, i = text:find("NICK")
        local v = text:find("!")
        if v then
            print(text:sub(2, v - 1) .. " is now known as " .. text:sub(i + 3))
        end
    elseif text:find("PART") then
        local _, i = text:find("PART")
        local chnl_msg = text:sub(i + 2)
        local i = chnl_msg:find(":")
        local v = text:find("!")
        if v then
            print(text:sub(2, v - 1) .. " has left " .. chnl_msg:sub(1, i - 2) .. "(" .. chnl_msg:sub(i + 1) .. ")\r\n")
        end
    elseif text:find("QUIT") then
        local _, i = text:find("QUIT")
        local chnl_msg = text:sub(i + 2)
        local i = chnl_msg:find(":")
        local v = text:find("!")
        if v then
            print(text:sub(2, v - 1) .. " has left IRC " .. "(" .. chnl_msg:sub(i + 1) .. ")\r\n")
        end
    elseif text:find("JOIN") then
        local _, i = text:find("JOIN")
        local chnl = text:sub(i + 2)
        local v = text:find("!")
        if v then
            print(text:sub(2, v - 1) .. " has joined " .. chnl .. "\r\n")
        end
    end
end

function disconnection(irc)
    print("- irc connection not established")
    dead = true
end

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    local i = 1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function url_encode(str)
  if str then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w %-%_%.%~])", function (c)
        return string.format ("%%%02X", string.byte(c))
    end)
    str = string.gsub (str, " ", "+")
  end
  return str
end

function connectIRC( server, port )
    if ready == true and dead == true then        
        if rc > 7 then 
            node.restart()
        else 
            print('- ' .. nick .. ': trying to connect to server') 
        end
        nick = id .. math.random(100,999)
        irc = net.createConnection(net.TCP, 0)
        irc:on("connection", connection)
        irc:on("receive", receive)
        irc:on("disconnection", disconnection)
        irc:connect(port, server)
        rc = rc + 1
    end
end

function connectPulsecode( )
    connectIRC( "78.47.95.83", 4567 )
end
