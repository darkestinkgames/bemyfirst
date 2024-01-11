-- 
Sprite = {
    frame = {},
}

-- 
function Sprite:load(filename, width, height)
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

    -- self.frame = self.frame or {}
    for y = 0, sh - 1, height do
        for x = 0, sw - 1, width do
            local frame = {
                canvas = canvas,
                quad = love.graphics.newQuad(x, y, width, height, sw, sh),
                size = size,
                -- screen = {x = 0, y = 0, i = 0},
                -- offset = {x = 0, y = 0},
            }
            table.insert(self.frame, frame)
            frame.id = #self.frame
        end
    end
end

-- створити окремий самостійний кадр
function Sprite:getFrame(i, x, y, kx, ky)
    assert(self.frame[i], i .. ' (' .. #self.frame .. ')')
    local from = self.frame[i]
    local frame = {
        screen = {
            x = x or 0,
            y = y or 0,
        },
        offset = {
            x = (kx or 0) * from.size.width,
            y = (ky or 0) * from.size.height,
        },
        draw = self.drawFrame,
    }
    for key, value in pairs(from) do
        frame[key] = value
    end

    return frame
end

-- примірник кадру
function Sprite:draw(i, x, y)
    local frame = self.frame[i]
    assert(frame)

    x = x or 0
    y = y or 0
    -- love.graphics.draw(frame.canvas, frame.quad, x, y, 0, 1, 1, frame.offset.x, frame.offset.y)
    love.graphics.draw(frame.canvas, frame.quad, x, y)
end

-- вкладена функція відображення для кадру
function Sprite:drawFrame()
    love.graphics.draw(self.canvas, self.quad, self.screen.x, self.screen.y, 0, 1, 1, self.offset.x, self.offset.y)
end

-- спрощення визову
function Sprite:call(...)
    local value = {...}
    -- print('Sprite :: call // ' .. type(value[1]))
    if type(value[1]) == 'string' then
        -- print('Sprite :: loading')
        self:load(...)
        return nil
    end
    if type(value[1]) == 'number' then
        -- print('Sprite :: returning')
        return self:getFrame(...)
    end
end

-- 
Sprite = setmetatable(Sprite, {__call = Sprite.call})