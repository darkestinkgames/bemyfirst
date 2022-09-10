local impass = 10

---@type data.Tile
Tile = {
    -- -@type grid.Cell[]
    tile = {
        -- наземні тайли

        -- (1)
        {
            -- nazva = 'Фортеця (fortetsia)',
            nazva = 'Фортеця',
            zahyst = 4,
            zem = {pass = 1, lvl = 0},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {50,51,52,53,54,55,56,57,58,59,60,61,62},
        },
        {
            -- nazva = 'Дорога (doroha)',
            nazva = 'Дорога',
            zahyst = 0,
            zem = {pass = 1, lvl = 0},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {64,65,66,67,68,69,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90},
        },
        {
            -- nazva = 'Місток (mistok)',
            nazva = 'Місток',
            zahyst = 0,
            zem = {pass = 1, lvl = 0},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {241,242,243,244},
        },

        -- (2)
        {
            -- nazva = 'Поле (pole)',
            nazva = 'Поле',
            zahyst = 1,
            zem = {pass = 2, lvl = 0},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {1,2},
        },
        {
            -- nazva = 'Узбережжя (uzberezhia)',
            nazva = 'Узбережжя',
            zahyst = 0,
            zem = {pass = 2, lvl = 0},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
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
                211,212,213,214,215,216},
        },

        -- (3)
        {
            -- nazva = 'Пагорби (pahorby)',
            nazva = 'Пагорби',
            zahyst = 1,
            zem = {pass = 3, lvl = 0},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {14},
        },
        {
            -- nazva = 'Ліси (lisy)',
            nazva = 'Ліси',
            zahyst = 3,
            zem = {pass = 3, lvl = 0},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {5,6,7},
        },

        -- (4)
        {
            -- nazva = 'Гори (hory)',
            nazva = 'Гори',
            zahyst = 4,
            zem = {pass = 4, lvl = 1},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {11,12,13},
        },
        {
            -- nazva = 'Річка (richka)',
            nazva = 'Річка',
            zahyst = 0,
            zem = {pass = 4, lvl = 1},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {92,93,94,95,96,99,100,101,102,103,106,107,108},
        },
        {
            -- nazva = 'Золота руда (zolota ruda)',
            nazva = 'Золота руда',
            zahyst = 2,
            zem = {pass = 4, lvl = 1},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {210},
        },
        {
            -- nazva = 'Залізна руда (zalizna ruda)',
            nazva = 'Залізна руда',
            zahyst = 2,
            zem = {pass = 4, lvl = 1},
            vod = {pass = impass, lvl = impass},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {203},
        },

        -- наводні тайли

        -- 1
        {
            -- nazva = 'Море (more)',
            nazva = 'Море',
            zahyst = 0,
            zem = {pass = impass, lvl = impass},
            vod = {pass = 1, lvl = 0},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {169,170,171,172},
        },
        
        -- 2
        {
            -- nazva = 'Рифи (ryfy)',
            nazva = 'Рифи',
            zahyst = 0,
            zem = {pass = impass, lvl = impass},
            vod = {pass = 2, lvl = 1},
            pov = {pass = 1, lvl = 0},
            vartist = {},
            spritecodes = {239,240},
        },
    },
    spritecode = {},
}


function Tile:getTile(scode)
    local value = self.spritecode[scode]
    if not value then
        return nil
    end
    value = self.tile[value]
    -- print('Tile', scode, value)
    return (value)
end

do
    for tile_key, tile_data in ipairs(Tile.tile) do
        for key, sprite_code in ipairs(tile_data.spritecodes) do
            Tile.spritecode[sprite_code] = tile_key
            tile_data.spritecodes[key] = nil
            -- print(tile_key, id)
        end
        tile_data.spritecodes = nil
    end
end

-- for key, value in pairs(Tile) do
--     print('>', Tile, key, value)
-- end

---Чарунка карти
---@class grid.Cell
---@field nazva string
---@field zahyst number
---@field zem Cell.vhid
---@field vod Cell.vhid
---@field pov Cell.vhid
---@field vartist table
---@field spritecodes table

-- 
---@class Cell.vhid
---@field pass Cell.pass
---@field lvl Cell.lvl

-- 
---@alias Cell.lvl
---| 0 Місцевість звичайного рівня прохідності
---| 1 Місцевість ускладненого рівня прохідності

-- 
---@alias Cell.pass 1|2|3|4

for key, value in pairs(Tile.tile) do
end