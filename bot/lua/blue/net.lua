id = nil
initDevice(wifi.sta.getmac())
function connect(essid, psw)
    ready=false
    tmr.alarm(2, 5000, 1, function() 
        -- ip, nm, router = wifi.sta.getip()
        ip = wifi.sta.getip()
        if ip == nil then
            ready=false
            wifi.setmode(wifi.STATION)
            wifi.sta.config(essid, psw)
        else        
            print('- ip: ' .. ip)
            ready=true
            tmr.stop(2)
        end
    end)
end
if ip == nil then connect(essid or "AJJKT3", psw or "1012dl231") end