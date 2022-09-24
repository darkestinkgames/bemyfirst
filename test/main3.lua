require('test/mainreset')
require('code/fn/printTable')

math.randomseed( os.time() )

function love.draw()
    Camera3:draw(Test3)
end

function love.update(dt)
    local add = {x = 0, y = 0}
    if love.keyboard.isDown("w") then
        add.y = add.y + Step3 * dt
    end
    if love.keyboard.isDown("s") then
        add.y = add.y - Step3 * dt
    end
    if love.keyboard.isDown("a") then
        add.x = add.x + Step3 * dt
    end
    if love.keyboard.isDown("d") then
        add.x = add.x - Step3 * dt
    end
    if add.x ~= 0 or add.y ~= 0 then
        Camera3:pushPos(Camera3.x.push + add.x, Camera3.y.push + add.y, 0)
    end

    Camera3:update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)
    -- Camera3:pushPos(x, y)
    -- print(Camera3.x.value, Camera3.x.push)
end

---@param key love.KeyConstant
function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end
end

function love.resize(w, h) end

-- -- -- -- -- [ test ] -- -- -- -- --

Step3 = 256

-- -- -- -- -- [ test ] -- -- -- -- --

---@class game.Limits3
---@overload fun(...: number): obj.Limits3
Limits3 = {
    obj = {
        __newindex = function (self, key, value)
            -- 
            if key == 'mid' or key == 'min' or key == 'max' then
                local add = value - rawget(self, '_' .. key)
                rawset(self, '_min', self.min + add)
                rawset(self, '_max', self.max + add)
            end
            -- -- 
            -- if key == 'min' or key == 'max' then
            --     rawset(self, '_min', math.min(value, (self._max or value)))
            --     rawset(self, '_max', math.max(value, self.min or value))
            -- end
            -- 
            if key == 'value' then
                rawset(self, '_' .. key, value)
            end
            if key == 'push' then
                value = math.min(math.max(value, self._min), self._max)
                rawset(self, '_' .. key, value)
            end
            -- 
            if key == 'delta' then
                rawset(self, '_max', self.min + value)
            end
        end,
        __index = function (self, key)
            if key == 'min' or key == 'max' or key == 'value' or key == 'push' then
                return rawget(self, '_' .. key)
            end
            if key == 'mid' then
                return (self.min + self.max) / 2
            end
            if key == 'delta' then
                return self.max - self.min
            end
        end ,
        __call = function (self, ...)
            local input = {...}
            if #input == 0 then input[1] = 1 end
            if #input == 1 then input[2] = 0 end
            table.sort(input)
            rawset(self, '_min', input[1])
            rawset(self, '_max', input[#input])
        end
    }
}

-- Limits3.obj2 = {
--     __newindex = function (self, key, value)
--         print('__newindex', key, value)
--         if key == 'test' then
--             rawset(self, '_' .. key, value)
--         end
--     end ,
--     __index = function (self, key, value)
--         print('__index ' .. key)
--         if key == 'test' then
--             return rawget(self, '_' .. key)
--         end
--     end
-- }

-- ---
-- ---@return obj.Limits3
-- function Limits3:test()
--     return setmetatable({}, self.obj2)
-- end

function Limits3:new(...)
    ---@class obj.Limits3
    ---@field min number
    ---@field mid number
    ---@field max number
    ---@field value number
    ---@field push number
    ---@field delta number
    local obj = setmetatable({}, self.obj)
    obj(...)
    return obj
end

function Limits3:delta(value)
    local obj = self:new()
    obj.delta = value
    return obj
end

function Limits3:pos(value)
    local obj = Limits3:delta(value)
    obj.value, obj.push = 0, 0
    return obj
end

setmetatable(Limits3, {__call = Limits3.new})

-- -- -- -- -- [ test ] -- -- -- -- --

Test3 = {
    x = Limits3:delta( 480 ),
    y = Limits3:delta( 320 ),
}

Test3.x.min = math.random(love.graphics.getWidth() / 2)
Test3.y.min = math.random(love.graphics.getHeight() / 2)

print('== Test3 ==', Test3.x.mid, Test3.y.mid)
-- printTable(Test3)

function Test3:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x.min, self.y.min, self.x.delta, self.y.delta)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", self.x.min, self.y.min, self.x.delta, self.y.delta)
    love.graphics.circle("line", self.x.mid, self.y.mid, 8, 20)
    love.graphics.circle("line", self.x.min, self.y.min, 8, 20)
    love.graphics.circle("line", self.x.min, self.y.max, 8, 20)
    love.graphics.circle("line", self.x.max, self.y.min, 8, 20)
    love.graphics.circle("line", self.x.max, self.y.max, 8, 20)
end

-- -- -- -- -- [ test ] -- -- -- -- --

Screen3 = {
    x = Limits3:new(love.graphics.getWidth()),
    y = Limits3:new(love.graphics.getHeight()),
}

-- -- -- -- -- [ test ] -- -- -- -- --

---@class game.Camera3
Camera3 = {
    x = Limits3:pos(love.graphics.getWidth()),
    y = Limits3:pos(love.graphics.getHeight()),
    scale = Limits3(1, 5),
    timer_pos = -1,
    timer_scale = -1,
}
Camera3.scale.value = 1

print('== Camera3 ==', Camera3.x.mid, Camera3.y.mid, 'd' .. Camera3.x.delta, 'd' .. Camera3.y.delta)

function Camera3:draw(obj)
    love.graphics.push()
    love.graphics.translate(self.x.value, self.y.value)
    love.graphics.scale(self.scale.value, self.scale.value)

    obj:draw()

    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("line", 0, 0, 8, 20)
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("line", self.x.min, self.y.min, self.x.delta, self.y.delta)

    love.graphics.pop()

    love.graphics.line(Screen3.x.mid, 0, Screen3.x.mid, Screen3.y.max)
    love.graphics.line(0, Screen3.y.mid, Screen3.x.max, Screen3.y.mid)
end

function Camera3:update(dt)
    if self.timer_pos >= 0 then
        if dt > self.timer_pos then
            self.x.value = self.x.push
            self.y.value = self.y.push
        else
            local k = dt / self.timer_pos
            self.x.value = self.x.value + (self.x.push - self.x.value) * k
            self.y.value = self.y.value + (self.y.push - self.y.value) * k
        end
        self.timer_pos = self.timer_pos - dt
    end
end

function Camera3:pushPos(x, y, timer)
    print('pushPos', x, y)
    self.x.push = x
    self.y.push = y
    self.timer_pos = timer or 0.25
end

-- -- -- -- -- [ test ] -- -- -- -- --

do
    local x = Camera3.x.mid - Test3.x.mid
    local y = Camera3.y.mid - Test3.y.mid

    Camera3.x.delta = math.max(0, (Test3.x.delta - Screen3.x.delta) * Camera3.scale.value)
    Camera3.y.delta = math.max(0, (Test3.y.delta - Screen3.y.delta) * Camera3.scale.value)
    Camera3.x.min = Screen3.x.mid - Test3.x.mid - Camera3.x.delta / 2
    Camera3.y.min = Screen3.y.mid - Test3.y.mid - Camera3.y.delta / 2

    print('[ final ]')
    print(Camera3.x.delta)

    print('->')
    print(x, y)
    -- Camera3.x.min = x
    -- Camera3.y.min = y
    -- Camera3.x.max = Test3.x.max - Camera3.x.delta
    Camera3:pushPos(x, y, 1)
    print('mid Test3', Test3.x.mid, Test3.y.mid)
    print('Camera3 x', Camera3.x.min, Camera3.x.mid, Camera3.x.max, 'd' .. Camera3.x.delta)
end