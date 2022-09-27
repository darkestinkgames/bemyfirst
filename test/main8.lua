require('test/mainreset')
require('code/fn/printTable')
require('test/CamVals')

function love.load(...) end

function love.draw()
    love.graphics.push()
    love.graphics.translate(KB_X, KB_Y)
    Camera8.x:drawHor( Camera8.y.min )
    Camera8.y:drawVert( Camera8.x.min )
    Camera8:draw(Tst8)
    love.graphics.pop()
end

function love.update(dt)
    if love.keyboard.isDown("left") then Camera8.x:addPush( STEP8 * 7 * dt ) end
    if love.keyboard.isDown("right") then Camera8.x:addPush( -STEP8 * 7 * dt ) end
    if love.keyboard.isDown("up") then Camera8.y:addPush( STEP8 * 7 * dt ) end
    if love.keyboard.isDown("down") then Camera8.y:addPush( -STEP8 * 7 * dt ) end

    Camera8:update(dt)
end

---@param key love.KeyConstant
function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end

    if key == "a" then KB_X = KB_X + STEP8 end
    if key == "d" then KB_X = KB_X - STEP8 end
    if key == "w" then KB_Y = KB_Y + STEP8 end
    if key == "s" then KB_Y = KB_Y - STEP8 end

    if key == "kp0" then
        KB_X = 0
        KB_Y = 0
    end

    -- printTable(Camera8)
end

function love.mousepressed(x, y, button, istouch, presses) end

function love.wheelmoved( x , y )
    Camera8.scale:addPush( y * 0.25 )
    onScreenResize()
end

function love.resize(w, h)
    onScreenResize()
end

-- -- -- -- -- [ test ] -- -- -- -- --

KB_X = 0
KB_Y = 0
STEP8 = 32

-- -- -- -- -- [ test ] -- -- -- -- --

Camera8 = {
    x = CamVals:new(), -- :initTimer(0.2),
    y = CamVals:new(), -- :initTimer(0.2),
    scale = CamVals:new(1, 5), -- :initTimer(0.2),
    width = love.graphics.getWidth() ,
    height = love.graphics.getHeight() ,
}

function Camera8:update(dt)
    self.x:update(dt)
    self.y:update(dt)
    self.scale:update(dt)

    -- print(Camera8.x.timer)
end

function Camera8:draw(obj)
    love.graphics.push()
    love.graphics.translate(self.x.value, self.y.value)
    love.graphics.scale(self.scale.push, self.scale.push)

    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", obj.x, obj.y, obj.width, obj.height)
    love.graphics.setColor(0.8, 0.4, 0.4)
    love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)

    love.graphics.circle("fill", obj.x + obj.width / 2, obj.y, 8, 20)
    love.graphics.circle("fill", obj.x, obj.y + obj.height / 2, 8, 20)
    love.graphics.circle("fill", obj.x + obj.width, obj.y + obj.height / 2, 8, 20)
    love.graphics.circle("fill", obj.x + obj.width / 2, obj.y + obj.height, 8, 20)

    love.graphics.setColor(0, 0.8, 0)
    love.graphics.circle("line", 0, 0, 8, 20)

    love.graphics.pop()
end

-- -- -- -- -- [ test ] -- -- -- -- --

Tst8 = {
    x = math.random(5, 50),
    y = math.random(5, 50),
    width = math.random(700, 800),
    height = math.random(50, 500),
}

-- -- -- -- -- [ test ] -- -- -- -- --

function onScreenResize()
    Camera8.width, Camera8.height = love.graphics.getDimensions()

    local w, h = Tst8.width * Camera8.scale.push, Tst8.height * Camera8.scale.push
    local x, y = Tst8.x * Camera8.scale.push, Tst8.y * Camera8.scale.push

    Camera8.x:setDeltaMin( math.max(0, w - Camera8.width) )
    Camera8.y:setDeltaMin( math.max(0, h - Camera8.height) )

    Camera8.x:movMin( (Camera8.width / 2) - (w / 2 + x) - (Camera8.x.delta / 2) )
    Camera8.y:movMin( (Camera8.height / 2) - (h / 2 + y) - (Camera8.y.delta / 2) )
end

-- -- -- -- -- [ test ] -- -- -- -- --

printTable(Tst8)

-- -- -- -- -- [ test ] -- -- -- -- --
