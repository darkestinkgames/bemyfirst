function getMapCost(unit, cell)
    local impass = 15
    -- TODO проробити в окремий шматок (але це не точно)
    if not cell.data.vartist[unit.move.id] then
        cell.data.vartist[unit.move.id] = unit.move.lvl > cell.data[unit.move.typ].lvl
        and math.max(1, cell.data[unit.move.typ].pass - unit.move.pass)
        or impass
    end
    -- 
    local vartist = cell.data.vartist[unit.move.id]
    if cell.unit then
        vartist = unit.team == cell.unit.team and vartist or impass
    end
    return vartist
end