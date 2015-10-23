function uptime() return tmr.now() / 1000000 end
function mod(a, b) return a - math.floor(a/b)*b end
function step(amt) return mod(tmr.now() / 1000, step * 1000) end

function green(x) id = 'green'  end
function red(x) id = 'red'; end
function blue(x) id = 'blue'; end

function initDevice(mac)
    if mac == "18:fe:34:9a:6c:44" then green()
    elseif mac == "18:fe:34:9a:6d:10" then blue()
    elseif mac == "18:fe:34:f9:0e:d9" then red()
    else print('.. vreemde eend in de bijt')
    end
    print(mac .. ' ' .. id)
end

function connect(essid, psw)
    wifi.setmode(wifi.STATION)
    wifi.sta.config(essid, psw)
end
