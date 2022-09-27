require('test/mainreset')
require('test/CamVals')

function love.load(...) end

function love.draw()
    Tst7:drawHor(120)
end

function love.update(dt)
    Tst7:update(dt)
end

function love.keypressed(key) if key == 'escape' then love.event.push('quit') end end

function love.mousepressed(x, y, button, istouch, presses)
    if love.keyboard.isDown("lalt") then
        if button == 1 then Tst7:setMin(x) end
        if button == 2 then Tst7:setMax(x) end
    else
        if button == 1 then Tst7:setPush(x) end
        if button == 2 then Tst7:setValue(x) end
    end
    Tst7:updTimer()
end

function love.wheelmoved( x , y )
    Tst7:setDeltaAvrg( math.max(0, Tst7.delta + y * 32) )
    Tst7:updTimer()
    print(Tst7.delta)
end

function love.resize(w, h) end

-- -- -- -- -- [ test ] -- -- -- -- --

Tst7 = CamVals:new(50, 450):initTimer(0.3)

-- -- -- -- -- [ test ] -- -- -- -- --
