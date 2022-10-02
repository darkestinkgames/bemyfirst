---@class obj.DrawableDummie
DrawableDummie = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    color = {0.3, 0.3, 0.3},
    image = nil, ---@type love.Image
}
function DrawableDummie:new(w, h)
    ---@type obj.DrawableDummie
    local obj = {}
    for key, value in pairs(self) do obj[key] = value end
    fnInitDrawables(obj)
    return obj:size(w, h)
end
function DrawableDummie:pos(x, y)
    self.x = x or self.x
    self.y = y or self.y
    return self
end
function DrawableDummie:size(w, h)
    self.width = w or self.width
    self.height = h or self.height
    self.draw = self.drawDummies
    return self
end
function DrawableDummie:setColor(color)
    self.color = color
    return self
end
function DrawableDummie:setImage(path)
    self.image = love.graphics.newImage(path)
    self.width, self.height = self.image:getDimensions()
    self.draw = self.drawImage
    return self
end

function DrawableDummie:drawImage()
    love.graphics.draw(self.image, self.x, self.y)
end
function DrawableDummie:drawDummies()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(self.color[1], 1, self.color[3])
    love.graphics.rectangle("line", self.x - 1, self.y - 1, self.width + 2, self.height + 2)
end
function DrawableDummie:draw() end