local cell = {}


---- { - } ----

---@class map.cell
local objCell = {scale = 1}

function objCell:getPositionGrid() end
function objCell:getPositionScreen() end
function objCell:getStrc() end
function objCell:getUnit() end

function objCell:setUnit(unit)
  self.unit = unit
end

function objCell:draw()
end

function objCell:initScreen(tile_w, tile_h)
  tile_h = tile_h or tile_w
  self.screen_x = (self.grid_x - 1) * tile_w
  self.screen_y = (self.grid_y - 1) * tile_h
  return self
end

local mtCell = {__index = objCell}

---- { - } ----

---@param tile map.tile
---@param x number
---@param y number
---@return map.cell
function cell.new(tile, x,y)
  ---@class map.cell
  local obj = {
    key = ('x%sy%s'):format(x, y),
    grid_x = x,
    grid_y = y,
    screen_x = x,
    screen_y = y,
  }
  return setmetatable(obj, mtCell)
end

return cell

---- { - } ----

-- типи місцевості та хто їх може проходити (з рівнемо входження)
---@alias map.tile
---|"beach" # наземні (ускладнений) та деякі наводні
---|"dock"  # усі
---|"mtns"  # лише деякі наземні (найскладніший)
---|"plain" # усі наземни (ускладнений)
---|"reefs" # усі наводні (дуже складний)
---|"river" # деякі наземні (найскладніший)
---|"road"  # усі наземні
---|"sea"   # усі наводні
---|"woods" # усі наземні (дуже ускладнений)