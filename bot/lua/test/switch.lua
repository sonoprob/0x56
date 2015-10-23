function switch(c)
  local swtbl = {
    casevar = c,
    caseof = function (self, code)
      local f
      if (self.casevar) then
        f = code[self.casevar] or code.default
      else
        f = code.missing or code.default
      end
      if f then
        if type(f)=="function" then
          return f(self.casevar,self)
        else
          error("case "..tostring(self.casevar).." not a function")
        end
      end
    end
  }
  return swtbl
end
c = 1
switch(c) : caseof {
    [1]   = function (x) print(x,"one") end,
    [2]   = function (x) print(x,"two") end,
    [3]   = 12345, -- this is an invalid case stmt
  default = function (x) print(x,"default") end,
  missing = function (x) print(x,"missing") end,
}
print("expect to see 468:  ".. 123 +
switch(2):caseof{
	[1] = function(x) return 234 end,
  [2] = function(x) return 345 end
})
