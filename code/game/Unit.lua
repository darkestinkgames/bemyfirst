---@class game.Unit
Unit = {}

function Unit:new(name, sprites, hp, ap)

    ---
    ---@class obj.Unit
    ---
    ---@field name string
    ---@field owner obj.Player|nil
    ---@field team 0|1|2|3|4
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
    ---@field move obj.UnitMove
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
    UnitMove:add(unit)
    return unit
end