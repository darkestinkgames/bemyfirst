require('test/mainreset')

function love.load(...)
    require('scripts/cpt/Position')
    require('scripts/core/Unit')
    require('scripts/cpt/Move')
    require('scripts/data/Gra')
    require('scripts/data/TileData')
    require('scripts/fn/gameResizeFit')
    require('code/fn/gameScreenToggle')
    require('code/fn/getCopy')
    require('code/fn/getKey')
    require('scripts/fn/getMapCost')
    require('scripts/fn/printTable')
    require('code/fn/setGameFont')
    -- require('')
    
    require('scripts/core/Sprite3')
    -- require('scripts/1/Value2')
    
    Sprite:add('sprite/medival16.png', Gra.tile.width)
    
    require('scripts/core/Map2')
    require('scripts/core/Unit')
    
    -- перевірка
    -- print('- requiries that loaded -')
    -- for i, value in pairs(TileData) do
    --     print('TileData', i, value)
    -- end
    -- print("- end -")
    
    setGameFont()

    -- трохи графічних налаштувань
    love.graphics.setBackgroundColor(0.15, 0.15, 0.15)

    -- 
    -- initDrawables()

    -- змінити шрифт
    -- local font = love.graphics.newFont(6)
    -- font:setFilter("nearest","nearest")
    -- love.graphics.setFont(font)

    -- 
    gameResizeFit()

    -- 
    -- love.window.setFullscreen(true)

    -- трохи експериментів
    som = Unit:new(4, 17)
    printTable(som, 2)
end


-- клавіатура
function love.keypressed(key)
    if key == 'escape' then
        love.event.push('quit')
    end
    if key == 'f4' then
        gameScreenToggle()
        gameResizeFit()
    end
end


function love.draw()
    love.graphics.push()
    love.graphics.translate(map_x, map_y)
    love.graphics.scale(Gra.scale, Gra.scale)

    -- drawCell()
    Map:draw()
    som:draw()
    
    -- відобразити мапу
    -- for _, tile in pairs(Mapa.tile) do
    --     for i, frame in ipairs(tile.sprites) do
    --         frame:draw()
    --     end
    -- end
    
    do -- під курсор
        local x,y = love.mouse.getPosition()
        x = (x - map_x) / Gra.scale
        y = (y - map_y) / Gra.scale
        x = x - x % Gra.tile.width
        y = y - y % Gra.tile.height
        Current_Key = getKey(x / Gra.tile.width + 1, y / Gra.tile.height + 1)
        if Map[Current_Key] then
            love.graphics.setColor(1,1,1, 0.5)
            love.graphics.rectangle("fill", x, y, Gra.tile.width, Gra.tile.height)
            love.graphics.setColor(1,1,1)
            -- Sprite(298, x, y)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print(som.move.path[Current_Key], Map[Current_Key].screen())
        end
    end
    
    love.graphics.pop()
    

    -- нумерація кадрів без маштабування
    -- for key, value in pairs(Drawables) do
    --     love.graphics.print(key, value.screen.x * Gra.scale, (value.screen.y + value.size.height) * Gra.scale)
    -- end

    -- 
    if Map[Current_Key] then
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("fill", 0, 0, 120, 60)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(Current_Key .. '\n' .. Map[Current_Key].data.nazva, 2, 2)
    end
    -- love.graphics.print(Gra.scale, 2, 64)

    -- Sprite(1)
end

-- 
function love.update(dt)
    dt = math.min(dt, 0.5)
    -- do
    --     local value = More.count + dt
    --     More.count = More.count > More.interval and value % More.interval or value
    --     More.i = math.floor(More.count * (#More - 1) / More.interval) + 1
    -- end
end

-- 
function love.resize(w, h)
    gameResizeFit()
end

-- 
function love.mousepressed(x, y, button, istouch, presses)
    print(Current_Key)
    som.cell = Map[Current_Key] or som.cell
    som:updatePath()
end