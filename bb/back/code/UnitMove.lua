---@class game.UnitMove
UnitMove = {}

---@class objUnitMove
local obj = {}

-- отримати вартість входження
---@param cell obj.Cell
function obj:getCellCost(cell)
    local impass = 15
    -- розрахувати вартість входження, якщо не було
    if not cell.tile.vartist[self.id] then
        -- чи дозволяє рівень входження?
        cell.tile.vartist[self.id] = self.lvl > cell.tile[self.typ].lvl
        -- так: знайти нову вартість
        and math.max(1, cell:getCost(self.typ).cost - self.pass)
        -- ні: то й ні
        or impass
    end
    -- отримати дефолтну вартість
    local vartist = cell.tile.vartist[self.id]
    -- якщо там юніт
    if cell.unit then
        vartist = cell.unit.team == self.owner.team and vartist or impass
    end
    -- 
    return vartist
end

function obj:getCost(key) return self.path[key] end

function obj:pathUpdate() end

UnitMove.obj = {__index = obj}

-- Створюю та додаю
---@param unit objUnit
---@param typ TileCostTyp
---@param lvl number
---@param pass number
---@param value number
---@param cd number
function UnitMove:add(unit, typ, lvl, pass, value, cd)
    ---@class objUnitMove
    local move = {
        id = typ .. 'lvl' .. 'pass', -- ключ до готових значень
        owner = unit, -- 

        typ = typ, --
        lvl = lvl, -- щоб катапульта по річці не їздила і т.ін.
        pass = pass, -- знижує вартість входження
        value = value, -- дальність пересування за хід

        path = {}, ---@type number[] # розрахунки для пошуку шляху
        ui = {}, -- для відображення шляху (4) пункт призначення поза зоною досяжності (3) шлях поза зоною (2) пункт у зоні (1) шлях у зоні
        cd = cd or 1, -- 
        delay = 0, -- 
    }

    unit.move = setmetatable(move, self.obj)
end