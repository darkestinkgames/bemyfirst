---@meta

---@class map.grid
local grid = {
  cell_grid = nil, ---@type table<string, map.cell>
  strc_list = nil, ---@type map.unit[]
  unit_list = nil, ---@type map.unit[]
  width     = nil, ---@type number
  height    = nil, ---@type number
  tilesize  = nil, ---@type number
}

---@param w number
---@param h number
function grid.newMap(w,h) end

---@param spritecodes number[]
---@param x number
---@param y number
function grid.newCell(spritecodes, x,y) end

function grid.newUnit(...) end
function grid.newStrc(...) end
function grid.newPathfinder() end
function grid.reset() end
function grid.draw() end

---@class map.cell
local cell = {
  key     = nil, ---@type string
  x       = nil, ---@type number
  y       = nil, ---@type number
  sprites = nil, ---@type any[]
  screenX = nil, ---@type number
  screenY = nil, ---@type number
  scale   = nil, ---@type number
  tile    = nil, ---@type map.tile
  nearest = nil, ---@type map.cell[]
  strc    = nil, ---@type map.strc?
  unit    = nil, ---@type map.unit?
  draw              = nil, ---@type function
  getPositionGrid   = nil, ---@type function
  getPositionScreen = nil, ---@type function
  getStrc           = nil, ---@type function
  getUnit           = nil, ---@type function
  -- new               = nil, ---@type fun(spritelist: number[], x:number, y:number):map.cell
  setStrc           = nil, ---@type function
  setUnit           = nil, ---@type fun(unit: map.unit)
}

---@class map.strc
local strc = {
}

---@class map.unit
local unit = {
}

---@class map.pathpoint
local pathpoint = {
}

----- { - } -----

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