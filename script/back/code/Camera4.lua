---@class game.Camera
Camera = {
    screen_x = 0,
    screen_y = 0,
    screen_scale = 1,

    screen_width = Limits:new( love.graphics.getWidth() ),
    screen_height = Limits:new( love.graphics.getHeight() ),

    push_x = Limits:new(),
    push_y = Limits:new(),
    scale_push = Limits:new(1, 5, 1),

    timer_pos = 0,
    timer_scale = 0,

    dflt_timer_pos = 0.25,
    dflt_timer_scale = 0.2,
}



function Camera:setScale(scale)
    -- self:pushScale(scale, 0)
    self.screen_scale = scale
end
function Camera:setPos(x, y)
    -- self:pushPos(x, y, 0)
    self.screen_x = x
    self.screen_y = y
end



function Camera:pushScale(scale, timer)
    self.scale_push.value = scale
    self.timer_scale = timer or self.dflt_timer_scale
    self:initScreenFrame()
    -- self.timer_pos = 0 > self.timer_pos and 0 or self.timer_pos
end
function Camera:pushPos(x, y, timer)
    self.push_x.value = x
    self.push_y.value = y
    self.timer_pos = timer or self.dflt_timer_pos
end



function Camera:addScale(scale, timer)
    self:pushScale(self.scale_push.value + scale, timer)
end
function Camera:addPosition(x, y, timer)
    self:pushPos(self.push_x.value + x, self.push_y.value + y, timer)
    -- self.timer_pos = self.timer_pos and (self.timer_pos + self.dflt_timer_pos) / 2 or self.dflt_timer_pos
end



function Camera:initScreenFrame()
    local x, y = self.push_x.min, self.push_y.min

    self.push_x.delta = math.max(0, Map.screen_width.delta * self.scale_push.value - self.screen_width.delta)
    self.push_y.delta = math.max(0, Map.screen_height.delta * self.scale_push.value - self.screen_height.delta)

    self.push_x.min = self.screen_width.mid - (Map.screen_width.mid * self.scale_push.value) - (self.push_x.delta / 2)
    self.push_y.min = self.screen_height.mid - (Map.screen_height.mid * self.scale_push.value) - (self.push_y.delta / 2)

    print("[" .. self.scale_push.value .. "]")
    print(self.push_x.min, self.push_x.max, self.push_x.value, self.screen_x)
    print(x - self.push_x.min)
    -- self.screen_x = self.screen_x - (x - self.push_x.min)
    self:pushPos(self.push_x.value, self.push_y.value)
end



function Camera:draw(obj)
    love.graphics.push()
    love.graphics.translate(self.screen_x, self.screen_y)
    love.graphics.scale(self.screen_scale)
    obj:draw()
    love.graphics.pop()
end



function Camera:update(dt)
    if self.timer_pos >= 0 then
        if dt > self.timer_pos then
            self.screen_x = self.push_x.value
            self.screen_y = self.push_y.value
        else
            local k = dt / self.timer_pos
            self.screen_x = self.screen_x + (self.push_x.value - self.screen_x) * k
            self.screen_y = self.screen_y + (self.push_y.value - self.screen_y) * k
        end
        self.timer_pos = self.timer_pos - dt
        -- print(self.push_x.value, self.push_y.value)
    end
    if self.timer_scale >= 0 then
        if dt > self.timer_scale then
            self.screen_scale = self.scale_push.value
        else
            local k = dt / self.timer_scale
            self.screen_scale = self.screen_scale + (self.scale_push.value - self.screen_scale) * k
        end
        self.timer_scale = self.timer_scale - dt
        -- print(self.scale_push.value)
    end
end