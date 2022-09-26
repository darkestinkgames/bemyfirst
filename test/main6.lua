require('test/mainreset')

require('code/fn/getCopy')
require('code/fn/getKey')
require('code/fn/newScreenRect')
require('code/fn/printTable')
-- 
require('code/tool/Position')
-- 
require('code/game/Data')
require('code/game/Map')
require('code/game/Cell')
require('code/game/Sprite')

-- -- -- -- -- [ test ] -- -- -- -- --

KB_X = 0
KB_Y = 0
STEP6 = 256

function love.draw()
    love.graphics.push()
    love.graphics.translate(KB_X, KB_Y)

    Camera6:draw( Tst6 )
    -- Smuzhka:drawHor(120)

    love.graphics.pop()
end

---@param key love.KeyConstant
function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end

    if key == "a" then KB_X = KB_X + STEP6 end
    if key == "d" then KB_X = KB_X - STEP6 end
    if key == "w" then KB_Y = KB_Y + STEP6 end
    if key == "s" then KB_Y = KB_Y - STEP6 end

end

function love.update(dt)
    if love.keyboard.isDown("left") then Camera6.x:addPush( -STEP6 * dt ) end
    if love.keyboard.isDown("right") then Camera6.x:addPush( STEP6 * dt ) end
    if love.keyboard.isDown("up") then Camera6.y:addPush( -STEP6 * dt ) end
    if love.keyboard.isDown("down") then Camera6.y:addPush( STEP6 * dt ) end

    Camera6:update(dt)
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
function love.resize(w, h) end

function love.wheelmoved( x , y )
    Camera6.scale:addPush(y * 0.5)
    tstRescale()
    -- Smuzhka:setDeltaValue( Smuzhka.delta + y * 10 )
end

-- -- -- -- -- [ test ] -- -- -- -- --

---@class obj.CamVals6
CamVals6 = {
    min = 0 ,
    max = 0 ,
    value = 0 ,
    push = 0 ,
    delta = 0 ,

    speed = 400 ,
}

-- 

