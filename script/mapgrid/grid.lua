---@type map.grid
local grid = {
  cell_grid = {},
  strc_list = {},
  unit_list = {},

  width = 0,
  height = 0,
}

local cell = require 'script/mapgrid/cell'

function grid.reset()
  for key in pairs(grid.cell_grid) do grid.cell_grid[key] = nil end
  for key in pairs(grid.strc_list) do grid.strc_list[key] = nil end
  for key in pairs(grid.unit_list) do grid.unit_list[key] = nil end
  grid.width, grid.height = 0, 0
end

function grid.newCell(sprite, x,y)
  local c = cell.new()
end

function grid.newMap(filename)
  local inputdata = require(filename) ---@type map.file
  grid.reset()
  local width, height = inputdata.width, inputdata.height
  for index, layer in ipairs(inputdata.layers[1]) do
    local x,y, sprite_list = (index%width+1),math.floor(index/width+1), {}
    for i = 1, #inputdata.layers do
      local spritecode = layer[i]
      sprite_list[#sprite_list+1] = spritecode == 0 and nil or spritecode
    end
    grid.newCell(sprite_list, x,y)
  end
  grid.width, grid.height = width, height
end