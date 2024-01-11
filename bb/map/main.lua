local data = require 'script/map/data'

data.setTile(32, 32)

local map = {}
local player_list = {}

local cell_grid = {} ---@type table<string, map.Cell>
local cell_list = {} ---@type map.Cell[]
local strc_list = {} ---@type map.Strc[]
local unit_list = {} ---@type map.Unit[]

local selected_cell ---@type map.Cell?
local selected_unit ---@type map.Unit?

local game = {
  round = 1,
  turn = 1,
  player_list = {},
}

function map.draw()
  for index, cell in ipairs(cell_list)
  do cell:draw() end
  for index, strc in ipairs(strc_list)
  do strc:draw() end
  if selected_unit then
    if    selected_unit.move.cell
    then  selected_unit:drawPathWay()
    else  selected_unit:drawPathPoint() end
  end
  for index, unit in ipairs(unit_list)
  do unit:draw() end
end
function map.update(dt)  end

function map.select(sx, sy)  end
function map.deselect()      end

function map.new(filename)  end

function map.newPlayer(team)
  local i = #player_list + 1
  ---@class map.Player
  local obj = {
    id         = i,          ---@type number
    team       = team or i,  ---@type number
    strc_list  = {},         ---@type map.Strc[]
    unit_list  = {},         ---@type map.Unit[]
  }
  player_list[#player_list+1] = obj
end
function map.newDemo(width, height)  end
function map.newUnitDemo(team)       end

return map