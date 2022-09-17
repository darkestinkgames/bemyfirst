function love.load(...)
    -- базові глобальні функції, які покищо нема де притулити
    require('code/fn/getKey')

    -- допоміжне
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
    require('code/game/Camera')
    require('code/game/Sprite')

    -- 
    Map:load(1)

end



function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end
end



function love.draw()
    love.graphics.push()
    love.graphics.scale(1.3, 1.3)
    Map:draw()
    love.graphics.pop()
end



function love.update(dt)
    dt = math.min(dt, 0.5)
end



function love.resize(w, h) end



function love.mousepressed(x, y, button, istouch, presses) end



-- розкоментувати останній рядок, щоб запускалась попередня версія (до того, як усе зламав)
-- F4 перемикач (екран/вікно)
-- (будь-який) клік миші щоб встановити умовного юніта (ріки, гори та моря) — для перевірки пошук шляху
-- Esc — вихід
-- require('main1')