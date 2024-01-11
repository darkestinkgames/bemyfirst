
-------------------- { - } --------------------

---@class pre.sprite.core
local sprite = {
  new = nil, ---@type fun(filename:string, tileW:number, tileH?:number):pre.sprite.set
}

-------------------- { - } --------------------

---@class pre.sprite.solo
local objSpriteSolo = {
  spriteset = nil,  ---@type pre.sprite.set
  list      = nil,  ---@type number[]
  image     = nil,  ---@type love.Canvas?
  x         = nil,  ---@type number
  y         = nil,  ---@type number
  scale     = nil,  ---@type number
  draw      = nil,  ---@type fun(self:pre.sprite.set, x?:number, y?:number, scale?:number)
  drawSet   = nil,  ---@type fun(self:pre.sprite.set, x?:number, y?:number, scale?:number)
  drawImage = nil,  ---@type fun(self:pre.sprite.set, x?:number, y?:number, scale?:number)
  initImage = nil,  ---@type fun(self:pre.sprite.solo, ...:number)
}

local mtSpriteSolo = {__index = objSpriteSolo}

-------------------- { - } --------------------

---@class pre.sprite.set
local objSpriteSet = {
  image         = nil, ---@type love.Image
  quads         = nil, ---@type love.Quad[]
  default_scale = nil, ---@type number
  draw          = nil, ---@type fun(self:pre.sprite.set, index:number, x?:number, y?:number, scale?:number)
  newSprite     = nil, ---@type fun(self:pre.sprite.set, ...:number):pre.sprite.solo
}

local mtSpriteSet = {__index = objSpriteSet}

-------------------- { - } --------------------

return sprite