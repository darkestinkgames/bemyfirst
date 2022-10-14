local map = 'script/map/main'

function love.load(...)
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

function love.mousepressed(x, y, button, istouch, presses)
end

function love.wheelmoved(x, y)
end
