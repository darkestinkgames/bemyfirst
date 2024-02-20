
local game_gs = GState.new()
function GState.game_gs() GState.switch(game_gs) end
print('[game_gs]')


local _______________shorts_______________ = 0


local la = love.audio
local lf = love.filesystem
local lg = love.graphics
local ls = love.system
local lw = love.window

local isKey = love.keyboard.isDown
local getMouse = love.mouse.getPosition


local _______________mess_______________ = 0
local _______________game_gs_______________ = 0
