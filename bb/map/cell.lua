local data = require 'script/map/data'


local function initScreenGrid(sx, sy) -- -> gx, gy
  local w,h = data.getTileSize()
  return math.floor(sx / w + 1), math.floor(sy / h + 1)
end
local function initGridScreen(gx, gy) -- -> sx, sy
  local w,h = data.getTileSize()
  return (gx - 1) * w, (gy - 1) * h
end
local function initKey(gx, gy)
  return ("x%sy%s"):format(gx, gy)
end


---@class map.Cell
local Cell = {}
local mtCell = {__index = Cell}

function Cell:draw()
end
function Cell:getTileSize(kw, kh)
  return data.getTileSize(kw, kh)
end
function Cell:getScreen(ox, oy)
  return self.sx + (ox or 0), self.sy + (oy or 0)
end


local cell = {}

function cell.new(gx, gy, codes)
  ---@class map.Cell
  local obj = {
    key      = initKey(gx, gy),
    gx       = gx,     ---@type number      # координата x чарунки карти
    gy       = gy,     ---@type number      # координата y чарунки карти
    nearest  = {},     ---@type map.Cell[]  # 
    sx       = nil,    ---@type number      # координата x чарунки на екрані
    sy       = nil,    ---@type number      # координата y чарунки на екрані
    tile     = nil,    ----@type map.Tile    # 
    strc     = nil,    ----@type map.Strc?   # 
    unit     = nil,    ----@type map.Unit?   # 
    -- 
    spritecodes  = codes,  ---@type number[]
  }
  obj.sx, obj.sy = initGridScreen(gx, gy)
  return setmetatable(obj, mtCell)
end


return cell