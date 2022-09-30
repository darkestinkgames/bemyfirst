function love.load(...)
    -- local fontsize = 18
    local fontsize = 30
    love.graphics.setDefaultFilter("nearest", "nearest")
    --// Font1 = love.graphics.newFont('font/Rubik/static/Rubik-Regular.ttf', fontsize)
    --// Font2 = love.graphics.newFont('font/Roboto/Roboto-Regular.ttf', fontsize)
    --// Font3 = love.graphics.newFont('font/Tenor_Sans/TenorSans-Regular.ttf', fontsize)
    Font1 = love.graphics.newFont('font/Noto_Sans/NotoSans-Regular.ttf', fontsize)
    Font2 = love.graphics.newFont('font/Marmelad/Marmelad-Regular.ttf', fontsize)
end


function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end
end


function love.draw()
end


function love.update(dt)
    dt = math.min(dt, 0.5)
end



function love.resize(w, h)
end



function love.mousepressed(x, y, button, istouch, presses) end



function love.wheelmoved( x , y )
end




-- камера тест
-- require('test/main2')


-- і знову камера тест
-- require('test/main3')


-- Limits
-- require('test/main4')

-- камера
-- require('test/main5')

-- знову камера (недотестив)
-- require('test/main6')
-- require('test/main6a')

-- ще разок CamVals, перш ніж зібрати
-- require('test/main7')
-- require('test/main7a')

-- і знову камера, під зібрану CamVals
-- require('test/main8')

-- ще одна ідея для камери
-- require('test/cam/main')