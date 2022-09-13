---@class game.Map
-- -@overload fun(x: number|string, y?:number): obj.Cell
---@field load fun(index: number|string)
---@field files string[]
---@field nrst number[]
---@field cell obj.Cell[]
-- -@field build obj.Build[]
---@field unit obj.Unit[]
Map = {
    files = {
        'code/map/1',
    },
    nrst = {
        0, -1,
        -1, 0,
        1, 0,
        0, 1,
    },

    cell = {},
    build = {},
    unit = {},

    player = {},
}

function Map:load(filename)
    local data_input = require( type(filename) == "number" and self.files[filename] or filename )
    local width = data_input.width

    for key in pairs(self.cell) do
        self.cell[key] = nil
    end

    for i = 1, #data_input.layers[1].data do
        local x = (i - 1) % width + 1
        local y = math.floor((i - 1) / width + 1)

        local sprites = {}
        for f = 1, #data_input.layers do
            table.insert(sprites, data_input.layers[f].data[i])
        end

        Cell:new(sprites, x, y, self.cell)
    end
end

-- відображати
function Map:draw()
    -- чарунки
    for _, cell in pairs(self.cell) do
        cell:draw()
    end

    -- будівлі
    for _, build in pairs(self.build) do
        build:draw()
    end
    
    -- юніти
    for _, unit in pairs(self.unit) do
        unit:draw()
    end

    -- курсор
    -- local x,y = love.mouse.getPosition()
    -- x = (x - map_x) / Data.scale_x
    -- y = (y - map_y) / Data.scale_y
    -- x = x - x % Data.tile_w
    -- y = y - y % Data.tile_h
    -- Current_Key = getKey(x / Data.tile_w + 1, y / Data.tile_h + 1)
    -- if Map[Current_Key] then
    --     love.graphics.setColor(1,1,1, 0.5)
    --     love.graphics.rectangle("fill", x, y, Gra.tile.width, Gra.tile.height)
    --     love.graphics.setColor(1,1,1)
    --     -- Sprite(298, x, y)
    --     love.graphics.setColor(0, 0, 0)
    --     love.graphics.print(som.move.path[Current_Key], Map[Current_Key].screen())
    -- end
end

Map = setmetatable(Map, {
    ---@param self game.Map
    ---@param x number|string
    ---@param y? number
    __call = function (self, x, y)
        if type(x) == "number" then
            return self.cell[x]
        end
        if type(x) == "number" then
            return self.cell[getKey(x,y)]
        end
    end
})