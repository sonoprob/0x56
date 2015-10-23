function action1()
 print("action1")
end

function action2()
 print("action2")
end


function FSM(t)
  local a = {}
  for _,v in ipairs(t) do
    local old, event, new, action = v[1], v[2], v[3], v[4]
    if a[old] == nil then a[old] = {} end
    a[old][event] = {new = new, action = action}
  end
  return a
end

fsm = FSM{
  {"state1", "event1", "state2", action1},
  {"state1", "event2", "state3", action2},
}

local a = fsm["state1"]["event1"]
a.action()
state = a.new