require 'script/test/mainreset'

love.graphics.setDefaultFilter("nearest", "nearest")

local anim8 = require 'script/test/libs/anim8-master/anim8'
local image, animation


function love.load()
    image = love.graphics.newImage('assets/sprite/MiniHorseMan.png')
    local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())

    Horsman = {}
    Horsman.ani_set = {
        idle = anim8.newAnimation(g('1-4',1), 0.15),
        walk = anim8.newAnimation(g('1-6',2), 0.1),
        attack = anim8.newAnimation(g('1-6',3), 0.15),
        hit = anim8.newAnimation(g('1-2',4), 0.2),
        jump = anim8.newAnimation(g('1-3',5), 0.25),
        death = anim8.newAnimation(g('1-6',6), 0.2),
    }
    Horsman.ani_state = 'walk' ---@type 'idle'|'walk'|'attack'|'hit'|'jump'|'death'
    Horsman.animation = Horsman.ani_set[Horsman.ani_state]
end

function love.update(dt)
    Horsman.animation:update(dt)
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
        local next_list = {
            idle = 'walk',
            walk = 'attack',
            attack = 'hit',
            hit = 'jump',
            jump = 'death',
            death = 'idle',
        }
        Horsman.ani_state = next_list[Horsman.ani_state]
        Horsman.animation = Horsman.ani_set[Horsman.ani_state]
    end
    if button == 2 then
        Horsman.animation:flipH()
    end
end