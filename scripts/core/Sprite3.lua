-- Sprite:add(filename, width, height) — додати спрайти.
-- 
-- Sprite(id, x, y) — малювати спрайт.
-- 
-- Sprite[id] — отримати спрайт

Sprite = setmetatable({}, {
    __index = {
        add = function (self, filename, width, height)
            local image = love.graphics.newImage(filename)
            assert(width)
            height = height or width
            local sw, sh = image:getDimensions()
            for y = 0, sh - 1, height do
                for x = 0, sw - 1, width do
                    local sprite = love.graphics.newCanvas(width, height)
                    local quad = love.graphics.newQuad(x, y, width, height, sw, sh)
                    love.graphics.setCanvas(sprite)
                    love.graphics.draw(image, quad)
                    love.graphics.setCanvas()
                    table.insert(self, sprite)
                    sprite:setFilter("nearest", "nearest")
                end
            end
        end,
        filter = function (self, value)
            for _, image in ipairs(self) do
                image:setFilter(value, value)
            end
        end,
    },
    __call = function (self, key, x, y)
        if self[key] then
            love.graphics.draw(self[key], x, y)
        end
    end,
})