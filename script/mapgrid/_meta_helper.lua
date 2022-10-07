---@meta

---@class _map.cell
local cell = {
  key     = nil, ---@type string
  x       = nil, ---@type number
  y       = nil, ---@type number
  sprites = nil, ---@type any[]
  screenX = nil, ---@type number
  screenY = nil, ---@type number
  scale   = nil, ---@type number
  tile    = nil, ---@type _map.tile
  nearest = nil, ---@type _map.cell[]
  strc    = nil, ---@type _map.strc?
  unit    = nil, ---@type _map.unit?
  draw              = nil, ---@type function
  getPositionGrid   = nil, ---@type function
  getPositionScreen = nil, ---@type function
  getStrc           = nil, ---@type function
  getUnit           = nil, ---@type function
  -- new               = nil, ---@type fun(spritelist: number[], x:number, y:number):_map.cell
  setStrc           = nil, ---@type function
  setUnit           = nil, ---@type fun(unit: _map.unit)
}

---@class _map.strc
local strc = {
}

---@class _map.unit
local unit = {
}

---@class _map.pathpoint
local pathpoint = {
  cell  = nil, ---@type any
  value = nil, ---@type any
  from  = nil, ---@type any
  initValue = nil, ---@type function
}

----- { - } -----

-- типи місцевості та хто їх може проходити (з рівнемо входження)
---@alias _map.tile
---|"beach" # наземні (ускладнений) та деякі наводні
---|"dock"  # усі
---|"mtns"  # лише деякі наземні (найскладніший)
---|"plain" # усі наземни (ускладнений)
---|"reefs" # усі наводні (дуже складний)
---|"river" # деякі наземні (найскладніший)
---|"road"  # усі наземні
---|"sea"   # усі наводні
---|"woods" # усі наземні (дуже ускладнений)