
---@class objCamera
local cam = {
    -- позиція камери
    cam_pos_x = 0,
    cam_pos_y = 0,
    
    pushtimer_pos = 0,
    push_pos_x = 0,
    push_pos_y = 0,

    -- маштабування камери
    cam_scale = 1,
 
    pushtimer_scale = 0,
    push_scale = 1,
    
    -- розмір вікна
    cam_width = 0,
    cam_height = 0,
}


function cam:draw(...)
    love.graphics.push()
    love.graphics.translate(self.cam_pos_x, self.cam_pos_y)
    love.graphics.scale(self.cam_scale, self.cam_scale)
    for _, obj in ipairs({...}) do
        obj:draw()
    end
    love.graphics.pop()
    love.graphics.circle("line", self.cam_width / 2, self.cam_height / 2, 16, 32)
end


function cam:update(dt)
    self:updPos(dt)
    self:updScale(dt)
end
function cam:updScale(dt)
    if self.pushtimer_scale > 0 then
        if dt > self.pushtimer_scale then
            self:setScale(self.push_scale)
            self.pushtimer_scale = 0
        else
            local k = dt / self.pushtimer_scale
            self:setScale((self.push_scale - self.cam_scale) * k + self.cam_scale)
            self.pushtimer_scale = self.pushtimer_scale - dt
        end
    end
end
function cam:updPos(dt)
    if self.pushtimer_pos > 0 then
        if dt > self.pushtimer_pos then
            self:setPosition(self.push_pos_x, self.push_pos_y)
            self.pushtimer_pos = 0
        else
            local k = dt / self.pushtimer_pos
            self:setPosition(
                (self.push_pos_x - self.cam_pos_x) * k + self.cam_pos_x,
                (self.push_pos_y - self.cam_pos_y) * k + self.cam_pos_y
            )
            self.pushtimer_pos = self.pushtimer_pos - dt
        end
    end
end


function cam:resetFrame()
    local w , h = love.graphics.getDimensions()

    -- підігнати нову позицію камери

    self.cam_width , self.cam_height = w , h
end


function cam:initScale(scale)
    self:setScale(scale)
    self:pushScale(scale, 0)
end
function cam:setScale(scale)
    scale = math.max(Camera.scale_min, math.min(Camera.scale_max, scale))
    self.cam_scale = scale
end
function cam:pushScale(scale, timer)
    timer = timer or Camera.pushtimer_scale
    self.pushtimer_scale = self.pushtimer_scale + timer
    scale = math.min(4, math.max(1, scale))
    local k1 = self.push_scale / scale
    local k =  scale / self.push_scale
    print(k, k1)
    self.push_scale = scale
    self:pushPosition(
        self.push_pos_x * k1,
        self.push_pos_y * k1,
        timer
    )
end
function cam:addScale(scale)
    self:pushScale(self.push_scale + scale)
end


function cam:initPosition(x, y)
    self:setPosition(x, y)
    self:pushPosition(x, y, 0)
end
function cam:setPosition(x, y)
    self.cam_pos_x = x
    self.cam_pos_y = y
end
function cam:pushPosition(x, y, timer)
    timer = timer or Camera.pushtimer_pos
    self.pushtimer_pos = self.pushtimer_pos + timer
    self.push_pos_x = x
    self.push_pos_y = y
end
function cam:addPosition(x, y)
    self:pushPosition(self.cam_pos_x + x, self.cam_pos_y + y)
end


---@class gameCamera
Camera = {
    obj = cam,

    pushtimer_pos = 0.25, -- за який час проходить пересування камери
    pushtimer_scale = 0.15, -- за який час проходить маштабування

    scale_min = 1,
    scale_max = 4,
}

function Camera:new()

    ---@type objCamera
    local obj = getCopy(self.obj)
    obj:resetFrame()

    return obj

end