local updatables = {}
local list = {}

function updatables.add(obj)
  list[#list+1] = obj
end

function updatables.update(dt)
  for index, obj in ipairs(list) do obj:update(dt) end
end

return updatables