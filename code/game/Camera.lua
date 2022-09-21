---@class gameCamera
Camera = {
    scale_min = 1,
    scale_max = 5,

    -- x_min = 0,
    -- x_max = 0,
    -- y_min = 0,
    -- y_max = 0,

    -- поточні значення

    scale = 1, -- маштаб

    cam_x = 0, -- позиція камери
    cam_y = 0,

    mid_x = love.graphics.getWidth() / 2, -- середина екрану
    mid_y = love.graphics.getHeight() / 2,

    -- значення, до яких треба дійти

    push_scale = 1,

    push_x = 0,
    push_y = 0,
    
    pushtimer_scale = 0.15, -- маштаб
    pushtimer_pos = 0.25, -- за який час проходить пересування камери
    
    -- за який час треба дійти

    timer_scale = 0, -- маштаб
    timer_pos = 0, -- за який час проходить пересування камери
}



function Camera:initScale(scale)
    self:setScale(scale)
    self:pushScale(scale, 0)
end

function Camera:initPosition(x, y)
    self:setPosition(x, y)
    self:pushPosition(x, y, 0)
end



function Camera:setScale(scale)
    scale = math.max(Camera.scale_min, math.min(Camera.scale_max, scale))
    -- local k = scale / self.scale
    self.scale = scale
    -- self:setPosition(
    --     self.mid_x - (self.mid_x - self.cam_x) * k,
    --     self.mid_y - (self.mid_y - self.cam_y) * k
    -- )
end

function Camera:setPosition(x, y)
-- print('setPosition', x, y)
    self.cam_x = x
    self.cam_y = y
end



function Camera:pushScale(scale, timer)
    scale = math.min(self.scale_max, math.max(self.scale_min, scale))
    timer = timer or self.pushtimer_scale
    self.timer_scale = --[[self.timer_scale +]] timer
    local k =  scale / self.push_scale
    self.push_scale = scale
    self:pushPosition(
        self.mid_x - (self.mid_x - self.push_x) * k,
        self.mid_y - (self.mid_y - self.push_y) * k,
        timer
    )
end

function Camera:pushPosition(x, y, timer)
-- print('pushPosition', timer)
    timer = timer or self.pushtimer_pos
    self.timer_pos = --[[self.timer_pos +]] timer
    self.push_x = x
    self.push_y = y
-- print('pushPosition', self.cam_x .. ' => ' .. self.push_x, self.cam_y .. ' => ' .. self.push_y, timer)
end



function Camera:addScale(scale)
    self:pushScale(self.push_scale + scale)
end

function Camera:addPosition(x, y)
    self:pushPosition(self.cam_x + x * self.scale, self.cam_y + y * self.scale)
end

-- a * 2 / b * 2
-- (a * 2) / (b * 2)


function Camera:draw(...)
    love.graphics.push()
    love.graphics.translate(self.cam_x, self.cam_y)
    love.graphics.scale(self.scale, self.scale)
    for _, obj in ipairs({...}) do
        obj:draw()
    end
    love.graphics.pop()
    love.graphics.circle("line", self.mid_x, self.mid_y, 16, 32)
end



function Camera:update(dt)
    self:updScale(dt)
    self:updPos(dt)
end

function Camera:updScale(dt)
    if self.timer_scale > 0 then
        if dt > self.timer_scale then
            self:setScale(self.push_scale)
            self.timer_scale = 0
        else
            local k = dt / self.timer_scale
            self:setScale((self.push_scale - self.scale) * k + self.scale)
            self.timer_scale = self.timer_scale - dt
        end
    end
end

function Camera:updPos(dt)
    if self.timer_pos > 0 then
        if dt > self.timer_pos then
            self:setPosition(self.push_x, self.push_y)
            self.timer_pos = 0
        else
-- print('updPos')
            local k = dt / self.timer_pos
            self:setPosition(
                (self.push_x - self.cam_x) * k + self.cam_x,
                (self.push_y - self.cam_y) * k + self.cam_y
            )
            self.timer_pos = self.timer_pos - dt
        end
    end
end



function Camera:resetFrame()
    local w , h = love.graphics.getDimensions()

    -- підігнати нову позицію камери
    -- local k = (w / h) > (self.mid_x / self.mid_y) and (w / 2) / self.mid_x or (h / 2) / self.mid_y

    -- local k1 = self.mid_x / self.mid_y
    -- local k2 = w / h
    -- self:pushScale(self.scale * k1 / k2)
    -- print(k, k1, k2)

    self.mid_x , self.mid_y = w / 2 , h / 2
end



--[[

    ---@class gameCamera
    Camera = {
        obj = cam,
    
        timer_pos = 0.25, -- за який час проходить пересування камери
        timer_scale = 0.15, -- за який час проходить маштабування
    
        scale_min = 1,
        scale_max = 4,
    }
    
    function Camera:new()
    
        ---@type objCamera
        local obj = getCopy(self.obj)
    
        return obj
    
    end
    
]]