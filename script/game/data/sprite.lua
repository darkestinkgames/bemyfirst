Game.data.sprite1 = {
    image = {}, ---@type love.Canvas[]
}


function Game.data.sprite:add(filename, width, height)
    -- перевірка
    local image = love.graphics.newImage(filename)
    assert(width)
    height = height or width
    -- тех.дані
    local sw, sh = image:getDimensions()
    -- пройтись по кожному тайлу
    for y = 0, sh - 1, height do
        for x = 0, sw - 1, width do
            -- зробити окремим зображенням
            local sprite = love.graphics.newCanvas(width, height)
            local quad = love.graphics.newQuad(x, y, width, height, sw, sh)
            love.graphics.setCanvas(sprite)
            love.graphics.draw(image, quad, 0, 0)
            love.graphics.setCanvas()
            -- завантажити у загальний список
            table.insert(self.image, sprite)
        end
    end
end


function Game.data.sprite:get(key)
    return self.image[key]
end


function Game.data.sprite:filter(min, mag)
    -- перевірка
    assert(min)
    mag = mag or min
    -- 
    for key, sprite in pairs(self.image) do
        sprite:setFilter(min, mag)
    end
end


function Game.data.sprite:draw(key, x, y)
    if self.image[key] then
        love.graphics.draw(self.image[key], x, y)
    end
end

-- зкорочено

Sprite1 = Game.data.sprite

Sprite:add('sprite/medival16.png', 16)

Sprite:filter("nearest")