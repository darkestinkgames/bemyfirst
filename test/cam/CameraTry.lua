
CameraTry = {
    x = LimitedValue:new(),
    y = LimitedValue:new(),
    scale = LimitedValue:new(1, 4),
}

function CameraTry:update(dt)
    self.x:update(dt)
    self.y:update(dt)
    self.scale:update(dt)
end

function CameraTry:draw(obj)
    love.graphics.push()
    love.graphics.translate(self.x.value, self.y.value)
    love.graphics.scale(self.scale.value, self.scale.value)

    obj:draw()

    love.graphics.pop()

    self.x:demoDrawHorizontal(20)
end

---@param obj test.DrawableDummie
function CameraTry:initFrame(obj)
    local width, height = love.graphics.getDimensions()
    local w, h = obj.width * self.scale:getPushValue(), obj.height * self.scale:getPushValue()
    local x, y = obj.x * self.scale:getPushValue(), obj.y * self.scale:getPushValue()

    self.x:setAvrg( width/2 - w/2 - x )
    self.y:setAvrg( height/2 - h/2 - y )
    print("avrg", self.x.avrg, self.y.avrg)

    self.x:setDelta( w - width )
    self.y:setDelta( h - height )

    -- local cx = CameraTry.x:getAvrg() - CameraTry.x.value

    -- self.x:initMin( width - (w + x), width / 2 - w / 2 - x )
    -- self.y:initMin( height - (h + y), height / 2 - h / 2 - y )
end