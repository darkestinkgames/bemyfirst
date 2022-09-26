-- 
---@class tool.Limits
Limits = {
    field = {
        min = true,
        max = true,
        value = true,
        delta = true,
        mid = true,
        k = true,
    },
    obj = {
        __newindex = function (self, key, value)
            if not value then
                print("[i] No 'nil' value allowed")
            elseif Limits.field[key] then
                Limits[key](Limits, self, value)
            end
        end,
        __index = function (self, key)
            if Limits.field[key] then
                return rawget(self, "_" .. key)
            end
        end,
    },
}

function Limits:new(...)
    local input = {...}
    table.sort(input)

    -- -@overload fun(a?: number, b?: number, c?: number)

    -- усі атрибути мають початкове значення, і кожне може бути змінене
    ---@class obj.Limits
    ---@field min number # мінімальне допустиме значення
    ---@field max number # максимальне допустиме значення
    ---@field mid number # середнє арифметичне мін/мак
    ---@field value number # поточне значення у диапазоні
    ---@field delta number # дальта мін/макс значень
    ---@field k number # коефіцієнт поточного значення
    local lims = setmetatable({
        _k = 1,
        _min = #input > 1 and input[1] or 0,
        _max = #input > 0 and input[#input] or 0,

        _delta = 0,
        _value = 0,
        _mid = 0,
    }, self.obj)

    self:upDelta(lims)
    self:upValue(lims)
    self:upMid(lims)

    return lims
end


function Limits:newLow(...)
    local lims = self:new(...)
    lims.k = 0
    return lims
end


function Limits:upValue(obj)
    rawset(obj, "_value", obj.delta * obj.k + obj.min)
end


function Limits:upDelta(obj)
    rawset(obj, "_delta", obj.max - obj.min)
end


function Limits:upMax(obj)
    rawset(obj, "_max", obj.min + obj.delta)
end


function Limits:upMid(obj)
    rawset(obj, "_mid", (obj.min + obj.max) / 2)
end


function Limits:upK(obj)
    if obj.delta == 0 then
        rawset(obj, "_k", 0)
    else
        rawset(obj, "_k", (obj.value - obj.min) / obj.delta)
    end
end


function Limits:value(obj, value)
    if obj.value == value then return end

    value = math.max(obj.min, math.min(obj.max, value))
    rawset(obj, "_value", value)

    self:upK(obj)
end


function Limits:k(obj, k)
    if obj.k == k then return end

    k = math.max(0, math.min(1, k))
    rawset(obj, "_k", k)

    self:upValue(obj)
end


function Limits:min(obj, min)
    if min == obj.min then return end

    if min > obj.max then
        rawset(obj, "_min", obj.max)
        rawset(obj, "_max", min)
    else
        rawset(obj, "_min", min)
    end

    self:upDelta(obj)
    self:upValue(obj)
    self:upMid(obj)
end


function Limits:max(obj, max)
    if max == obj.max then return end

    if obj.min > max then
        rawset(obj, "_max", obj.min)
        rawset(obj, "_min", max)
    else
        rawset(obj, "_max", max)
    end

    self:upDelta(obj)
    self:upValue(obj)
    self:upMid(obj)
end


function Limits:delta(obj, delta)
    if obj.delta == delta then return end

    rawset(obj, "_delta", delta)

    self:upMax(obj)
    self:upValue(obj)
    self:upMid(obj)
end


function Limits:mid(obj, mid)
    if mid == obj.mid then return end

    local add = mid - obj.mid
    rawset(obj, "_min", obj.min + add)
    rawset(obj, "_max", obj.max + add)
    rawset(obj, "_mid", mid)
    rawset(obj, "_value", obj.value + add)
end