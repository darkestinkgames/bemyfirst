
---@class objCamera
local cam = {
    timer_pos = 0,
    timer_scale = 0,

    cam_pos_x = 0,
    cam_pos_y = 0,

    cam_scale_w = 1,
    cam_scale_h = 1,

    cam_width = 0,
    cam_height = 0,

    push_pos_x = 0,
    push_pos_y = 0,

    push_scale_w = 1,
    push_scale_h = 1,
}


function cam:update(dt)
    self:updPos(dt)
    self:updScale(dt)
end

function cam:updScale(dt)
    if self.timer_scale > 0 then
        if dt > self.timer_scale then
            self.cam_scale_w = self.push_scale_w
            self.cam_scale_h = self.push_scale_h
            self.timer_scale = 0
        else
            print(self.push_scale_w, self.push_scale_h)
            local k = dt / self.timer_scale
            self.cam_scale_w = (self.push_scale_w - self.cam_scale_w) * k + self.cam_scale_w
            self.cam_scale_h = (self.push_scale_h - self.cam_scale_h) * k + self.cam_scale_h
            self.timer_scale = self.timer_scale - dt
        end
    end
end

function cam:updPos(dt)
    if self.timer_pos > 0 then
        if dt > self.timer_pos then
            self.cam_pos_x = self.push_pos_x
            self.cam_pos_y = self.push_pos_y
            self.timer_pos = 0
        else
            local k = dt / self.timer_pos
            self.cam_pos_x = (self.push_pos_x - self.cam_pos_x) * k + self.cam_pos_x
            self.cam_pos_y = (self.push_pos_y - self.cam_pos_y) * k + self.cam_pos_y
            self.timer_pos = self.timer_pos - dt
        end
    end
end

function cam:resetFrame()
    local w , h = love.graphics.getDimensions()

    -- підігнати нову позицію камери

    self.cam_width , self.cam_height = w , h
end

function cam:pushScaleAdd(w, h)
    self:pushScale(self.push_scale_w + w, self.push_scale_h + (h or w))
end

function cam:pushScale(w, h)
    w = math.max(1, w)
    h = math.max(1, h or w)
    self.timer_scale = Camera.timer_scale
    self.push_scale_w = w
    self.push_scale_h = h
end

function cam:pushPosition(x, y)
    self.timer_pos = Camera.timer_pos
    self.push_pos_x = x
    self.push_pos_y = y
end

function cam:setScale(w, h)
    if w > 0 or h > 0 then
        self.cam_scale_w = w
        self.cam_scale_h = h or w
    end
end

function cam:setPosition(x, y)
    self.cam_pos_x = x
    self.cam_pos_y = y
end

function cam:draw(...)
    love.graphics.push()
    love.graphics.translate(self.cam_pos_x, self.cam_pos_y)
    love.graphics.scale(self.cam_scale_w, self.cam_scale_h)
    for _, obj in ipairs({...}) do
        obj:draw()
    end
    love.graphics.pop()
end


---@class gameCamera
Camera = {
    obj = cam,
    timer_pos = 0,5, -- за який час проходить пересування камери
    timer_scale = 0.15, -- за який час проходить маштабування
}

function Camera:new()

    ---@type objCamera
    local obj = getCopy(self.obj)
    obj:resetFrame()

    return obj

end