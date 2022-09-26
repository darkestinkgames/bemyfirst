---@class tool.Limits
Limits = {
    obj = {
        __newindex = function (self, key, value)
            if value then
                -- if key == "min" or key == "max" then
                --     local k = self.k
                --     local imput = {self.min, self.max, value}
                --     table.sort(imput)
                --     rawset(self, "_min", imput[1])
                --     rawset(self, "_max", imput[3])
                --     self.k = k
                --     return
                -- end
                if key == "min" then
                    local k = self.k
                    if value > self.max then
                        rawset(self, "_min", self.max)
                        rawset(self, "_max", value)
                    else
                        rawset(self, "_min", value)
                    end
                    self.k = k
                    return
                end
                if key == "max" then
                    local k = self.k
                    if self.min > value then
                        rawset(self, "_max", self.min)
                        rawset(self, "_min", value)
                    else
                        rawset(self, "_max", value)
                    end
                    self.k = k
                    return
                end
                if key == "mid" then
                    local add = value - self[key]
                    rawset(self, "_min", self.min + add)
                    rawset(self, "_max", self.max + add)
                    if rawget(self, "_value") then
                        rawset(self, "_value", self.value + add)
                    end
                    return
                end
                if key == "value" then
                    rawset(self, "_value", math.max(self.min, math.min(self.max, value)))
                    return
                end
                if key == "delta" then
                    rawset(self, "_max", self.min + value)
                    return
                end
                if key == "k" then
                    rawset(self, "_value", self.delta * value + self.min)
                    return
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
            self.max = a
            self.min = b
            self.value = c
        end,
    },
}

---@param a? number # мін/макс
---@param b? number # мін/макс
---@param c? number # значення у диапазоні
---@return obj.Limits | fun(a?: number, b?: number, c?: number)
function Limits:new(a, b, c)
    ---
    ---@class obj.Limits
    ---@field min number # мінімально допустиме значення
    ---@field max number # максимально допустиме значення
    ---@field mid number # середнє арифметичне
    ---@field value number # значення у диапазоні
    ---@field delta number # дальта мін/макс значень, можна змінювати
    ---@field k number # змінити поточне значення за коефіцієнтом: 0 — це 0% (мін), 1 — це 100% (макс)
    ---@overload fun(a?: number, b?: number, c?: number)
    local obj = setmetatable({}, self.obj)
    obj(a, b, c)
    return obj
end