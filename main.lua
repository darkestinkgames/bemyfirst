local upds = require 'script/game/updatables'
local grid = require 'script/mapgrid/grid'
-- 
function love.load(...)
  -- ? чи може зібрати десь окремо, може ні
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setBackgroundColor(0.15, 0.15, 0.15)
  local fontsize = 30
  Font1 = love.graphics.newFont('assets/font/Noto_Sans/NotoSans-Regular.ttf', fontsize)
  Font2 = love.graphics.newFont('assets/font/Marmelad/Marmelad-Regular.ttf', fontsize)
  love.graphics.setFont(Font1)

  grid.newMap('script/mapgrid/maps/demo')
end

function love.keypressed(key)
  if key == 'escape' then love.event.push('quit') end
end

function love.draw()
end

function love.update(dt)
  dt = math.min(dt, 0.5)
  upds.update(dt)
end

function love.resize(w, h)
end

function love.mousepressed(x, y, button, istouch, presses)
end

function love.wheelmoved(x, y)
end
