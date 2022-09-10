---@class game.Camera
Camera = {
    x = 0,
    y = 0,
    scale_x = 0,
    scale_y = 0,
}

function Camera:draw(obj)
    love.graphics.push()
    love.graphics.scale(self.scale_x, self.scale_y)
    love.graphics.translate(self.x, self.y)
    obj:draw()
    love.graphics.pop()
end

function Camera:getMouse() end
function Camera:update(dt) end

