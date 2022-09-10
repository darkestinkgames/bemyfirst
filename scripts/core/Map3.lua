-- -@class Map<a>: { files: table, nearest: table, load: function, draw: function, [string]: a }



---@type game.Map
Map3 = {
    files = {
        'map/1/1',
    },
    nrst = {
        0, -1,
        -1, 0,
        1, 0,
        0, 1,
    },
    cell = {},
}

function Map:get(x, y)
    return self.cell[getKey(x, y)]
end
        
function Map:draw()
    love.graphics.setColor(1, 1, 1)
    for key, cell in pairs(self.cell) do
        love.graphics.draw(cell.image, cell.screen())
    end
end

function Map:load(filename)
    filename = type(filename) == "number" and self.files[filename] or filename
    local data_input = require(filename)
    local width = data_input.width

    for key in pairs(self.cell) do
        self.cell[key] = nil
    end
    
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
end

-- test
Map:load(1)