---Контейнер з координатами.
---@class cpt.Position
---@field x number
---@field y number
---@operator call(cpt.Position):number

---Створює контейнер з координатами.
---@class Position
---@operator call(Position):cpt.Position
---@field call function

Position = setmetatable({
    ---Встановлюе та/або повертає координати x y
    ---@param self cpt.Position
    ---@param x? number
    ---@param y? number
    ---@return number
    ---@return number
    call = function (self, x, y)
        self.x = x or self.x or 0
        self.y = y or self.y or 0
        return self.x, self.y
    end,
}, {
    __call = function (self, x, y)
        return setmetatable({x = x or 0, y = y or 0}, {__call = self.call})
    end,
})