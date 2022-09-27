require('test/mainreset')

-- -- -- -- -- [ test ] -- -- -- -- --

KB_X = 0
KB_Y = 0
STEP6 = 128

function love.draw()
    love.graphics.push()
    love.graphics.translate(KB_X, KB_Y)

    Camera6a:draw()

    love.graphics.pop()
end

---@param key love.KeyConstant
function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end

    if key == "a" then KB_X = KB_X + STEP6 end
    if key == "d" then KB_X = KB_X - STEP6 end
    if key == "w" then KB_Y = KB_Y + STEP6 end
    if key == "s" then KB_Y = KB_Y - STEP6 end
    if key == "kp0" then KB_X = 0 KB_Y = 0 end

end

function love.update(dt)
    if love.keyboard.isDown("left") then Camera6a.x:add( -STEP6 * dt ) end
    if love.keyboard.isDown("right") then Camera6a.x:add( STEP6 * dt ) end
    if love.keyboard.isDown("up") then Camera6a.y:add( -STEP6 * dt ) end
    if love.keyboard.isDown("down") then Camera6a.y:add( STEP6 * dt ) end

    Camera6a:update(dt)
    -- Smuzhka:update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)
    -- if love.keyboard.isDown("lalt") then
    --     if button == 1 then Smuzhka:setMin(x) end
    --     if button == 2 then Smuzhka:setMax(x) end
    -- else
    --     if button == 1 then Smuzhka:setPush(x) end
    --     if button == 2 then Smuzhka:setValue(x) end
    -- end
end

function love.load(...) end
function love.resize(w, h)
    Camera6a.width, Camera6a.height = love.graphics.getDimensions(
        resize()
    )
end

function love.wheelmoved( x , y )
    Camera6a.scale:add(y * 0.5)
    resize()
    -- Smuzhka:setDeltaValue( Smuzhka.delta + y * 10 )
end

-- -- -- -- -- [ test ] -- -- -- -- --

Speed = 200

Tst6 = {
    x = 50,
    y = 70,
    width = 400,
    height = 300,
    draw = function (self)
        love.graphics.setColor(0.2 , 0.2 , 0.5)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        love.graphics.setColor(1 , 1 , 1)
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        love.graphics.circle("line", self.x, self.y + self.height, 8, 32)
        love.graphics.circle("line", self.x + self.width, self.y, 8, 32)
    end
}

-- -- -- -- -- [ test ] -- -- -- -- --

---@param self CamVal6a
local function valUpdate(self, dt)
    if self.push > self.max then
        self.push = self.max
    end
    if self.min > self.push then
        self.push = self.min
    end

    if self.value ~= self.push then
        print(self.min .. " < " .. self.push .. " > " .. self.max)

        local delta = self.push - self.value
        local step = dt * self.step

        if step >= math.abs(delta) then
            self.value = self.push
        else
            self.value = self.value + (0 > delta and -step or step)
        end
    end
end

---@param self CamVal6a
local function valGetDelta(self)
    return self.max - self.min
end

---@param self CamVal6a
local function valAdd(self, _add, _timer)
    self.push = self.push + _add
    -- self.dt = _timer or Camera6a.time
end

-- -- -- -- -- [ test ] -- -- -- -- --

Camera6a = {
    frame = Tst6,

    ---@class CamVal6a
    x = {
        value = 0,
        push = 0,
        min = 0,
        max = 0,
        step = 100,
        update = valUpdate,
        getDelta = valGetDelta,
        add = valAdd,
    },

    ---@type CamVal6a
    y = {
        value = 0,
        push = 0,
        min = 0,
        max = 0,
        step = 100,
        update = valUpdate,
        getDelta = valGetDelta,
        add = valAdd,
    },

    ---@type CamVal6a
    scale = {
        value = 1,
        push = 1,
        min = 1,
        max = 5,
        step = 10,
        update = valUpdate,
        getDelta = valGetDelta,
        add = valAdd,
    },

    time = 0.2,

    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
}

function Camera6a:draw()
    love.graphics.push()
    love.graphics.translate(self.x.value, self.y.value)
    love.graphics.scale(self.scale.value, self.scale.value)

    love.graphics.setColor(1 , 1 , 1)
    love.graphics.circle("line", 0, 0, 8, 32)

    self.frame:draw()

    love.graphics.pop()


    -- love.graphics.push()
    -- love.graphics.scale(self.scale.value, self.scale.value)

    love.graphics.setColor(1 , 1 , 1)
    love.graphics.circle("fill", self.x.push, self.y.push, 8, 32)
    love.graphics.rectangle("line", self.x.min - 1, self.y.min - 1, (self.x.max - self.x.min) + 2, (self.y.max - self.y.min) + 2)

    love.graphics.setColor(0.4 , 1 , 0.4)
    love.graphics.rectangle("line", 0, 0, Camera6a.width, Camera6a.height)

    -- love.graphics.pop()
end

function Camera6a:update(dt)
    self.x:update(dt)
    self.y:update(dt)
    self.scale:update(dt)
end

-- -- -- -- -- [ test ] -- -- -- -- --

-- Camera6a.scale.push = 2

function resize()
    local w, h = Camera6a.frame.width * Camera6a.scale.value, Camera6a.frame.height * Camera6a.scale.value
    local x, y = Camera6a.frame.x * Camera6a.scale.value, Camera6a.frame.y * Camera6a.scale.value
    
    Camera6a.x.min = math.min(Camera6a.width - (w + x), (Camera6a.width - w) / 2 - x)
    Camera6a.y.min = math.min(Camera6a.height - (h + y), (Camera6a.height - h) / 2 - y)
    
    Camera6a.x.max = math.max(-x, Camera6a.x.min)
    Camera6a.y.max = math.max(-y, Camera6a.y.min)
end
resize()

print(Camera6a.x.min, Camera6a.y.min)

-- -- -- -- -- [ test ] -- -- -- -- --
