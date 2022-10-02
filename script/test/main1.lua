require 'script/test/mainreset'
require 'script/fn/fnPrintTable'

love.graphics.setDefaultFilter("nearest", "nearest")


-- ! -- ! -- ! --


function love.draw()
    love.graphics.push()
    love.graphics.scale(2, 2)

    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 125, 125, 32, 32)
    love.graphics.setColor(1, 1, 1)

    MiniHorseMan:sprite(5, 125, 25)

    AniSet:draw()

    love.graphics.pop()
end
function love.update(dt)
    AniSet:update(dt)
end
function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local next_list = {
            idle = 'walk',
            walk = 'attack',
            attack = 'hit' ,
            hit = 'jump' ,
            jump = 'death' ,
            death = 'idle' ,
        }
        AniSet.state = next_list[AniSet.state]
        printTable(AniSet)
    end
    if button == 2 then
        MiniHorseMan.side = -MiniHorseMan.side
    end
end

-- ! -- ! -- ! --


---@class test.SpriteSheet
SpriteSheet = {}

function SpriteSheet:new(filename, _tilewidth, _tileheight)
    _tileheight = _tileheight or _tilewidth

    local image = love.graphics.newImage(filename)
    local sw, sh = image:getDimensions()

    ---@class test.SpriteSheet
    local obj = {
        canvas = love.graphics.newCanvas(sw, sh),
        quad = {},

        tilewidth = _tilewidth,
        tileheight = _tileheight or _tilewidth,

        ox = 16,
        oy = 0,

        side = -1, ---@type 1|-1
    }

    love.graphics.setCanvas(obj.canvas)
    love.graphics.draw(image)
    love.graphics.setCanvas()

    for y = 0, sh-1, _tileheight do
        for x = 0, sw-1, _tilewidth do
            obj.quad[#obj.quad+1] = love.graphics.newQuad(x, y, _tilewidth, _tileheight, sw, sh)
        end
    end

    for key, value in pairs(self) do obj[key] = value end
    return obj
end
function SpriteSheet:setOffset(kx, ky)
    self.ox = self.tilewidth * kx
    self.oy = self.tileheight * ky
    return self
end

function SpriteSheet:sprite(sprite, x, y)
    if self.quad[sprite] then
        love.graphics.draw(self.canvas, self.quad[sprite], x or 0, y or 0, nil, self.side, 1, self.ox, self.oy)
    end
end


-- ! -- ! -- ! --

MiniHorseMan = SpriteSheet:new('assets/sprite/MiniHorseMan.png', 32):setOffset(0.5, 0.5)

-- ! -- ! -- ! --

AniSet = {
    src = MiniHorseMan,

    state_list = {
        idle = { 1,2,3,4, dt = 0.15 },
        walk = { 7,8,9,10,11,12, dt = 0.1 },
        attack = { 13,14,15,16,17,18, dt = 0.15 },
        hit = { 19,20, dt = 0.2 },
        jump = { 25,26,27, dt = 0.25 },
        death = { 31,32,33,34,35,36, dt = 0.2 },
    },
    state = 'attack', ---@type 'idle'|'walk'|'jump'|'attack'|'hit'|'death'

    --[[

        ! Horseman/Cavalier
        * Idle - 4/4 frames
        * Walk - 6/6 frames
        * Jump  - 3/3 frames
        * Attack - 6/6 frames
        * Hit - 2/2 frames
        * Death - 6/6 frames

    ]]

    frame = 1,
    dt = 0,
    x = 125,
    y = 125,
}
function  AniSet:draw()
    local a = self.state_list[self.state]
    local b = a[self.frame]
    print(b)
    love.graphics.print( b, self.x, self.y - 14)
    self.src:sprite(self.state_list[self.state][self.frame], self.x, self.y)
end

function AniSet:update(dt)
    self.dt = self.dt + dt
    if self.dt > self.state_list[self.state].dt then
        self.dt = self.dt % self.state_list[self.state].dt
        self.frame = self.frame + 1
        if self.frame > #self.state_list[self.state] then
            self.frame = 1
        end
    end
end

