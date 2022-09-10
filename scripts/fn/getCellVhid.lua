---comment
---@param unit grid.Unit
---@param cell grid.Cell
---@return Cell.vhid
function getCellVhid(cell, unit)
    return cell[unit.move.typ]
end