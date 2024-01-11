
---- { - } ----

---@class game.spriteset
local objSpriteset = {}

function objSpriteset:draw(index, x,y, scale)
  love.graphics.draw(self.image,self.quads[index], x,y, nil, scale or self.scale)
end

local mtSpriteset = {__index = objSpriteset, __call = objSpriteset.draw}

---- { - } ----

local sprite = {}

function sprite.new(filename, tileW,tileH)
  tileH = tileH or tileW

  local image = love.graphics.newImage(filename)
  local sw, sh = image:getDimensions()
  local quads = {}

  for y = 0, sh-1, tileH do for x = 0, sw-1, tileW do
    quads[#quads+1] = love.graphics.newQuad(x,y, tileW,tileH, sw,sh)
  end end

  ---@class game.spriteset
  local obj = {
    image = image,
    quads = quads,
    scale = 1,
  }

  return setmetatable(obj, mtSpriteset)
end

return sprite