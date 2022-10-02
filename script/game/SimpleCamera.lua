SimpleCamera = {
    x = 0,
    y = 0,
    scale = 1,
}
function SimpleCamera:resize()
    local map_k = Grid.screen_width / Grid.screen_height
    local w, h = love.graphics.getDimensions()
    local k = w / h
    self.scale = k > map_k and h / Grid.screen_height or w / Grid.screen_width
    self.x = (w / 2 - Grid.screen_width * self.scale / 2)
    self.y = (h / 2 - Grid.screen_height * self.scale / 2)
end

function SimpleCamera:start()
    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.scale(self.scale, self.scale)
end

function SimpleCamera:stop()
    if SelectedCell then
        love.graphics.setColor(0.15, 0.15, 0.15, 0.4)
        love.graphics.rectangle("fill", SelectedCell.screen_x, SelectedCell.screen_y, 16, 16)
    else
        love.graphics.setColor(1, 1, 1)
        local x, y = self:getMousePosition()
        love.graphics.circle("fill", x, y, 4, 20)
    end

    love.graphics.pop()
end

function SimpleCamera:getMousePosition()
    local x, y = love.mouse.getPosition()
    return (x - self.x) / self.scale, (y - self.y) / self.scale
end