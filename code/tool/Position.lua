---@class tool.Position
---@overload fun(x?: number, y?: number): obj.Position
Position = {
    obj = {
        __call = function (self, x, y)
            if x then
                self.x = x
                self.y = y
            end
            return self.x, self.y
        end
    },
}

function Position:new(x, y)
    ---@class obj.Position
    ---@field x number
    ---@field y number
    ---@overload fun(x?: number, y?: number): number, number
    local obj = setmetatable({x = x or 0, y = y or 0}, self.obj)
    return obj
end

---@diagnostic disable-next-line: param-type-mismatch
setmetatable(Position, {__call = Position.new})