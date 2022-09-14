---@class game.UnitMove
UnitMove = {
    ---
    ---@class obj.UnitMove
    ---@field id string  # аби щоразу не розраховувати вартість входження, а брати готове значення за ключем
    ---@field typ 'zem'|'vod'|'pov'  # якщо будуть амфібії, додам окрему дію на зміну пересування (чи зберу всі дії до окремого контейнеру), хоча може й треба було б робити
    ---@field lvl 1|2  # пересування 1 рівня — для звичайних тайлів, 2 — гори, ріки, тощо
    ---@field pass 0|1|2|3  # зменшення вартості входження
    ---@field value number  # дальність пересування за хід
    ---@field path table  # (пошук шляху) вартість входження у будь-яку чарунку мапи
    ---@field ui table  # 
    ---@field cd number|nil  # (перезарядка) скільки ходів треба чекати до повторного використання дії
    ---@field delay number|nil  # стан перезарядки (дія доступна, якщо значення менше за 1)
    ---
    -- -@field getCost fun(self: obj.UnitMove, key: string)  #
    -- -@field pathUpdate fun(self: obj.UnitMove)  #
    -- -@field uiUpdate fun(self: obj.UnitMove, key?: string)  #
    obj = {}
}

-- Створюю та одразу додаю
function UnitMove:add(unit, typ, lvl, pass, value, cd)
    ---@type obj.UnitMove
    local move = {
        id = typ .. 'lvl' .. 'pass',
        typ = typ,
        lvl = lvl,
        pass = pass,
        value = value,
        path = {},
        ui = {},
        cd = cd or 1,
        delay = 0,
    }
    unit.move = setmetatable(move, self.obj) -- мав бажання просто скопіювати усі функції, але покищо спробую так
end

---@type obj.UnitMove
local obj = UnitMove.obj

function obj:getCost(key)
    return self.path[key]
end

function obj:pathUpdate()
end