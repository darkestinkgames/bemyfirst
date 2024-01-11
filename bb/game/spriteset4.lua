
-------------------- { - } --------------------

---@class pre.spritecore
local sprite = {
  new = nil, ---@type fun(filename:string, tileW:number, tileH?:number):pre.spriteset
}


-------------------- { - } --------------------

---@class pre.spritesolo
local objSpriteSolo = {
  -- spriteset = nil,  ---@type pre.spriteset
  -- list      = nil,  ---@type number[]
  image     = nil,  ---@type love.Canvas?
  x         = nil,  ---@type number
  y         = nil,  ---@type number
  scale     = 1,
  draw        = nil,  ---@type fun(self:pre.spriteset, x?:number, y?:number, scale?:number)
  -- drawSet     = nil,  ---@type fun(self:pre.spriteset, x?:number, y?:number, scale?:number)
  -- drawImage   = nil,  ---@type fun(self:pre.spriteset, x?:number, y?:number, scale?:number)
  -- initImage   = nil,  ---@type fun(self:pre.spritesolo, rescale?:number)
  -- setPosition = nil,  ---@type fun(self:pre.spritesolo, x:number, y:number)
}

function objSpriteSolo:setPosition(x,y)
  self.x = x
  self.y = y
  return self
end

function objSpriteSolo:initImage(rescale)
  local width, height = self.spriteset.tileW*rescale, self.spriteset.tileH*rescale
  self.scale = 1
  self.spriteset.image:setFilter("nearest", "nearest")

  local canvas = love.graphics.newCanvas(width, height)
  love.graphics.setCanvas(canvas)
  love.graphics.push()
  love.graphics.scale(rescale, rescale)
  self:draw(0,0)
  love.graphics.pop()
  love.graphics.setCanvas()

  self.image = canvas
  self.draw = self.drawImage
end

function objSpriteSolo:drawImage(x,y, scale)
  love.graphics.draw(self.image, x,y, nil, scale or self.scale)
end

function objSpriteSolo:drawSet(x,y, scale)
  for i, v in ipairs(self.list) do
    self.spriteset(v, x or self.x,y or self.y, scale or self.scale)
  end
end

local mtSpriteSolo = {__index = objSpriteSolo}


-------------------- { - } --------------------

---@class pre.spriteset
local objSpriteSet = {
  scale = 1,
  -- image     = nil, ---@type love.Image
  -- quads     = nil, ---@type love.Quad[]
  -- draw      = nil, ---@type fun(self:pre.spriteset, index:number, x?:number, y?:number, scale?:number)
  -- newSprite = nil, ---@type fun(self:pre.spriteset, ...:number):pre.spritesolo
}

function objSpriteSet:draw(index, x,y, scale)
  assert(self.images[index], "Нема таких спрайтів")
  love.graphics.draw(self.images[index], x,y, nil, scale or self.scale)
end

