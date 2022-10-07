local cell = {}


---- { - } ----

---@type map.cell
local objCell = {scale = 1}

function objCell:setUnit(unit)
  self.unit = unit
end

function objCell:draw()
end

local mtCell = {__index = objCell}

---- { - } ----

function cell.setDefaultTilesize(tilesize)
  
end

return cell