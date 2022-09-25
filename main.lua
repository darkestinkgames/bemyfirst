function love.load(...)

    -- базові глобальні функції, які покищо нема де притулити
    require('code/fn/gameScreenToggle')
    require('code/fn/getCopy')
    require('code/fn/getKey')
    require('code/fn/newScreenRect')

    -- допоміжне
    require('code/tool/Limits')
    require('code/tool/Position')

    -- технічна інф-а по грі
    require('code/game/Data')

    ----- мапа
    require('code/game/Map')
    -- чарунки
    require('code/game/Cell')
    -- будівлі
    -- юніти
    require('code/game/UnitMove')
    require('code/game/Unit')

    -- типу класи, що не створюють об’єктів
    require('code/game/Camera4')
    require('code/game/Sprite')

    -- 
    Map:load(1)
    Map:initScreenRect()

    Camera:initScreenFrame()
    -- Camera:pushScale(3, 1)
end


function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end

    if key == 'f4' then
        gameScreenToggle()
        Camera:resetFrame()
    end

    -- local step = 64
    -- if key == 'w' then
    --     Camera:addPosition(0, step)
    -- end
    -- if key == 's' then
    --     Camera:addPosition(0, -step)
    -- end
    -- if key == 'a' then
    --     Camera:addPosition(step, 0)
    -- end
    -- if key == 'd' then
    --     Camera:addPosition(-step, 0)
    -- end
end


function love.draw()
    Camera:draw(Map)
end



function love.update(dt)
    dt = math.min(dt, 0.5)

    -- 
    local step = 32
    local x, y = 0, 0
    if love.keyboard.isDown("w") then
        y = y + step
    end
    if love.keyboard.isDown("s") then
        y = y - step
    end
    if love.keyboard.isDown("a") then
        x = x + step
    end
    if love.keyboard.isDown("d") then
        x = x - step
    end
    if x ~= 0 or y ~= 0 then
        Camera:addPosition(x, y, dt)
    end

    -- 
    Camera:update(dt)
end



function love.resize(w, h)
    Camera:resetFrame()
end



function love.mousepressed(x, y, button, istouch, presses) end



function love.wheelmoved( x , y )
    Camera:addScale(y * .5)
end



-- розкоментувати main1, щоб запускалась попередня версія (до того, як усе зламав)
-- F4 перемикач (екран/вікно)
-- (будь-який) клік миші щоб встановити умовного юніта (ріки, гори та моря) — для перевірки пошук шляху
-- Esc — вихід
-- require('test/main1')


-- камера тест
-- require('test/main2')


-- і знову камера тест
-- require('test/main3')


-- Limits
require('test/main4')

