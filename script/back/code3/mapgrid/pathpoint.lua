local pathpoint = {}

---@class map.pathpoint
---@overload fun(value: number, from: number): map.pathpoint|nil
local objPathpoint = {}

function objPathpoint:reset()
  self.value = nil
  self.from = nil
end

function objPathpoint:draw()
  if self.value > 0 then
    love.graphics.print(tostring(self.value), self.cell:getPositionScreen())
  end
end

---@param value number
---@param from map.pathpoint
function objPathpoint:setValue(value, from)
  if not self.value then
    self.value = value + 1
  end
  if self.value > value then
    self.value = value
    self.from = from
    return self.cell
  end
  return nil
end

local mtPathPt = {
  __index = objPathpoint,
  __call  = objPathpoint.setValue,
}

function pathpoint.new(cell)
  local obj = { ---@class map.pathpoint
    cell = cell, ---@type map.cell
    value = nil, ---@type number
    from  = nil, ---@type map.pathpoint
  }
  return setmetatable(obj, mtPathPt)
end

return pathpoint