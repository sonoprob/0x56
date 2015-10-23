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

a = switch {
  [1] = function (x) print(x,10) end,
  [2] = function (x) print(x,20) end,
	['oi'] = function (x) print(x,3320) end,
  default = function (x) print(x,0) end,
}

a:case(2)  -- ie. call case 2 
a:case(9)
a:case('oi')
