
--[[ game_gs.lua

local game_gs = GState.new()
function GState.game_gs() GState.switch(game_gs) end

]]

--[[ main.lua

function love.load(...)
  GState = require 'scripts.mods.GState'
  require 'scripts.state.game_gs'
  GState.intro_gs()
end

]]

local NewState
do -- 

  -- general

  ---@type fun(...)
  local function onstart(...)
  end
  ---@type fun()
  local function draw()
  end
  ---@type fun()
  local function lowmemory()
    collectgarbage()
  end
  ---@type fun():boolean?
  local function quit()
    return false
  end
  ---@type fun(dt:number)
  local function update(dt)
  end

  -- window

  ---
  ---@type fun(path:string)
  local function directorydropped(path)
  end
  ---Due to a bug in LOVE 11.3, the orientation value is boolean true instead. A workaround is as follows:
  ---@type fun(index:number, orientation:love.DisplayOrientation)
  local function displayrotated( index, orientation )
    orientation = love.window.getDisplayOrientation(index)
    -- The rest of your code goes here
  end
  -- 
  ---@type fun(file:love.DroppedFile)
  local function filedropped( file )
  end
  -- 
  ---@type fun(f:boolean)
  local function focus(f)
  end
  -- 
  ---@type fun(f:boolean)
  local function mousefocus(f)
  end
  -- 
  ---@type fun(w:number,h:number)
  local function resize(w, h)
  end
  -- 
  ---@type fun(v:boolean)
  local function visible(v)
  end

  -- keyboard

  -- 
  ---@type fun(key:love.KeyConstant,scancode:love.Scancode,isrepeat:boolean)
  local function keypressed(key, scancode, isrepeat)
  end
  -- 
  ---@type fun(key:love.KeyConstant,scancode:love.Scancode)
  local function keyreleased(key, scancode)
    if key == "escape" then love.event.push("quit") end
  end
  -- 
  ---@type fun(text:string,start:number,length:number)
  local function textedited(text, start, length)
  end
  -- 
  ---@type fun(text:string)
  local function textinput(text)
  end

  -- mouse

  -- 
  -- -@param istouch boolean True if the mouse button press originated from a touchscreen touch-press
  ---@type fun(x:number,y:number,dx:number,dy:number,istouch:boolean)
  local function mousemoved(x,y, dx,dy, istouch)
  end
  -- 
  ---@type fun(x:number,y:number,button:number,istouch:boolean,presses:number)
  local function mousepressed(x,y, button, istouch, presses)
  end
  -- 
  ---@type fun(x:number,y:number,button:number,istouch:boolean,presses:number)
  local function mousereleased(x,y, button, istouch, presses)
  end
  -- 
  ---@type fun(x:number, y:number)
  local function wheelmoved(x,y)
  end

  -- -- -- -- -- -- -- -- -- --

  function NewState()

    local gs = {}

    gs.onstart = onstart

    gs.draw      = draw
    gs.lowmemory = lowmemory
    gs.quit      = quit
    gs.update    = update

    gs.directorydropped = directorydropped
    gs.displayrotated   = displayrotated
    gs.filedropped      = filedropped
    gs.focus            = focus
    gs.mousefocus       = mousefocus
    gs.resize           = resize
    gs.visible          = visible

    gs.keypressed  = keypressed
    gs.keyreleased = keyreleased
    gs.textedited  = textedited
    gs.textinput   = textinput

    gs.mousemoved    = mousemoved
    gs.mousepressed  = mousepressed
    gs.mousereleased = mousereleased
    gs.wheelmoved    = wheelmoved

    return gs

  end

end --




local function Switch(gs, ...)

  love.draw      = gs.draw
  love.lowmemory = gs.lowmemory
  love.quit      = gs.quit
  love.update    = gs.update

  love.directorydropped = gs.directorydropped
  love.displayrotated   = gs.displayrotated
  love.filedropped      = gs.filedropped
  love.focus            = gs.focus
  love.mousefocus       = gs.mousefocus
  love.resize           = gs.resize
  love.visible          = gs.visible

  love.keypressed  = gs.keypressed
  love.keyreleased = gs.keyreleased
  love.textedited  = gs.textedited
  love.textinput   = gs.textinput

  love.mousemoved    = gs.mousemoved
  love.mousepressed  = gs.mousepressed
  love.mousereleased = gs.mousereleased
  love.wheelmoved    = gs.wheelmoved

  gs.onstart(...)

end



return {

  new = NewState,

  switch = Switch,

}
