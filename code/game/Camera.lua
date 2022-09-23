---@class gameCamera
Camera = {
    scale_min = 1,
    scale_max = 5,

    screenrect = nil,

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

    -- скільки часу лишилося, щоби дійти до push’ів

    timer_scale = 0, -- маштаб
    timer_pos = 0, -- за який час проходить пересування камери
}


function Camera:initScreenFrame(obj)
    local xmin,xmax , ymin,ymax = obj:getScreenRect()
    local mx, my = (xmax - xmin) / 2, (ymax - ymin) / 2

    self.screenrect.x_min = math.min(0, self.mid_x - mx)
    self.screenrect.x_max = math.min(self.mid_y, my)
end



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
    self.cam_x = x
    self.cam_y = y
end



function Camera:pushScale(scale, timer)
    scale = math.min(self.scale_max, math.max(self.scale_min, scale))
    timer = timer or self.pushtimer_scale
    
    local k = scale / self.push_scale
    
    self.timer_scale = timer
    self.push_scale = scale
    
    local a = self.push_x
    self:pushPosition(
        self.mid_x - (self.mid_x - self.push_x) * k,
        self.mid_y - (self.mid_y - self.push_y) * k,
        timer
    )
    -- print(a .. ' -> ' .. self.push_x)
end

function Camera:pushPosition(x, y, timer)
    self.timer_pos = timer or self.pushtimer_pos
    self.push_x = x
    self.push_y = y
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
    if self.timer_scale >= 0 then
        if dt > self.timer_scale then
            self:setScale(self.push_scale)
        else
            local k = dt / self.timer_scale
            self:setScale((self.push_scale - self.scale) * k + self.scale)
        end
        self.timer_scale = self.timer_scale - dt
    end
end

function Camera:updPos(dt)
    -- local a = self.timer_pos
    if self.timer_pos >= 0 then
        local x, y = self.push_x, self.push_y
        if dt > self.timer_pos then
            self:setPosition(self.push_x, self.push_y)
        else
            local k = dt / self.timer_pos
            self:setPosition(
                (self.push_x - self.cam_x) * k + self.cam_x,
                (self.push_y - self.cam_y) * k + self.cam_y
            )
        end
        self.timer_pos = self.timer_pos - dt
        -- print(x .. ' -> ' .. self.push_x, y .. ' -> ' .. self.push_y)
    end
    -- print(a .. ' -> ' .. self.timer_pos)
end



function Camera:resetFrame()
    local w , h = love.graphics.getWidth() / 2 , love.graphics.getHeight() / 2

    self:pushPosition( w - (self.mid_x - self.push_x) , h - (self.mid_y - self.push_y) , 0 )

    self.mid_x , self.mid_y = w , h
end