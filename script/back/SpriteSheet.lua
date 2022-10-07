do -- SpriteSheet
    function loadSheet(self, filename, width, height)
        local img = love.graphics.newImage(filename)
        assert(width)
        height = height or width
    
        local size = {
            width = width,
            height = height,
        }
    
        local sw, sh = img:getDimensions()
    
        local canvas = love.graphics.newCanvas(sw, sh)
        canvas:setFilter("nearest", "nearest")

        love.graphics.setCanvas(canvas)
        love.graphics.draw(img)
        love.graphics.setCanvas()
    
        for y = 0, sh - 1, height do
            for x = 0, sw - 1, width do
                local sprite = {
                    id = nil,
                    canvas = canvas,
                    quad = love.graphics.newQuad(x, y, width, height, sw, sh),
                    size = size,
                }
                table.insert(self.sprite, sprite)
                sprite.id = #self.sprite
            end
        end
    end

    function getSprite(self, id, x, y, ox, oy)
        local from = self.sprite[id]
        assert(from, id .. '/' .. #self)

        local sprite = {
            screen = Position(x, y),
            offset = {
                x = (ox or 0) * from.size.width,
                y = (oy or 0) * from.size.height,
            },
            draw = self.drawSprite,
        }
        for key, value in pairs(from) do
            sprite[key] = value
        end

        return sprite
    end

    function drawSprite(self)
        love.graphics.draw(self.canvas, self.quad, self.screen.x, self.screen.y, 0, 1, 1, self.offset.x, self.offset.y)
    end

    function call(self, value, ...)
        -- print('SpriteSheet', value)
        if type(value) == 'number' then
            -- print(':: return')
            return self:getSprite(value, ...)
        end
        if type(value) == 'string' then
            -- print(':: loaded')
            self:loadSheet(value, ...)
            return nil
        end
    end

    SpriteSheet = {
        sprite = {},
        drawSprite = drawSprite,
        loadSheet = loadSheet,
        getSprite = getSprite,
    }

    setmetatable(SpriteSheet, { __call = call })
end