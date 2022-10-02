-- 
function love.load(...)

    -- ? чи може зібрати десь окремо, може ні
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.15, 0.15, 0.15)
    local fontsize = 30
    Font1 = love.graphics.newFont('assets/font/Noto_Sans/NotoSans-Regular.ttf', fontsize)
    Font2 = love.graphics.newFont('assets/font/Marmelad/Marmelad-Regular.ttf', fontsize)
    love.graphics.setFont(Font1)

    require 'script/fn/fnDrawables'
    --// require 'script/fn/getGridFrom'
    --// require 'script/fn/initTiles'
    require 'script/fn/fnPrintTable'
    require 'script/game/SimpleCamera'
    require 'script/game/Sprite'
    require 'script/map/Grid'
    require 'script/map/MapaTileData'
    require 'script/map/MapaCell'
    -- require ''
    -- require ''

    require 'back/DrawableDummie'

    love.graphics.setDefaultFilter("nearest", "nearest")

    Grid:getTilesFrom('assets/map/1/1')
    SimpleCamera:resize()

    Sprite:add('assets/sprite/medival16.png', 16)
    -- Sprite:add('assets/sprite/MiniArcherMan.png', 32)

    -- Mini = love.graphics.newImage('assets/sprite/MiniArcherMan.png')
    Mini = love.graphics.newImage('assets/sprite/MiniHorseMan.png')
end

-- 
function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end
end

-- 
function love.draw()
    SimpleCamera:start()
    fnDrawables()
    love.graphics.draw(Mini)
    SimpleCamera:stop()

    local cell = Grid:getCell(SimpleCamera:getMousePosition())
    if cell then
        love.graphics.setColor(1, 1, 1, 0.6)
        love.graphics.rectangle("fill", 0, 0, 300, 88)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(cell.tile.nazva .. "\n" .. cell.key, 4, 4)
    end

end

-- 
function love.update(dt)
    dt = math.min(dt, 0.5)
end

-- 
function love.resize(w, h)
    SimpleCamera:resize()
end

-- 
function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        Grid.selected_cell = Grid:getCell(SimpleCamera:getMousePosition())
    end
    if button == 2 then
        Grid.selected_cell = nil
    end
end

-- 
function love.wheelmoved(x, y)
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