
local data = {
  width       = nil,  ---@type number  ширина карти, чарунок
  height      = nil,  ---@type number  висота
  tilewidth   = nil,  ---@type number  ширина тайла однієї чарунки
  tileheight  = nil,  ---@type number  висота
}

function data.getTileSize(kw, kh)
  return data.tilewidth * (kw or 1), data.tileheight * (kh or 1)
end
function data.getMapSize()
  return data.width, data.height
end
function data.setTileSize(w, h)
  data.tilewidth, data.tileheight = w, h
end
function data.setMapSize(w, h)
  data.width, data.height = w, h
end

return data