require('test/mainreset')

require('test/cam/LimitedValue')
require('test/cam/DrawableDummie')
require('test/cam/CameraTry')

function love.load(...)
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    CameraTry.x:initMax(400)
    CameraTry.y:initMax(400)
end

function love.draw()
    CameraTry:draw(tst)

    -- smuzhka1:demoDrawHorizontal(220)
end

function love.update(dt)
    if love.keyboard.isDown("left", "a") then CameraTry.x:addValue( -speed * dt ) end
    if love.keyboard.isDown("right", "d") then CameraTry.x:addValue( speed * dt ) end

    if love.keyboard.isDown("up", "w") then CameraTry.y:addValue( -speed * dt ) end
    if love.keyboard.isDown("down", "s") then CameraTry.y:addValue( speed * dt ) end

    CameraTry:update(dt)
end

function love.keypressed(key) if key == 'escape' then love.event.push('quit') end end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- smuzhka1:setPush(x)
        -- smuzhka2:setPush(y)
    end
end

function love.wheelmoved( x , y )
    CameraTry.scale:setPushDt(CameraTry.scale.value + y)
    CameraTry:initFrame(tst)

    smuzhka1:setDelta(smuzhka1:getDelta() + y * 16)
end

function love.resize(w, h) end

-- -- -- -- -- [ test ] -- -- -- -- --

tst = DrawableDummie:new(600, 100)
tst:pos(50, 20)
tst:loadImage( 'map/1/1.png' )

-- -- -- -- -- [ test ] -- -- -- -- --

speed = 300

smuzhka1 = LimitedValue:new(20, 550)
smuzhka2 = LimitedValue:new(20, 220)

-- -- -- -- -- [ test ] -- -- -- -- --
