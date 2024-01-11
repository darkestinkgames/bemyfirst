local impass = 15

---@class game.Cell
Cell = {
    list = Map.cell_grid,
    data = {
        ---@type data.Tile[]
        tile = {

            ---Структура тайлу (інфа про ландшафт, на який посилається кожна чарунка мапи)
            ---@class data.Tile
            ---@field nazva string          # назва тайлу (відображається у грі)
            ---@field zahyst number         # бонус до захисту юніта
            ---@field zem obj.TileCost      # ~ по землі
            ---@field vod obj.TileCost      # ~ по воді
            ---@field pov obj.TileCost      # ~ у повітрі
            ---@field vartist table         # готові розрахунки вартості входження для кожного типу пересування
            ---@field spritecodes number[]  # відповідні спрайти, щоб конвертувати з Tiled
            {
                -- nazva = 'Дорога (doroha)',
                nazva = 'Дорога',
                zahyst = 0,

                ---вартість входження
                ---@class obj.TileCost     #
                ---@field lvl 0|1|15       # рівень входження (бо віз не їздить по річці, на приклад)
                ---@field cost 1|2|3|4|15  # вартість входження
                zem = {cost = 1, lvl = 0},
                
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {64,65,66,67,68,69,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90},
            },
            {
                -- nazva = 'Фортеця (fortetsia)',
                nazva = 'Фортеця',
                zahyst = 4,
                zem = {cost = 1, lvl = 0},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {50,51,52,53,54,55,56,57,58,59,60,61,62},
            },
            {
                -- nazva = 'Місток (mistok)',
                nazva = 'Місток',
                zahyst = 0,
                zem = {cost = 1, lvl = 0},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {241,242,243,244},
            },
            {
                -- nazva = 'Поле (pole)',
                nazva = 'Поле',
                zahyst = 1,
                zem = {cost = 2, lvl = 0},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {1,2},
            },
            {
                -- nazva = 'Узбережжя (uzberezhia)',
                nazva = 'Узбережжя',
                zahyst = 0,
                zem = {cost = 2, lvl = 0},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
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
            {
                -- nazva = 'Пагорби (pahorby)',
                nazva = 'Пагорби',
                zahyst = 1,
                zem = {cost = 3, lvl = 0},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {14},
            },
            {
                -- nazva = 'Ліси (lisy)',
                nazva = 'Ліси',
                zahyst = 3,
                zem = {cost = 3, lvl = 0},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {5,6,7},
            },
            {
                -- nazva = 'Гори (hory)',
                nazva = 'Гори',
                zahyst = 4,
                zem = {cost = 4, lvl = 1},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {11,12,13},
            },
            {
                -- nazva = 'Річка (richka)',
                nazva = 'Річка',
                zahyst = 0,
                zem = {cost = 4, lvl = 1},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {92,93,94,95,96,99,100,101,102,103,106,107,108},
            },
            {
                -- nazva = 'Золота руда (zolota ruda)',
                nazva = 'Золота руда',
                zahyst = 2,
                zem = {cost = 4, lvl = 1},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {210},
            },
            {
                -- nazva = 'Залізна руда (zalizna ruda)',
                nazva = 'Залізна руда',
                zahyst = 2,
                zem = {cost = 4, lvl = 1},
                vod = {cost = impass, lvl = impass},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {203},
            },
            {
                -- nazva = 'Море (more)',
                nazva = 'Море',
                zahyst = 0,
                zem = {cost = impass, lvl = impass},
                vod = {cost = 1, lvl = 0},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {169,170,171,172},
            },
            {
                -- nazva = 'Рифи (ryfy)',
                nazva = 'Рифи',
                zahyst = 0,
                zem = {cost = impass, lvl = impass},
                vod = {cost = 2, lvl = 1},
                pov = {cost = 1, lvl = 0},
                vartist = {},
                spritecodes = {239,240},
            },
        },

        ---@type data.Tile[]
        spritecode = {},

        --
        obj = {
            __index = {
                ---@param self objCell
                draw = function (self)
                    for index, sprite in ipairs(self.sprites) do
                        Sprite(sprite, self.screen())
                    end
                end,
                getCost = function (cell, unit)
                    -- local impass = impass
                    if not cell.data.vartist[unit.move.id] then
                        cell.data.vartist[unit.move.id] = unit.move.lvl > cell.data[unit.move.typ].lvl
                        and math.max(1, cell.data[unit.move.typ].pass - unit.move.pass)
                        or impass
                    end
                    local vartist = cell.data.vartist[unit.move.id]
                    if cell.unit then
                        vartist = unit.team == cell.unit.team and vartist or impass
                    end
                    return vartist
                end
            },
        },
    },
}

-- spritecodes
for i, tile in ipairs(Cell.data.tile) do
    for f, index in ipairs(tile.spritecodes) do
        Cell.data.spritecode[index] = tile
    end
end

---
---@param sprites number[]
---@param x number
---@param y number
---@param list objCell[]
function Cell:new(sprites, x, y, list)
    -- -@class objCell
    -- -@field key string
    -- -@field position obj.Position
    -- -@field screen obj.Position
    -- -@field sprites number[]
    -- -@field tile data.Tile
    -- -@field strc table|nil
    -- -@field unit table|nil
    -- -@field nearest objCell[]
    -- -
    -- -@field draw fun(self: objCell)
    -- -@field getCost fun(self: objCell, unit: obj.Unit)

    ---@class objCell
    local cell = {
        key = getKey(x, y),  -- ключ розташування у Map.cell_grid
        position = Position(x, y),  -- х/у на мапі
        
        sprites = sprites,  -- список спрайтів, які відображають цю чарунку
        screen = Position( (x - 1) * Data.tile_w, (y - 1) * Data.tile_h ),  -- х/у на екрані

        tile = self.data.spritecode[sprites[#sprites]],
        build = nil,  ---@type obj.Build|nil
        unit = nil,  ---@type obj.Unit|nil

        nearest = {},  ---@type objCell[] # 
    }

    self.list[cell.key] = setmetatable(cell, self.data.obj)
end







-- ---comment
-- ---@param scode number
-- ---@param x number
-- ---@param y number
-- ---@return objCell
-- function Cell:new(scode, x, y)
--     local tile = self.data.spritecode[scode]
--     assert(tile)
--     ---@type objCell
--     local obj = {
--         key = 'x' .. x .. 'y' .. y,
--         image = {},
--         tile = tile,
--         position = Position()
--     }
--     return obj
-- end


---@class objCell
local obj = {}

---
function obj:draw()
    for _, sprite in ipairs(self.sprites) do
        Sprite(sprite, self.position())
    end
end

-- 
---@param typ TileCostTyp
---@return obj.TileCost
function obj:getCost(typ)
    -- assert(typ == 'zem' or typ == 'vod' or typ == 'pov')
    return self.tile[typ]
end

Cell.obj = obj

-- види пересування
---@alias TileCostTyp
---|'zem' # по землі
---|'vod' # по воді
---|'pov' # у повітрі