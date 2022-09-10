-- -@class Map<a>: { files: table, nearest: table, load: function, draw: function, [string]: a }

---Чарунка карти
---@class Map.cell
---@field key string # ключ карти
---@field image love.Canvas # зображення тайла
---@field data table # ландшафт
---@field position cpt.Position # координати карти
---@field screen cpt.Position # координати екрану
---@field nearest table # дотичні чарунки

---@class obj.Map
---@field files string[]
---@field nrst number[]
---@field load fun(self: obj.Map, filename: string|number)
---@field draw fun(self: obj.Map)
---@field [string] Map.cell

Map = setmetatable({}, {
    __index = {
        files = {
            'map/1/1',
        },
        nrst = {
            0, -1,
            -1, 0,
            1, 0,
            0, 1,
        },
        load = function (self, filename)
            filename = type(filename) == "number" and self.files[filename] or filename
            local data_input = require(filename)
            local width = data_input.width

            for i = 1, #data_input.layers[1].data do
                local x = (i - 1) % width + 1
                local y = math.floor((i - 1) / width + 1)
                
                local data = nil
                local image = love.graphics.newCanvas(Gra.tile.width, Gra.tile.height)
                love.graphics.setCanvas(image)
                for f = 1, #data_input.layers do
                    local sprite = data_input.layers[f].data[i]
                    Sprite(sprite)
                    data = Tile:getTile(sprite) or data
                end
                love.graphics.setCanvas()
                image:setFilter("nearest", "nearest")

                local key = getKey(x, y)
                
                self[key] = {
                    key = key,
                    image = image,
                    data = data,
                    position = Position(x, y),
                    screen = Position((x - 1) * Gra.tile.width, (y - 1) * Gra.tile.height),
                    nearest = {},
                }
            end

            for key, cell in pairs(self) do
                for i = 1, #self.nrst, 2 do
                    table.insert(cell.nearest, self(cell.position.x + self.nrst[i], cell.position.y + self.nrst[i + 1]))
                end
            end
        end,
        draw = function (self)
            love.graphics.setColor(1, 1, 1)
            for key, cell in pairs(self) do
                love.graphics.draw(cell.image, cell.screen())
            end
        end,
    },
    __call = function (self, x, y)
        return self[getKey(x, y)]
    end,
})

Map:load(1)