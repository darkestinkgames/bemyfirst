---@param grid table<string, objMapCell>
---@param tilecodes gameDataTile[]
function initTiles(grid, tilecodes)
    local tilesize = 16
    for key, cell in pairs(grid) do
        cell.screen_x = cell.grid_x * tilesize
        cell.screen_y = cell.grid_y * tilesize
        cell.tile = tilecodes[cell.sprites[#cell.sprites]]
    end
end