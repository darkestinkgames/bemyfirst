---@class tool.Size
---@overload fun(width?: number, height?: number): obj.Size
Size = {
    obj = {
        __call = function (self, width, height)
            if width then
                self.width = width
                self.height = height
            end
            return self.width, self.height
        end
    },
}

function Size:new(width, height)
    ---@class obj.Size
    ---@field width number
    ---@field height number
    ---@overload fun(width?: number, height?: number): number, number
    local obj = setmetatable({width = width or 0, height = height or 0}, self.obj)
    return obj
end

---@diagnostic disable-next-line: param-type-mismatch
setmetatable(Size, {__call = Size.new})