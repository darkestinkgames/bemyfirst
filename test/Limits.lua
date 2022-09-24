---@class game.Limits
Limits = {
    obj = {
        __newindex = function (self, key, value)
            if value then
                if key == "min" or key == "max" or key == "mid" then
                    local add = value - self[key]
                    rawset(self, "_min", self.min + add)
                    rawset(self, "_max", self.max + add)
                    rawset(self, "_value", self.value + add)
                end
                if key == "value" then
                    rawset(self, "_value", math.max(self.min, math.min(self.max, value)))
                end
                if key == "delta" then
                    rawset(self, "_max", self.min + value)
                end
                if key == "k" then
                    rawset(self, "_value", self.delta * value + self.min)
                end
            end
        end,
        __index = function (self, key)
            if key == "min" or key == "max" then
                return rawget(self, "_" .. key) or 0
            end
            if key == "value" then
                return rawget(self, "_value") or self.max
            end
            if key == "mid" then
                return (self.min + self.max) / 2
            end
            if key == "delta" then
                return self.max - self.min
            end
            if key == "k" then
                return self.delta ~= 0 and math.abs(self.value - self.min) / self.delta or 0
            end
        end,
        __call = function (self, a, b, c)
            local input = {a or 0, b or 0}
            table.sort(input)
            rawset(self, '_min', input[1])
            rawset(self, '_min', input[2])
            if c then
                self.value = c
            end
        end,
    },
}

---@param a? number # мін/макс
---@param b? number # мін/макс
---@param c? number # значення у диапазоні
---@return obj.Limits | fun(a?: number, b?: number, c?: number)
function Limits:new(a, b, c)
    ---мін/мід/макс лише зсувають діапазон, щоб змінити — треба викликати, як функцію
    ---@class obj.Limits
    ---@field min number # мінімальне допустиме значення
    ---@field max number # максимальне допустиме значення
    ---@field mid number # середнє арифметичне
    ---@field value number # значення у диапазоні
    ---@field delta number # дальта мін/макс значень
    ---@field k number # коефіцієнт поточного значення
    ---@overload fun(a?: number, b?: number, c?: number)
    local obj = setmetatable({}, self.obj)
    obj(a, b, c)
    return obj
end