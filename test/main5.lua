require('test/mainreset')

require('code/fn/getKey')
require('code/fn/newScreenRect')
require('code/fn/printTable')
-- 
require('code/tool/Limits4')
require('code/tool/Position')
-- 
require('code/game/Data')
require('code/game/Map')
require('code/game/Cell')
require('code/game/Sprite')

-- -- -- -- -- [ test ] -- -- -- -- --

function love.load(...)
    Map:load(1)
    Map:initScreenRect()
    -- 
    testo()
end

function love.draw()
    Camera5:draw(Map)
    -- love.graphics.print(printTable(Camera5))
end

function love.mousepressed(x, y, button, istouch, presses)
    Camera5.push_x.value, Camera5.push_y.value = x, y
    Camera5.timer_pos = 0.5
end

function love.update(dt)
    Camera5:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end

    if key == "w" then
        Camera5.push_y = Camera5.push_y + 128
        print(key, Camera5.push_y)
    end
    if key == "s" then
        Camera5.push_y = Camera5.push_y - 128
        print(key, Camera5.push_y)
    end
    if key == "a" then
        Camera5.push_x = Camera5.push_x + 128
        print(key, Camera5.push_x)
    end
    if key == "d" then
        Camera5.push_x = Camera5.push_x - 128
        print(key, Camera5.push_x)
    end
    Camera5.timer_pos = 0.2
end

-- -- -- -- -- [ test ] -- -- -- -- --

Camera5 = {
    width = Limits:new(love.graphics.getWidth()),
    height = Limits:new(love.graphics.getHeight()),

    x = Limits:newLow(),
    y = Limits:newLow(),
    scale = Limits:newLow(1, 5),

    push_x = 0,
    push_y = 0,
    push_scale = 1,

    timer_pos = 0,
    timer_scale = 0,

    default_pos = 0.25,
    default_scale = 0.25,
}

function Camera5:update(dt)

    if self.timer_pos >= 0 then
        if dt >= self.timer_pos then
            self.x.value = self.push_x
            self.y.value = self.push_y
            self.push_x = self.x.value
            self.push_y = self.y.value
        else
            local k = dt / self.timer_pos
            self.x.value = (self.push_x - self.x.value) * k + self.x.value
            self.y.value = (self.push_y - self.y.value) * k + self.y.value
        end

        self.timer_pos = self.timer_pos - dt

        if self.x.value == self.push_x and self.y.value == self.push_y then
            self.timer_pos = -1
        end

        print(Camera5.x, Camera5.y, Camera5.scale)
    end

    if self.timer_scale >= 0 then
        if dt >= self.timer_scale then
            self.scale.value = self.push_scale
            self.push_scale = self.scale.value
        else
            local k = dt / self.timer_scale
            self.scale.value = (self.push_scale - self.scale.value) * k + self.scale.value
        end

        self.timer_scale = self.timer_scale - dt

        if self.scale.value == self.push_scale then
            self.timer_scale = -1
        end
    end
end

function Camera5:draw(obj)
    love.graphics.push()
    love.graphics.translate(self.x.value, self.y.value)
    love.graphics.scale(self.scale.value, self.scale.value)
    obj:draw()
    love.graphics.pop()
end

function Camera5:onResize()
    local ox, oy = self.width.mid - self.x.mid, self.height.mid - self.x.mid

    self.width.max, self.height.max = love.graphics.getDimensions()
end

-- -- -- -- -- [ test ] -- -- -- -- --

-- Camera5.scale = 2
Camera5.x.max, Camera5.y.max = love.graphics.getDimensions()


function testo()
    Camera5.push_scale = .3
    Camera5.timer_scale = 1

    local width, height = Map:getScreenRect()

    Camera5.x.delta = Camera5.width.delta - width.delta
    Camera5.y.delta = Camera5.height.delta - height.delta

    -- Camera5.push_x.delta = math.max(0, width.delta * Camera5.push_scale.value - Camera5.width.delta)
    -- Camera5.push_y.delta = math.max(0, height.delta * Camera5.push_scale.value - Camera5.height.delta)

    print("- >", Camera5.push_x, width.mid, Camera5.width.mid)
    Camera5.x.mid = Camera5.width.mid - width.mid * Camera5.push_scale
    Camera5.y.mid = Camera5.height.mid - height.mid * Camera5.push_scale
end

