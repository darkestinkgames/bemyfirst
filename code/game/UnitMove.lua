---@class game.UnitMove
UnitMove = {}

-- Створюю та одразу додаю
function UnitMove:add(unit, typ, lvl, pass, value, cd)

    ---
    ---@class obj.UnitMove
    ---@field id string
    ---@field typ 'zem'|'vod'|'pov' # якщо будуть амфібії, додам окрему дію на зміну пересування (чи зберу всі дії до окремого контейнеру), хоча може й треба було б робити
    ---@field lvl 1|2
    ---@field pass 0|1|2|3
    ---@field value number
    ---@field path table
    ---@field ui table
    ---@field cd number|nil
    ---@field delay number|nil
    ---
    ---@field getCost fun(self: obj.UnitMove, cell: obj.Cell)
    ---@field pathUpdate fun(self: obj.UnitMove)
    ---@field uiUpdate fun(self: obj.UnitMove, key?: string)
    local move = {
        id = typ .. 'lvl' .. 'pass',
        typ = typ,
        lvl = lvl,
        pass = pass,
        value = value,
        path = {},
        ui = {},
    }
end