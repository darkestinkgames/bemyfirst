---@class obj.CamVals
CamVals = {
    min = 0 ,
    max = 0 ,

    value = 0 ,
    push = 0 ,

    -- v = 0 , -- збережений коефіцієнт value
    p = 0 , -- збережений коефіцієнт push

    delta = 0 ,

    -- наскільки швидко value досягає push
    speed = 1000 , -- px/sec; або ще — за часовий проміжок (гемор з оновленням)
    timer = 0 , -- 0 означає, що хоча б раз об’єкт буде оновлено
    dflt = 0.2 ,
}


-- повертає об’єкт

-- 
function CamVals:new(...)
    ---@type obj.CamVals
    local obj = {}
    for key, value in pairs(self) do
        obj[key] = value
    end

    local input = {...}
    table.sort(input)

    if #input > 0 then
        obj:setMax( input[#input] )
    end
    if #input > 1 then
        obj:setMin( input[1] )
    end

    obj:setV(0)
    obj:setP(0)

    return obj:initSeed()
end
-- 
function CamVals:initSeed( _speed )
    if _speed == self.speed or _speed == 0 then return self end

    self.speed = _speed and math.abs(_speed) or self.speed
    self.timer = nil
    self.update = self.updateSpeedo

    return self
end
-- 
function CamVals:initTimer( _timer )
    if _timer == self.timer then return self end

    self.timer = 0
    self.dflt = _timer and math.abs(_timer) or self.dflt
    self.update = self.updateTimed

    return self
end


-- додаткові фічі до об’єкту

-- демо
function CamVals:drawVert( x )
    if self.delta > 0 then
        love.graphics.setColor(0.75, 0.75, 0.75)
        love.graphics.rectangle("fill", x - 2, self.min, 4, self.delta)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", x - 2, self.min, 4, self.delta)
    end
    love.graphics.setColor(0.4, 0.4, 0.8)
    love.graphics.circle("fill", x, self.value, 8, 20)
    love.graphics.setColor(0.8, 0.8, 1)
    love.graphics.circle("line", x, self.push, 9, 20)
end
-- демо
function CamVals:drawHor( y )
    if self.delta > 0 then
        love.graphics.setColor(0.75, 0.75, 0.75)
        love.graphics.rectangle("fill", self.min, y - 2, self.delta, 4)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", self.min, y - 2, self.delta, 4)
    end
    love.graphics.setColor(0.4, 0.4, 0.8)
    love.graphics.circle("fill", self.value, y, 8, 20)
    love.graphics.setColor(0.8, 0.8, 1)
    love.graphics.circle("line", self.push, y, 9, 20)
end

-- 
function CamVals:update( dt ) end
-- оновлювати value за швидкістю
function CamVals:updateSpeedo( dt )
    if self.value ~= self.push then
        local step = self.speed * dt
        local delta = self.push - self.value
        if step > math.abs(delta) then
            self:setValue( self.push )
        else
            self:addValue( 0 > delta and -step or step )
        end
    end
end
-- оновлювати value за часом
function CamVals:updateTimed( dt )
    if self.timer > 0 then
        if self.value == self.push then
            self.timer = -1
            return
        end
        if dt >= self.timer then
            self:setValue( self.push )
            self.timer = -1
            print(self.timer)
        else
            self:addValue( (self.push - self.value) * (dt / self.timer) )
            self.timer = self.timer - dt
        end
    end
    if self.timer == 0 then
        self:setValue( self.push )
        self.timer = -1
    end
end

-- function CamVals:getK( value ) end


-- [!]   решта знущань по об’єкту, як правило, оминають атрибут value   [!] --
-- [!]    у той час, як push завжди прив’язаний до свого коефіцієнту    [!] --


-- min

-- нове значення
function CamVals:setMin( _min )
    if _min == self.min then return end

    if _min > self.max then
        self.min = self.max
        self.max = _min
    else
        self.min = _min
    end

    self.delta = self.max - self.min -- оновити
    self.push = self.delta * self.p + self.min -- оновити
    -- self:updV()
    -- self:updTimer()
end
-- нове значення зі здвигом
function CamVals:movMin( _min )
    if _min == self.min then return end

    local add = _min - self.min

    self.min = self.min + add
    self.max = self.max + add
    self.push = self.push + add

    -- self:updV()
    -- self:updTimer()
end


-- max

-- нове значення
function CamVals:setMax( _max )
    if _max == self.max then return end

    if self.min > _max then
        self.max = self.min
        self.min = _max
    else
        self.max = _max
    end

    self.delta = self.max - self.min -- оновити
    self.push = self.delta * self.p + self.min -- оновити
    -- self:updV()
    -- self:updTimer()
end
-- нове значення зі здвигом
function CamVals:movMax( _max )
    if _max == self.max then return end

    local add = _max - self.max

    self.min = self.min + add
    self.max = self.max + add
    self.push = self.push + add

    -- self:updV()
    -- self:updTimer()
end


-- value

-- встановити значення
function CamVals:setValue( _value )
    if _value == self.value then return end

    self.value = _value

    -- self:updV()
    -- self:updTimer()
end
-- додати значення
function CamVals:addValue( _add )
    self:setValue(self.value + _add)
end


-- push

-- встановити значення
function CamVals:setPush( _push )
    if _push == self.push then return end

    self.push = math.max(self.min, math.min(self.max, _push))

    if self.delta ~= 0 then self.p = (self.push - self.min) / self.delta end -- оновити
    -- self:updTimer()
end
-- додати значення
function CamVals:addPush( _add )
    self:setPush(self.push + _add)
    -- self:updTimer()
end


-- v

-- новий коефіцієнт для value та його нове значення за цим коефіцієнтом
function CamVals:setV( _v )
    if _v == self.v then return end

    self.v = _v

    self.value = self.delta * _v + self.min
    -- self:updTimer()
end


-- p

-- новий коефіцієнт для push та його нове значення за цим коефіцієнтом
function CamVals:setP( _p )
    if _p == self.p then return end

    self.p = math.max(0, math.min(1, _p))

    self.push = self.delta * _p + self.min
    -- self:updTimer()
end


-- delta

-- нова delta на основі min
function CamVals:setDeltaMin( _delta )
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
    -- self:updV()
    -- self:updTimer()
end
-- нова delta на основі max
function CamVals:setDeltaMax( _delta )
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
    -- self:updV()
    -- self:updTimer()
end
-- нова delta на основі push
function CamVals:setDeltaPush( _delta )
    if _delta == self.delta then return end

    self.delta = math.abs(_delta)
    self.min = self.push - self.delta * self.p
    self.max = self.push + self.delta * (1 - self.p)

    -- self:updV()
    -- self:updTimer()
end
-- нова delta від центру
function CamVals:setDeltaAvrg( _delta ) end

-- -- нова delta на основі value
-- function CamVals:setDeltaValue( _delta )
--     if _delta == self.delta then return end

--     self:updV()

--     self.delta = _delta
--     self.min = self.value - self.delta * self.v
--     self.max = self.value + self.delta * (1 - self.v)

--     self.push = self.delta * self.p + self.min -- оновити
-- end


-- різне

-- середнє арифметичне пікових значень
function CamVals:getAvrg()
    return (self.min + self.max) / 2
end
-- оновлення таймеру (якщо є)
function CamVals:updTimer( _timer )
    if self.timer then
        self.timer = _timer and _timer or self.dflt
    end
end

-- -- оновити коефіцієнт value,
-- -- але покищо вона потрібна лише для setDeltaValue,
-- -- яка навряд чи буде використовуватися, тож...
-- function CamVals:updV()
--     if self.delta ~= 0 then
--         self.v = (self.value - self.min) / self.delta
--     end
-- end


-- 

-- отримати значення
-- function CamVals:getMin() return self.min end

-- отримати значення
-- function CamVals:getMax() return self.max end

-- отримати значення
-- function CamVals:getValue() return self.value end

-- отримати значення
-- function CamVals:getPush() return self.push end

-- отримати значення
-- function CamVals:getV( _v ) return self.v end

-- отримати значення
-- function CamVals:getV( _p ) return self.p end

-- отримати значення
-- function CamVals:getDelta() return self.delta end
