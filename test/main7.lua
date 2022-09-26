require('test/mainreset')

function love.load(...) end
function love.draw() end
function love.update(dt) end
function love.keypressed(key) if key == 'escape' then love.event.push('quit') end end
function love.mousepressed(x, y, button, istouch, presses) end
function love.wheelmoved( x , y ) end
function love.resize(w, h) end

-- -- -- -- -- [ test ] -- -- -- -- --

CamVals7 = {
    min = 0 ,
    max = 0 ,

    value = 0 ,
    push = 0 ,

    v = 0 , -- збережений коефіцієнт value
    p = 0 , -- збережений коефіцієнт push

    delta = 0 ,

    speed = 200 ,
    timer = 0 ,
    dflt = 0.2 ,
}

-- об’єкт

function CamVals7:new(a, ...) end
function CamVals7:setSeed( _speed ) end
function CamVals7:setTimer( _speed ) end


-- додаткові фічі до об’єкту

function CamVals7:draw( pos ) end
function CamVals7:drawVert( pos ) end
function CamVals7:drawHor( pos ) end

function CamVals7:update( dt ) end
function CamVals7:updateTimer( dt ) end
function CamVals7:updateSpeed( dt ) end

-- function CamVals7:getK( value ) end


-- [!]   решта знущань по об’єкту, як правило, оминають атрибут value   [!] --


-- min

-- нове значення
function CamVals7:setMin( _min )
    if _min == self.min then return end

    if _min > self.max then
        self.min = self.max
        self.max = _min
    else
        self.min = _min
    end

    self.delta = self.max - self.min -- оновити
    self.push = self.delta * self.p + self.min -- оновити
    if self.delta ~= 0 then self.v = self.value / self.delta end -- оновити
end
-- нове значення зі здвигом
function CamVals7:setMinMov( _min )
    if _min == self.min then return end

    local add = _min - self.min

    self.min = self.min + add
    self.max = self.max + add
    self.push = self.push + add

    if self.delta ~= 0 then self.v = self.value / self.delta end -- оновити
end


-- max

-- нове значення
function CamVals7:setMax( _max )
    if _max == self.max then return end

    if self.min > _max then
        self.max = self.min
        self.min = _max
    else
        self.max = _max
    end

    self.delta = self.max - self.min -- оновити
    self.push = self.delta * self.p + self.min -- оновити
    if self.delta ~= 0 then self.v = self.value / self.delta end -- оновити
end
-- нове значення зі здвигом
function CamVals7:setMaxMov( _max )
    if _max == self.max then return end

    local add = _max - self.max

    self.min = self.min + add
    self.max = self.max + add
    self.push = self.push + add

    if self.delta ~= 0 then self.v = self.value / self.delta end -- оновити
end


-- value

-- встановити значення
function CamVals7:setValue( _value )
    if _value == self.v then return end

    self.value = _value

    if self.delta ~= 0 then self.v = self.value / self.delta end -- оновити
end
-- додати значення
function CamVals7:addValue( _add )
    self:setValue(self.value + _add)
end


-- push

-- встановити значення
function CamVals7:setPush( _push )
    if _push == self.push then return end

    self.push = math.max(self.min, math.min(self.max, _push))

    if self.delta ~= 0 then self.p = (self.push - self.min) / self.delta end -- оновити
end
-- додати значення
function CamVals7:addPush( _add )
    self:setPush(self.push + _add)
end


-- v

-- новий коефіцієнт для value та його нове значення за цим коефіцієнтом
function CamVals7:setV( _v )
    if _v == self.v then return end

    self.v = _v

    self.value = self.delta * _v + self.min
end


-- p

-- новий коефіцієнт для push та його нове значення за цим коефіцієнтом
function CamVals7:setP( _p )
    if _p == self.p then return end

    _p = math.max(0, math.min(1, _p))
    self.p = _p

    self.push = self.delta * _p + self.min
end


-- delta

-- нова delta на основі min
function CamVals7:setDeltaMin( _delta )
    if _delta == self.delta then return end

    if 0 > _delta then
        self.delta = math.abs(_delta)
        self.max = self.min
        self.min = self.max - _delta
    else
        self.delta = _delta
        self.max = self.min + _delta
    end

    self.push = self.delta * self.p + self.min -- оновити
    if self.delta ~= 0 then self.v = self.value / self.delta end -- оновити
end
-- нова delta на основі max
function CamVals7:setDeltaMax( _delta )
    if _delta == self.delta then return end

    if 0 > _delta then
        self.delta = math.abs(_delta)
        self.min = self.max
        self.max = self.min + _delta
    else
        self.delta = _delta
        self.min = self.max - _delta
    end

    self.push = self.delta * self.p + self.min -- оновити
    if self.delta ~= 0 then self.v = self.value / self.delta end -- оновити
end
-- нова delta на основі value
function CamVals7:setDeltaValue( _delta ) end
-- нова delta на основі push
function CamVals7:setDeltaPush( _delta ) end


-- 

-- отримати значення
-- function CamVals7:getMin() return self.min end

-- отримати значення
-- function CamVals7:getMax() return self.max end

-- отримати значення
-- function CamVals7:getValue() return self.value end

-- отримати значення
-- function CamVals7:getPush() return self.push end

-- отримати значення
-- function CamVals7:getV( _v ) return self.v end

-- отримати значення
-- function CamVals7:getV( _p ) return self.p end

-- отримати значення
-- function CamVals7:getDelta() return self.delta end


-- -- -- -- -- [ test ] -- -- -- -- --
