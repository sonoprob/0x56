function uptime() return tmr.now() / 1000000 end
function mod(a, b) return a - math.floor(a/b)*b end
function step(amt) return mod(tmr.now() / 1000, step * 1000) end

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

function rltrim(str)
    local rltrim = string.match(string.match(str, "%S.*"), ".*%S")
    return string.format("%s", rltrim)
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

function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

function switch(t)
  t.case = function (self,x)
    local f=self[x] or self.default
    if f then
      if type(f)=="function" then
        f(x,self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end

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