function objSpriteSet:newSprite(...)
  local input, list = {...}, {}
  if type(input[1]) == "table" then input = input[1] end
  for i, v in ipairs(input) do list[#list+1] = self.images[v] and v or nil end
  if #list == 0 then print( ('Валідних значень: %s'):format(#list) ) end

  ---@class pre.spritesolo
  local obj = {
    spriteset = self,
    list = list,
    draw = objSpriteSolo.drawSet,
  }

  return setmetatable(obj, mtSpriteSolo)
end

local mtSpriteSet = {__index = objSpriteSet, __call = objSpriteSet.draw}


-------------------- { - } --------------------

function sprite.newScale(scale, filename, tileW, tileH)
  tileH = tileH or tileW

  local image  = love.graphics.newImage(filename)
  local sw, sh = image:getDimensions()
  local images  = {}

  tileW, tileH = tileW*scale, tileH*scale
  sw,sh = sw*scale, sh*scale
  image:setFilter("nearest", "nearest")

  for y = 0, sh-1, tileH do for x = 0, sw-1, tileW do
    local quad = love.graphics.newQuad(x,y, tileW,tileH, sw,sh)
    local canvas = love.graphics.newCanvas(tileW, tileH)
    love.graphics.setCanvas(canvas)
    love.graphics.draw(image, quad)
    love.graphics.setCanvas()
    images[#images+1] = canvas
  end end

  ---@class pre.spriteset
  local obj = {
    -- image = canvas,
    -- quads = quads,
    images = images,
    tileW = tileW,
    tileH = tileH,
  }

  return setmetatable(obj, mtSpriteSet)
end

-- function sprite.new(filename, tileW, tileH)
--   tileH = tileH or tileW

--   local image  = love.graphics.newImage(filename)
--   local sw, sh = image:getDimensions()
--   local quads  = {}

--   for y = 0, sh-1, tileH do for x = 0, sw-1, tileW do
--     quads[#quads+1] = love.graphics.newQuad(x,y, tileW,tileH, sw,sh)
--   end end

--   ---@class pre.spriteset
--   local obj = {
--     image = image,
--     quads = quads,
--     tileW = tileW,
--     tileH = tileH,
--   }
--   return setmetatable(obj, mtSpriteSet)
-- end

return sprite





--[[ ] ]

-- love.graphics.setDefaultFilter("nearest", "nearest") -- швидкий фікс

-------- { - } --------

---@class map.sprite
local objSprite = {}

function objSprite:draw()
  love.graphics.draw(self.image, self.x,self.y)
end

function objSprite:setPosition(x, y)
  self.x = x
  self.y = y
  return self
end

local mtSprite = {__index = objSprite}

-------- { - } --------

---@class map.spriteset
local objSpriteset = {}

function objSpriteset:newSprite(i, x,y, scale)
  -- assert(self.quads[i], ("The `quad` No [%s] is not exist!"):format(i))
  if self.images[i] then
    ---@class map.sprite
    local obj = {
      image = self.images[i],
      x = x,
      y = y,
      scale = scale or self.scale,
    }
    return setmetatable(obj, mtSprite)
  end
  return nil
end

function objSpriteset:draw(i, x,y)
  assert(self.images[i], ("The `quad` No [%s] is not exist!"):format(i))
  love.graphics.draw(self.image[i], x,y)
end

local mtSpriteset = {__index = objSpriteset}


-------- { - } --------

local spriteset = {}

function spriteset.new(filename, width, height)
  height = height or width

  local image  = love.graphics.newImage(filename)
  local sw, sh = image:getDimensions()
  local quads  = {}

  local canvas = love.graphics.newCanvas(sw, sh)
  love.graphics.setCanvas(canvas)
  love.graphics.draw(image)
  love.graphics.setCanvas()

  for y = 0, sh-1, height do for x = 0, sw-1, width do
    quads[#quads+1] = love.graphics.newQuad(x,y, width,height, sw,sh)
  end end

  local obj = { ---@class map.spriteset
    image = canvas,
    quads = quads,
    scale = 1 }

  return setmetatable(obj, mtSpriteset)
end

function spriteset.newScaling(filename, scaling, width, height)
  height = height or width

  local image  = love.graphics.newImage(filename)
  local sw, sh = image:getDimensions()
  local images  = {}

  sw, sh = sw * scaling, sh * scaling
  width, height = width * scaling, height * scaling
  image:setFilter("nearest", "nearest")

  for y = 0, sh-1, height do for x = 0, sw-1, width do
    local quad = love.graphics.newQuad(x,y, width,height, sw,sh)

    local canvas = love.graphics.newCanvas(width, height)
    love.graphics.setCanvas(canvas)
    love.graphics.draw(image, quad, nil)
    love.graphics.setCanvas()

    images[#images+1] = canvas
  end end

  local obj = { ---@class map.spriteset
    images = images,
    scale = 1 }

  return setmetatable(obj, mtSpriteset)
end


-------- { - } --------

return spriteset

--[[ ]]