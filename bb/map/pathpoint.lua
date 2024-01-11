local data = require 'script/map/data'


---@class map.PathPoint
local PathPoint = {
  color   = {1, 1, 1},
  color2  = {.5, .5, .5},
  r       = 4,
  seg     = 20,
}
local mtPathPoint = {__index = PathPoint}

function PathPoint:draw()
end

function PathPoint:draw1()
  love.graphics.setColor(self.color)
  love.graphics.circle("line", self.sx,self.sy, self.r,self.seg)
end

function PathPoint:draw2()
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", self.sx,self.sy, self.r,self.seg)
end

function PathPoint:draw3()
  love.graphics.setColor(self.color2)
  love.graphics.circle("line", self.sx,self.sy, self.r,self.seg)
end

function PathPoint:draw4()
  love.graphics.setColor(self.color2)
  love.graphics.circle("fill", self.sx,self.sy, self.r,self.seg)
end

function PathPoint:set(value, from) ---@type fun(self:map.PathPoint, value:number, from:map.PathPoint):map.Cell?
  if not self.value then self.value = value + 1 end
  if self.value > value then
    self.value = value
    self.from = from
    return self.cell
  end
  return nil
end
mtPathPoint.__call = PathPoint.set

function PathPoint:reset()
  self.value = nil
  self.from = nil
  self.draw = nil
end

function PathPoint:init(value, endpoint)
  if self.value == 0
  then return end
  if self.value > value
  then self.draw = endpoint and self.draw4 or self.draw3
  else self.draw = self.value == value and self.draw4 or self.draw3 end
end


local pathpoint = {}

function pathpoint.new(cell)
  ---@class map.PathPoint
  local obj = {
    cell   = cell,  ---@type map.Cell       #
    value  = nil,   ---@type number         #
    from   = nil,   ---@type map.PathPoint  #
    sx     = nil,   ---@type number         #
    sy     = nil,   ---@type number         #
  }
  obj.sx, obj.sy = cell:getScreen(data.getTileSize(.5, .5))
  return setmetatable(obj, mtPathPoint)
end


return pathpoint