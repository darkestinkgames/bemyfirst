---@type table<string, cpt.MoveType>
MoveCost = {

    ---@class cpt.MoveType
    infantry = {
        beach = 1,
        mtns = 2,
        plain = 1,
        river = 2,
        road = 1,
        woods = 1,
    },

    cavlry = {
        beach = 1,
        plain = 1,
        road = 1,
        woods = 2,
    },

    wheels = {
        beach = 2,
        plain = 2,
        road = 1,
        woods = 3,
    },

    boat = {
        beach = 1,
        deep = 1,
        reefs = 2,
    },
}

