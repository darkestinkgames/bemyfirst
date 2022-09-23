require('test/mainreset')

function love.load(...)
end
function love.draw()
    Camera2:draw(Test2)
end
function love.update(dt)
    Camera2:update(dt)
end
function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end

    local add = KeyCtrl2[key]
    if add then
        Camera2.x.value = Camera2.x.value + Step2 * add.x
        Camera2.y.value = Camera2.y.value + Step2 * add.y
    end
end

-- -- -- -- -- [ test ] -- -- -- -- --

---
---@param ... number
---@return tool.Limiter
function newLimiter(...)
    ---@class tool.Limiter
    ---@field min number
    ---@field max number
    local obj = {}

    local input = {...}
    if #input == 0 then
        input[1] = 1
    end
    if #input == 1 then
        input[2] = 0
    end

    table.sort(input)

    obj.min = input[1]
    obj.max = input[#input]

    function obj:mid()
        return (self.min + self.max) / 2
    end

    function obj:delta(value)
        if value then
            self.max = self.min + value
        end
        return self.max - self.min
    end

    return obj
end

---
---@param value number
---@param max? number
---@param min? number
---@return tool.Value
function newValue(value, max, min)
    ---@class tool.Value : tool.Limiter
    local obj = newLimiter(value, max, min)
    obj.value = value
    return obj
end

---
---@param value number
---@param max? number
---@param min? number
---@return tool.CamValue
function newCamValue(value, max, min)
    ---@class tool.CamValue : tool.Value
    local obj = newValue(value, max, min)
    obj.push = value
    return obj
end


math.randomseed( os.time() )

Step2 = 50

KeyCtrl2 = {
    a = {x = -1, y = 0},
    d = {x = 1, y = 0},
    w = {x = 0, y = -1},
    s = {x = 0, y = 1},
}

-- ---@class g.Cam
-- Camera2 = {
--     x.value =y.value 0,
--     x_min = 0,
--     x_push = 0,
--     x_max = 0,
--     x_mid = love.graphics.getWidth() / 2,

--     y_value = 0,
--     y_min = 0,
--     y_push = 0,
--     y_max = 0,
--     y_mid = love.graphics.getHeight() / 2,

--     timer_pos = -1,

--     scale_value = 1,
--     scale_min = 1,
--     scale_push = 1,
--     scale_max = 5,

--     timer_scale = -1,
-- }

---@class g.Cam
Camera2 = {
    x = newCamValue(0, love.graphics.getWidth()),
    y = newCamValue(0, love.graphics.getHeight()),

    scale = newCamValue(1, 5, 1),

    timer_pos = -1,
    timer_scale = -1,
}

function Camera2:draw(obj)
    love.graphics.push()
    love.graphics.translate(self.x.value, self.y.value)
    love.graphics.scale(self.scale.value, self.scale.value)

    obj:draw()

    love.graphics.setColor(0,1,0)
    love.graphics.circle("line", 0, 0 , 6,20)

    love.graphics.setColor(1,0,0)
    love.graphics.circle("line", -self.x.min, -self.y.min , 4, 20)

    love.graphics.pop()

    love.graphics.line(self.x:mid(), 0, self.x:mid(), self.y:mid() * 2)
    love.graphics.line(0, self.y:mid(), self.x:mid() * 2, self.y:mid())
end

function Camera2:update(dt)
    if self.timer_pos >= 0 then
        if dt > self.timer_pos then
            self.x.value = self.x.push
            self.y.value = self.y.push
        else
            local k = dt / self.timer_pos
            self.x.value = (self.x.push - self.x.value) * k + self.x.value
            self.y.value = (self.y.push - self.y.value) * k + self.y.value
        end
        self.timer_pos = self.timer_pos - dt
    end
    if self.timer_scale >= 0 then
        if dt > self.timer_scale then
            self.scale.value = self.scale.push
        else
            local k = dt / self.timer_scale
            self.scale.value = (self.scale.push - self.scale.value) * k + self.scale.value
        end
        self.timer_scale = self.timer_scale - dt
    end
end

function Camera2:pushPos(x, y, timer)
    self.timer_pos = timer or 1
    self.x.push = x
    self.y.push = y
end


-- Test2 = {
--     x_min = math.random(Camera2.x_mid) ,
--     y_min = math.random(Camera2.y_mid) ,
--     width = 400,-- math.random(Camera2.x_mid * 3, 200),
--     height = 300,
-- }

Test2 = {
    x = newLimiter(),
    y = newLimiter(),
}
Test2.x.min = math.random(Camera2.x:mid(), 20)
Test2.x:delta(400)
Test2.y.min = math.random(Camera2.y:mid(), 20)
Test2.y:delta(300)

function Test2:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill', self.x.min, self.y.min, self.x:delta(), self.y:delta())
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle('line', self.x.min, self.y.min, self.x:delta(), self.y:delta())
end


do
    Camera2.x.min = Camera2.x:mid() - Test2.x:mid()
    Camera2.y.min = Camera2.y:mid() - Test2.y:mid()

    print('x Test2')
    print(Test2.x.min, Test2.x.max, 'mid' .. Test2.x:mid(), 'w' .. Test2.x:delta())
    print('x Camera2')
    print(Camera2.x.min, Camera2.x.max, 'mid' .. Camera2.x:mid())

    -- Camera2:pushPos( Camera2.x.min, Camera2.y.min )
end



function love.mousepressed(x, y, button, istouch, presses) end
function love.resize(w, h) end
