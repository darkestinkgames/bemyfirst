---@class dataMoveType
local obj = {
    beach = nil, ---@type number
    harbour = nil, ---@type number
    mtns = nil, ---@type number
    plain = nil, ---@type number
    reefs = nil, ---@type number
    river = nil, ---@type number
    road = nil, ---@type number
    sea = nil, ---@type number
    woods = nil, ---@type number
}

MoveCost = { ---@type table<string, dataMoveType>

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
        harbour = 1,
        reefs = 2,
    },

    float = {
        beach = 1,
        mtns = 2,
        plain = 1,
        reefs = 2,
        river = 1,
        road = 1,
        sea = 1,
        woods = 2,
    },

}
