---@class game.Unit
Unit = {
    list = Map.unit,
}

function Unit:new(name, sprites, hp, ap)

    ---
    ---@class objUnit
    ---
    ---@field name string
    ---@field owner obj.Player|nil
    ---@field team number
    ---@field stats obj.UnitStats
    ---@field sprites number[]
    ---
    ---@field hp obj.HP
    ---@field ap obj.AP
    ---@field cost obj.UnitCost
    ---@field turn number
    ---
    ---@field wait obj.UnitRest
    ---@field rest obj.UnitRest
    ---@field def obj.UnitDef
    ---
    ---@field move objUnitMove
    ---@field atk obj.UnitAtk
    ---@field cap obj.UnitCap
    ---
    ---@field draw function
    ---
    local unit = {
        team = 0,
        owner = nil,
        name = name,
        sprites = sprites,
    }
    table.insert(self.list, unit)
end