-- усі прошарки карти знаходяться у головному контейнері
-- DataInput.layers

-- розмір карти можна брати звідти ж
-- DataInput.width
-- DataInput.height
-- або з кожного нашарування окремо
-- DataInput.layers[1].width
-- DataInput.layers[1].height

-- і список усіх тайлів на прошарку зберігається у власному контейнері
-- DataInput.layers[1].data
-- по суті це прямий масив з порядковими номерами

-- тобто в мене є купка однакових тайлів, але розкиданих по різних прошарках
-- отже, мені доведеться вирахувати координату х/у кожного тайлу з кожного нашарування
-- та згрупувати їх по цій координаті в окрему чарунку

local DataInput = require('map/1/1')
local width = DataInput.width


MapCell = setmetatable({}, {
    __index = {
        draw = function (self)
            for _, cell in pairs(self) do
                love.graphics.draw(cell.image, cell.screen())
            end
        end,
    },
    __call = function (self, ...)
        local a = {...}
        local value = a[1]
        if type(value) == 'number' then
            value = getKey(a[1], a[2])
        end
        if type(value) == 'table' then
            self[value.key] = value
            value = value.key
        end
        return self[value]
    end
})

-- прочитати з файлу
for i = 1, #DataInput.layers[1].data do
    local x = (i - 1) % width + 1
    local y = math.floor((i - 1) / width + 1)
    
    -- ключ до чарунки
    local key = getKey(x, y)

    -- інфа про ландшафт
    local data = nil
    
    local image = love.graphics.newCanvas(Gra.tile.width, Gra.tile.height)
    love.graphics.setCanvas(image)
    for f = 1, #DataInput.layers do
        local sprite = DataInput.layers[f].data[i]
        
        if sprite > 0 then
            Sprite(sprite)
        end
        
        data = Tile:getTile(DataInput.layers[f].data[i]) or data
        -- print('MapCell', data.key, data.nazva)
    end
    love.graphics.setCanvas()
    image:setFilter("nearest", "nearest")

    
    local cell = {
        key = key,
        data = data,
        tile = Position(x, y),
        screen = Position((x - 1) * Gra.tile.width, (y - 1) * Gra.tile.height),
        image = image,
        nearest = {},
        -- unit = {},
        -- structure = {},
    }

    MapCell(cell)
    -- print(key, cell.screen())
end

do
    local nearest = {
        0, -1,
        -1, 0,
        1, 0,
        0, 1,
    }
    for key, cell in pairs(MapCell) do
        for i = 1, #nearest, 2 do
            table.insert(cell.nearest, MapCell(cell.tile.x + nearest[i], cell.tile.y + nearest[i + 1]))
        end
    end
end