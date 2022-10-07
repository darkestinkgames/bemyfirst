function love.conf(t)
  -- t.version = 11.4
  t.window.resizable = true
  t.window.title = ('MiniFolk Wars (прототип) // LÖVE 2D ver. %s'):format(t.version)
  t.window.width = 16 * 30 * 2
  t.window.height = 16 * 20 * 2
  t.window.minwidth = 400
  t.window.minheight = 200
end