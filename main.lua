function love.load(...)
    -- 
    require('code/game/Data')
    -- 
    require('code/tool/getKey')
    require('code/tool/Position')
    -- 
    require('code/game/Camera')
    require('code/game/Cell')
    require('code/game/Map')
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