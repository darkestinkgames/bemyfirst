---@class gameDataTile
---@field terraintype 'beach'|'sea'|'mtns'|'plain'|'reefs'|'river'|'road'|'woods'
local obj = {
    nazva = "", -- назва у грі
    terraintype = 'road', -- тип ландшафту для пересування
    defgroundbonus = 0, -- бонус захисту наземним юнітам
    defnavalbonus = 0, -- бонус захисту наводним юнітам
    spritecodes = {}, ---@type number[] які спрайти відображають цей тайл
}

MapaTileData = {
    tiles = { ---@type gameDataTile[]
        {
            nazva = "Дорога (Road)",
            terraintype = "road",
            defgroundbonus = 0,
            defnavalbonus = 0,
            spritecodes = {64,65,66,67,68,69,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90},
        },
        {
            nazva = "Фортеця (Fortress)",
            terraintype = "road",
            defgroundbonus = 4,
            defnavalbonus = 0,
            spritecodes = {50,51,52,53,54,55,56,57,58,59,60,61,62},
        },
        {
            nazva = "Міст (Bridge)",
            terraintype = "road",
            defgroundbonus = 0,
            defnavalbonus = 0,
            spritecodes = {241,242,243,244},
        },
        {
            nazva = "Степ (Plain)",
            terraintype = "plain",
            defgroundbonus = 1,
            defnavalbonus = 0,
            spritecodes = {1,2},
        },
        {
            nazva = "Пляж (Beach)",
            terraintype = "beach",
            defgroundbonus = 0,
            defnavalbonus = 0,
            spritecodes = {
                176,177,178,179,180,181,
                183,
                185,186,
                188,
                190,191,192,193,194,195,
                197,198,199,200,201,202,
                204,
                206,207,
                209,
                211,212,213,214,215,216
            },
        },
        {
            nazva = "Пагорби (Hills)",
            terraintype = "woods",
            defgroundbonus = 1,
            defnavalbonus = 0,
            spritecodes = {14},
        },
        {
            nazva = 'Ліс (Woods)',
            terraintype = 'woods',
            defgroundbonus = 3,
            defnavalbonus = 0,
            spritecodes = {5,6,7},
        },
        {
            nazva = 'Гори (Mountains)',
            terraintype = 'mtns',
            defgroundbonus = 4,
            defnavalbonus = 0,
            spritecodes = {11,12,13},
        },
        {
            nazva = 'Річка (River)',
            terraintype = 'river',
            defgroundbonus = 0,
            defnavalbonus = 0,
            spritecodes = {92,93,94,95,96,99,100,101,102,103,106,107,108},
        },
        {
            nazva = 'Золото (Gold)',
            terraintype = 'mtns',
            defgroundbonus = 2,
            defnavalbonus = 0,
            spritecodes = {210},
        },
        {
            nazva = 'Метал (Metal)',
            terraintype = 'mtns',
            defgroundbonus = 2,
            defnavalbonus = 0,
            spritecodes = {203},
        },
        {
            nazva = 'Море (Sea)',
            terraintype = 'sea',
            defgroundbonus = 0,
            defnavalbonus = 0,
            spritecodes = {169,170,171,172},
        },
        {
            nazva = 'Рифи (Reefs)',
            terraintype = 'reefs',
            defgroundbonus = 0,
            defnavalbonus = 2,
            spritecodes = {239,240},
        },
    },
    spritecodes = {}, ---@type gameDataTile[]
}

for index, tile in ipairs(MapaTileData.tiles) do
    for index2, key in ipairs(tile.spritecodes) do
        MapaTileData.spritecodes[key] = tile
    end
end


return MapaTileData