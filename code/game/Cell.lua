local impass = 10

---@class game.Cell
Cell = {
    data = {
        ---@type data.Tile[]
        tile = {

            ---@class data.Tile             #
            ---@field nazva string          #
            ---@field zahyst number         #
            ---@field zem obj.TileCost      #
            ---@field vod obj.TileCost      #
            ---@field pov obj.TileCost      #
            ---@field vartist table         #
            ---@field spritecodes number[]  #
            {
                -- nazva = 'Дорога (doroha)',
                nazva = 'Дорога',
                zahyst = 0,
                
                ---@class obj.TileCost     #
                ---@field lvl 0|1|10       # 
                ---@field cost 1|2|3|4|10  # 
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
                ---@param self obj.Cell
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
---@param list obj.Cell[]
---@return obj.Cell
function Cell:new(sprites, x, y, list)
    ---@class obj.Cell
    ---@field key string
    ---@field position obj.Position
    ---@field screen obj.Position
    ---@field sprites number[]
    ---@field tile data.Tile
    ---@field strc table|nil
    ---@field unit table|nil
    ---@field nearest obj.Cell[]
    ---
    ---@field draw fun(self: obj.Cell)
    ---@field getCost fun(self: obj.Cell, unit: obj.Unit)
    local obj = {
        key = getKey(x, y),
        position = Position(x, y),
        screen = Position( (x - 1) * Data.tile_w, (y - 1) * Data.tile_h ),
        -- screen = Position(x * Data.tile_w, y * Data.tile_h),
        sprites = sprites,
        tile = self.data.spritecode[sprites[#sprites]],
        nearest = {},
    }
    list[obj.key] = setmetatable(obj, self.data.obj)
end






-- ---comment
-- ---@param scode number
-- ---@param x number
-- ---@param y number
-- ---@return obj.Cell
-- function Cell:new(scode, x, y)
--     local tile = self.data.spritecode[scode]
--     assert(tile)
--     ---@type obj.Cell
--     local obj = {
--         key = 'x' .. x .. 'y' .. y,
--         image = {},
--         tile = tile,
--         position = Position()
--     }
--     return obj
-- end


