---@class gameGrid
Grid = {
    cells = {}, ---@type table<string, objMapaCell>
    structures = {},
    units = {},

    selected_cell = nil, ---@type objMapaCell

    width = 0,
    height = 0,
    tilesize = 32,
    screen_width = 0,
    screen_height = 0,
}

function Grid:draw()
    --// love.graphics.setColor(1, 1, 1)
    --// for key, cell in pairs(self.cells) do
        --// for index, sprite in ipairs(cell.sprites) do
            --// Sprite(sprite, cell.screen_x, cell.screen_y)
        --// end
    --// end
end

function Grid:getTilesFrom(filename)
    self:reset()

    local data_input = require(filename)

    self.width = data_input.width
    self.height = data_input.height

    self.screen_width = self.width * self.tilesize
    self.screen_height = self.height * self.tilesize

    for i = 1, #data_input.layers[1].data do

        --// ---@class objGridCell
        --// local cell = {
        --//     sprites = {},
        --//     grid_x = (i - 1) % self.width + 1,
        --//     grid_y = math.floor((i - 1) / self.width + 1),
        --// }
        local cell = MapaCell:new()
        :setPosition((i - 1) % self.width + 1, math.floor((i - 1) / self.width + 1))

        for f = 1, #data_input.layers do
            cell:addSprite(data_input.layers[f].data[i])
            --// local sprite = data_input.layers[f].data[i]
            --// cell.sprites[#cell.sprites+1] = sprite
            --// cell.tile = MapaTileData.spritecodes[sprite] or cell.tile
        end

        --// cell.key = 'x' .. cell.grid_x .. 'y' .. cell.grid_y
        --// cell.screen_x = (cell.grid_x - 1) * self.tilesize
        --// cell.screen_y = (cell.grid_y - 1) * self.tilesize

        --// cell.strc = nil
        --// cell.unit = nil

        self.cells[cell.key] = cell
    end
end

function Grid:reset()
    for key in pairs(self.cells) do self.cells[key] = nil end
    for key in pairs(self.structures) do self.structures[key] = nil end
    for key in pairs(self.units) do self.units[key] = nil end
end

function Grid:getCell(x, y)
    x, y = math.ceil(x / self.tilesize), math.ceil(y / self.tilesize)
    return self.cells['x' .. x .. 'y' .. y]
end

--// fnInitDrawables(Grid)