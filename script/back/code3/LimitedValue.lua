-- максимально простий клас, щоб ганяти певне значення у заданих рамках
-- * дельта піків може дорівнювати нулю
---@class test.LimitedValue
LimitedValue = {
    min = 0,
    max = 0,
    avrg = 0,

    value = 0, -- валя тягнеться до паші за певний часовий проміжок
    push = 0, -- за звичайних умов паша відсутній

    dt = 0, -- тікає лише коли є паша
    timer = 0.4, -- дефолтний часовий проміжок
}


-- новий я
---@param ... number
---@return test.LimitedValue
function LimitedValue:new(...)

    ---@type test.LimitedValue
    local obj = {}
    for key, value in pairs(self) do obj[key] = value end

    obj.push = nil
    obj.dt = -1

    local input = {...}
    table.sort(input)

    if #input > 0 then obj.max = input[#input] end
    if #input > 1 then obj.min = input[1] end
    obj:verify()

    return obj
end


-- оновлення валі, коли є паша
---@param dt number
function LimitedValue:update(dt)
    if self.push then

        if self.value == self.push then
            self.push = nil
            self.dt = -1
            return
        end

        if self.dt == -1 then
            self.dt = self.timer
        end

        if dt >= self.dt or self.dt == 0 then
            self.value = self.push
        else
            local delta = self.push - self.value
            local k = dt / self.dt
            self.value = self.value + delta * k
        end

        self.dt = self.dt - dt

        -- print(self.dt, self.push)
    end
end


-- відобразити вертиальною смужкою по осі **x** (для тестування)
---@param x number
function LimitedValue:demoDrawVertical(x)
    love.graphics.line(x, self.min, x, self.max)
    love.graphics.circle("line", x, self.value, 8, 32)
end


-- відобразити горизонтальною смужкою по осі **y** (для тестування)
---@param y number
function LimitedValue:demoDrawHorizontal(y)
    love.graphics.line(self.min, y, self.max, y)
    love.graphics.circle("line", self.value, y, 8, 32)
end


-------------------- INIT


-- новий пік
---@param max number
---@param alt? number
function LimitedValue:initMax(max, alt)
    max = alt and math.max(max, alt) or max
    if self.max == max then return end

    self.max = max

    self:verifyPeaks()
    self:verifyPushIfAny()
    self:verifyValue()
end


-- новий пік
---@param min number
---@param alt? number
function LimitedValue:initMin(min, alt)
    min = alt and math.min(min, alt) or min
    if self.min == min then return end

    self.min = min

    self:verifyPeaks()
    self:verifyPushIfAny()
    self:verifyValue()
end


-------------------- ADD


-- зсунути валю
---@param add number
function LimitedValue:addValue(add)
    self.value = self:getLimited(self.value + add)
end


-------------------- GET


-- обрізати значення по пікам
---@param value number
---@return number
function LimitedValue:getLimited(value)
    return math.max(self.min, math.min(self.max, value))
end


function LimitedValue:getPushValue()
    return self.push or self.value
end


function LimitedValue:getAvrg()
    return (self.min + self.max) / 2
end


function LimitedValue:getDelta()
    return self.max - self.min
end


-------------------- SET


function LimitedValue:setAvrg(avrg)
    if avrg == self.avrg then return end

    local add = self:getDelta() / 2

    self.avrg = avrg
    self.min = avrg - add
    self.max = avrg + add

    self:verifyPeaks()
    self:verifyPushIfAny()
    self:verifyValue()
end


function LimitedValue:setDelta(delta)
    if delta == self:getDelta() then return end
    print(delta)

    delta = math.max(0, delta)
    local add = delta / 2

    self.min = self.avrg - add
    self.max = self.avrg + add

    self:verifyPeaks()
    self:verifyPushIfAny()
    self:verifyValue()
end


function LimitedValue:setDeltaAndPush(delta)
    if delta == self:getDelta() then return end

    local add = delta / 2
    local k = (self.value - self.min) / self:getDelta()

    self.min = self.avrg - add
    self.max = self.avrg + add

    self:verifyPeaks()
    self.push = self:getDelta() ~= 0 and self:getDelta() * k + self.min or self.max
    self:verifyPushIfAny()
end


-- встановити валю
---@param value number
function LimitedValue:setValue(value)
    self.value = self:getLimited(value)
end


-- встановити пашу
---@param push number
function LimitedValue:setPush(push)
    self.push = self:getLimited(push)
end


-- встановити пашу
---@param push number
function LimitedValue:setPushDt(push)
    self.push = self:getLimited(math.ceil(push))
    self.dt = self.timer
end


-------------------- UTILS


function LimitedValue:verify()
    self:verifyPeaks()
    self:verifyPushIfAny()
    self:verifyValue()
    self:verifyAvrg()
end


function LimitedValue:verifyPeaks()
    if self.min > self.max then
        self.min, self.max = self.max, self.min
    end
end


function LimitedValue:verifyPushIfAny()
    if self.push then
        self.push = self:getLimited(self.push)
    end
end


function LimitedValue:verifyValue()
    self.value = self:getLimited(self.value)
end


function LimitedValue:verifyAvrg()
    self.avrg = (self.min + self.max) / 2
end


-- 

-- якщо валя опиниться за межею, але може там знаходитися
-- і навіть оброблятися, допоки повертається назад
-- (може стане у нагоді)
---@param self test.LimitedValue
local function add(self, _add)
    if _add == 0 then return end
    if _add > 0 and self.value > self.max - _add then return end
    if 0 > _add and self.min - _add > self.value then return end
    self.value = self.value + _add
end