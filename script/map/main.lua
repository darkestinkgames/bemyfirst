local data = require 'script/map/data'

data.setTile(32, 32)

local map = {}

local cell_grid = {}
local cell_list = {}

local game = {
  round = 1,
  turn = 1,
  player_list = {},
}

function map.draw()      end
function map.update(dt)  end

function map.select(sx, sy)  end
function map.deselect()      end

function map.new(filename)  end

function map.newDemo(width, height)  end
function map.newUnitDemo(team)       end

return map