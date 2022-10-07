local pathpoint = require 'script/mapgrid/pathpoint'
local cell = require 'script/mapgrid/cell'

---@class map.grid
local grid = {tilesize = 32}
local cell_grid ---@type table<string, map.cell>
local strc_list -- -@type map.strc[]
local unit_list -- -@type map.unit[]
local mapW, mapH = 0, 0

function grid.newPathfinder()
  local obj = {}
  for k, c in pairs(cell_grid) do
    obj[k] = pathpoint.new(c)
  end
  return obj
end

function grid.newCell(code_list, x,y)
  for
  local c = cell.new(code_list, x,y):initScreen(grid.tilesize)
  cell_grid[c.key] = c
  local s = strc.new
end

function grid.newMap(filename)
  local inputdata = require(filename) ---@type map.file

  cell_grid, strc_list, unit_list = {}, {}, {}
  mapW, mapH = inputdata.width, inputdata.height

  for i in ipairs(inputdata.layers[1]) do
    local x,y, code_list = (i%mapW+1),math.floor(i/mapW+1), {}
    for l = 1, #inputdata.layers do
      local sc = inputdata.layers[l][i]
      code_list[#code_list+1] = sc == 0 and nil or sc
    end
    grid.newCell(code_list, x,y)
  end
end

return grid