function CamVals6:new(a, ...)
    local input = {a, ...}
    table.sort(input)

    ---@type obj.CamVals6
    local obj = getCopy(self)

    if #input > 0 then
        obj.max = input[#input]
    end

    if #input > 1 then
        obj.min = input[1]
        obj.value = obj.min
        obj.push = obj.min
    end

    obj.delta = obj:getDelta()

    return obj
end
function CamVals6:setSpeed( _speed )
    self.speed = _speed == 0 and self.speed or math.abs(_speed)
    return self
end

function CamVals6:update(dt)
    if self.value ~= self.push then
        local step = dt * self.speed
        local val = self.push - self.value
        if step > math.abs(val) then
            self.value = self.push
        else
            local k = step / math.abs(val)
            self:addValue( val * k )
        end
    end
end

function CamVals6:draw(pos, is_vertical)
    pos = pos or 0
    if is_vertical then
        self:drawVer(pos)
    else
        self:drawHor(pos)
    end
end
function CamVals6:drawVer(pos)
    pos = pos or 0
    if self.delta ~= 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle( "fill", pos, self.min, 4, self.delta)
        love.graphics.setColor(0.5, 1, 0.5)
        love.graphics.rectangle( "line", pos, self.min, 4, self.delta)
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle( "fill", pos + 2, self.value, 8, 20)
    love.graphics.setColor(0.5, 1, 0.5)
    love.graphics.circle( "line", pos + 2, self.push, 8, 20)
end
function CamVals6:drawHor(pos)
    pos = pos or 0
    if self.delta ~= 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle( "fill", self.min, pos, self.delta, 4)
        love.graphics.setColor(0.5, 1, 0.5)
        love.graphics.rectangle( "line", self.min, pos, self.delta, 4)
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle( "fill", self.value, pos + 2, 8, 20)
    love.graphics.setColor(0.5, 1, 0.5)
    love.graphics.circle( "line", self.push, pos + 2, 8, 20)
end

-- мінімальне значення

function CamVals6:setMin( _min ) -- нове значення
    if _min == self.min then return end

    local v = (self.value - self.min) / self.delta
    local p = self.value == self.push and v or (self.push - self.min) / self.delta

    if _min > self.max then
        self.min = self.max
        self.max = _min
    else
        self.min = _min
    end

    self.delta = self:getDelta()

    -- self.value = self.delta * v + self.min
    self.push = self.delta * p + self.min
end
function CamVals6:setMinMov( _min ) -- зсув діапазону від мінімального значення
    if _min == self.min then return end

    _min = _min - self.min

    self.min = self.min + _min
    self.max = self.max + _min
    self.push = self.push + _min
end


function CamVals6:setMax( _max )
    if _max == self.max then return end

    -- local v = (self.value - self.min) / self.delta
    -- local p = self.value == self.push and v or (self.push - self.min) / self.delta
    local p = self:getP()

    if self.min > _max then
        self.max = self.min
        self.min = _max
    else
        self.max = _max
    end

    self.delta = self:getDelta()

    -- self.value = self.delta * v + self.min
    self.push = self.delta * p + self.min
end


function CamVals6:setValue( _value )
    if _value == self.value then return end

    self.value = math.min(self.max, math.max(self.min, _value))
end
function CamVals6:addValue( _add )
    self.value = self.value + _add
end


function CamVals6:setV( _k )
    if 0 > _k or _k > 1 then return end

    self.value = self.delta * _k + self.min
end
function CamVals6:getV( _value )
    if self.delta == 0 then
        return 0
    else
        return (_value and _value or self.value - self.min) / self.delta
    end
end


function CamVals6:setPush( _value )
    if _value == self.push then return end

    self.push = math.min(self.max, math.max(self.min, _value))
end
function CamVals6:addPush( _add )
    self.push = math.max(self.min, math.min(self.max, self.push + _add))
end

function CamVals6:setP( _p )
    if 0 > _p or _p > 1 then return end

    self.push = self.delta * _p + self.min
end
function CamVals6:getP( _value )
    if self.delta == 0 then
        return 0
    else
        return (_value and _value or self.push - self.min) / self.delta
    end
end

-- delta

function CamVals6:setDelta( _delta )
    if _delta == self.delta then return end

    local v = self.delta == 0 and 0 or (self.value - self.min) / self.delta
    local p = self.value == self.push and v or (self.push - self.min) / self.delta

    self.delta = _delta
    self.max = self.min + _delta

    -- self.value = self.delta * v + self.min
    self.push = self.delta * p + self.min
end
function CamVals6:setDeltaAvrg( _delta )
    if _delta == self.delta then return end
    if 0 >= _delta then return end

    local a = self:getAvrg()
    local v = (self.value - self.min) / self.delta
    local p = self.value == self.push and v or (self.push - self.min) / self.delta

    self.delta = _delta

    self.min = a - _delta / 2
    self.max = a + _delta / 2

    -- self.value = self.delta * v + self.min
    self.push = self.delta * p + self.min
end
function CamVals6:setDeltaValue( _delta )
    if _delta == self.delta then return end

    if _delta == 0 then
        self.min = self.value
        self.max = self.value
    else
        local v = self:getV()

        self.min = self.value - _delta * v
        self.max = self.value + _delta * (1 - v)
    end

    self.delta = _delta
end
function CamVals6:getDelta()
    return self.max - self.min
end


function CamVals6:setAvrg( _avrg )
    _avrg = _avrg - self:getAvrg()

    self.min = self.min + _avrg
    self.max = self.max + _avrg
    -- self.value = self.value + _avrg
    self:addPush( _avrg )
end
function CamVals6:getAvrg()
    return (self.min + self.max) / 2
end


-- -- -- -- -- [ test ] -- -- -- -- --

Camera6 = {
    x = CamVals6:new(),
    y = CamVals6:new(),
    scale = CamVals6:new(1, 5):setSpeed(5),

    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),

    timer_pos = 0,
    timer_scale = 0,

    default_pos = 0,
    default_scale = 0,
}

function Camera6:update(dt)
    self.x:update(dt)
    self.y:update(dt)
    self.scale:update(dt)
end

function Camera6:draw(obj)
    love.graphics.push()
    love.graphics.translate(self.x.value, self.y.value)
    love.graphics.scale(self.scale.value, self.scale.value)

    love.graphics.rectangle("fill", obj.x, obj.y , obj.width, obj.height)

    love.graphics.pop()

    love.graphics.circle("line", 0, 0, 16, 48)
    self.x:drawHor(self.y.min)
    self.y:drawVer(self.x.min)
end

-- -- -- -- -- [ test ] -- -- -- -- --

Speed = 200
Smuzhka = CamVals6:new(200, 20)

Tst6 = {
    x = 0,
    y = 0,
    width = 480,
    height = 320,
}

-- Camera6.x:setDelta( math.max(0, Tst6.width - Camera6.width) )
-- Camera6.y:setDelta( math.max(0, Tst6.height - Camera6.height) )

-- Camera6.x:setAvrg( (Tst6.width / 2 + Tst6.x) - Camera6.width / 2 )

-- Camera6.x:setMin(-400)
-- Camera6.x:setMax( Camera6.width )
-- Camera6.x:setV(0)

-- Camera6.x:setMin( 0 )

function tstRescale()
    Camera6.x:setDeltaValue( math.max(0, Tst6.width * Camera6.scale.push - Camera6.width) )
    Camera6.y:setDeltaValue( math.max(0, Tst6.height * Camera6.scale.push - Camera6.width) )

    Camera6.x:setAvrg( (Camera6.width / 2) - (Tst6.width / 2 + Tst6.x) * Camera6.scale.push )
    Camera6.y:setAvrg( (Camera6.height / 2) - (Tst6.height / 2 + Tst6.y) * Camera6.scale.push )

    print(Camera6.scale.push, Camera6.x:getAvrg(), Camera6.x.push, Camera6.width)
end

tstRescale()