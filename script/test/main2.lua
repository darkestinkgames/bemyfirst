require 'script/test/mainreset'

love.graphics.setDefaultFilter("nearest", "nearest")

local ups = require 'script/test/libs/updatables'

local anim8 = require 'script/libs/anim8-master/anim8'
local image


function love.load()
    image = love.graphics.newImage('assets/sprite/mf_humans/MiniHorseMan.png')
    local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())

    Horsman = {}
    Horsman.ani_data = {
        idle = anim8.newAnimation(g('1-4',1), 0.15),
        walk = anim8.newAnimation(g('1-6',2), 0.1),
        attack = anim8.newAnimation(g('1-6',3), 0.15),
        hit = anim8.newAnimation(g('1-2',4), 0.2),
        jump = anim8.newAnimation(g('1-3',5), 0.25),
        death = anim8.newAnimation(g('1-6',6), 0.2),
    }
    for key, ani in pairs(Horsman.ani_data) do ani.key = key print(ani.key) end

    -- Horsman.animation.n
    --? Horsman.ani_state = 'walk' ---@type 'idle'|'walk'|'attack'|'hit'|'jump'|'death'
    Horsman.animation = Horsman.ani_data.idle
    ups:addItem(Horsman):setField('animation')
end

function love.update(dt)
    ups:update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(2, 2)

    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 32, 32, 32, 32)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(Horsman.animation.position, 32, 18)
    Horsman.animation:draw(image, 32, 32)

    love.graphics.pop()
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local _next_list = {
            idle = 'walk',
            walk = 'attack',
            attack = 'hit',
            hit = 'jump',
            jump = 'death',
            death = 'idle',
        }
        Horsman.animation = Horsman.ani_data[_next_list[Horsman.animation.key]]
    end
    if button == 2 then
        Horsman.animation:flipH()
    end
end
