---@class game.Map : table<string: obj.Cell>
---@field [string] obj.Cell
---@field draw fun(self: game.Map)
---@field load fun(self: game.Map, index: number|string)
---@field nrst number[]
---@field files string[]
---@overload fun(x: number, y:number): obj.Cell
Map = {}

local mt = {
    __index = {
        nrst = {
            0, -1,
            -1, 0,
            1, 0,
            0, 1,
        },
        files = {
            'code/map/1',
        },

        ---@param self game.Map
        ---@param filename string|number
        ---@param width number
        ---@param height number
        load = function (self, filename)
            local data_input = require( type(filename) == "number" and self.files[filename] or filename )
            local width = data_input.width

            for key in pairs(self) do
                self[key] = nil
            end

            for i = 1, #data_input.layers[1].data do
                local x = (i - 1) % width + 1
                local y = math.floor((i - 1) / width + 1)

                local sprites = {}
                for f = 1, #data_input.layers do
                    table.insert(sprites, data_input.layers[f].data[i])
                end
            
                local cell = Cell:new(sprites, x, y)
                self[cell.key] = cell
            end
        end,

        ---@param self obj.Cell[]
        draw = function (self, x, y)
            self:drawCell()
        end,
        drawCell = function (self)
            for key, cell in pairs(self) do
                cell:draw()
            end
        end,
        drawCur = function (self)
            local x,y = love.mouse.getPosition()
            x = (x - map_x) / Data.scale_x
            y = (y - map_y) / Data.scale_y
            x = x - x % Data.tile_w
            y = y - y % Data.tile_h
            Current_Key = getKey(x / Data.tile_w + 1, y / Data.tile_h + 1)
            if Map[Current_Key] then
                love.graphics.setColor(1,1,1, 0.5)
                love.graphics.rectangle("fill", x, y, Gra.tile.width, Gra.tile.height)
                love.graphics.setColor(1,1,1)
                -- Sprite(298, x, y)
                love.graphics.setColor(0, 0, 0)
                love.graphics.print(som.move.path[Current_Key], Map[Current_Key].screen())
            end
        end,
    },

    __call = function (self, x, y)
        return self['x' .. x .. 'y' .. y]
    end,
}

Map = setmetatable(Map, mt)