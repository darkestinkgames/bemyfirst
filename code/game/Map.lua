---Клас створює та зберігає об’єкти карти
---@class game.Map
---@overload fun(x: number|string, y?:number): objCell
Map = {
    ---@type string[]
    files = {
        'code/map/1',
    },

    nrst = {
        0, -1,
        -1, 0,
        1, 0,
        0, 1,
    },

    ---@type table<string, objCell>
    cell_grid = {},

    ---@type obj.Build[]
    build_list = {},

    ---@type obj.Unit[]
    unit_list = {},

    player = {},
}

-- дані для камери
function Map:getScreenRect()
    -- return self.screenrect.x_min, self.screenrect.x_max, self.screenrect.y_min, self.screenrect.y_max
    return self.screen_width, self.screen_height
end

-- рамка відображення на екрані
function Map:initScreenRect()
    local screenrect = newScreenRect()
    for key, cell in pairs(self.cell_grid) do
        screenrect.x_max = math.max(
            screenrect.x_max,
            cell.screen.x + Sprite[cell.sprites[1]]:getWidth()
        )
        screenrect.y_max = math.max(
            screenrect.y_max,
            cell.screen.y + Sprite[cell.sprites[1]]:getHeight()
        )
    end
    self.screen_width = Limits:new(screenrect.x_min, screenrect.x_max)
    self.screen_height = Limits:new(screenrect.y_min, screenrect.y_max)
end

---Завантажити карту
---@param filename number | string # номер карти за списку, або шлях до файлу
function Map:load(filename)
    local data_input = require( type(filename) == "number" and self.files[filename] or filename )
    local width = data_input.width

    for key in pairs(self.cell_grid) do
        self.cell_grid[key] = nil
    end

    for i = 1, #data_input.layers[1].data do
        local x = (i - 1) % width + 1
        local y = math.floor((i - 1) / width + 1)

        local sprites = {}
        for f = 1, #data_input.layers do
            table.insert(sprites, data_input.layers[f].data[i])
        end

        Cell:new(sprites, x, y, self.cell_grid)
    end

    self:initScreenRect()
end

-- відображати карту
function Map:draw()
    -- чарунки
    for _, cell in pairs(self.cell_grid) do
        cell:draw()
    end

    -- будівлі
    for _, build in pairs(self.build_list) do
        build:draw()
    end
    
    -- юніти
    for _, unit in pairs(self.unit_list) do
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
        if type(x) == "string" then
            return self.cell_grid[x]
        end
        if type(x) == "number" then
            return self.cell_grid[getKey(x,y)]
        end
    end
})