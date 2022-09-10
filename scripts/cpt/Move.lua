Move = {}




---Створення нового об’єкту
---@param typ unit.Move.typ
---@param lvl cell.Move.lvl
---@param pass cell.Move.pass
---@param value number
---@param cd? number
---@return unit.Move
function Move:new(typ, lvl, pass, value, cd)
    cd = cd or 1
    local cpt = { ---@type unit.Move
        id = typ .. lvl .. pass,
        typ = typ,
        lvl = lvl,
        pass = pass,
        value = value,
        path = {},
        ui = {},
        cd = cd,
        delay = cd > 0 and cd or 0,
    }
    return cpt
end

function Move:pishky(value)
    return self:new('zem', 2, 2, value)
end

function Move:verhy(value)
    return self:new('zem', 1, 1, value)
end

function Move:kolesa(value)
    return self:new('zem', 1, 0, value)
end

-- Move: