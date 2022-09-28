---@class test.DrawableDummie
DrawableDummie = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    -- image = nil,
}
function DrawableDummie:new(w, h)
    ---@type test.DrawableDummie
    local obj = {}
    for key, value in pairs(self) do obj[key] = value end
    obj:size(w, h)
    return obj
end
function DrawableDummie:draw()
    if self.image then
        love.graphics.draw(self.image, self.x, self.y)
    else
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        love.graphics.setColor(0.3, 1, 0.3)
        love.graphics.rectangle("line", self.x - 1, self.y - 1, self.width + 2, self.height + 2)
    end
end
function DrawableDummie:pos(x, y)
    self.x = x or self.x
    self.y = y or self.y
end
function DrawableDummie:size(w, h)
    self.width = w or self.width
    self.height = h or self.height
end
function DrawableDummie:loadImage(_path)
    self.image = love.graphics.newImage(_path)
    self.width, self.height = self.image:getDimensions()
end