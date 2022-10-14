local width, height
local tilewidth, tileheight

local data = {}

function data.getTile(kw, kh)
  return tilewidth * (kw or 1), tileheight * (kh or 1)
end
function data.getMap()
  return width, height
end
function data.setTile(w, h)
  tilewidth, tileheight = w, h
end
function data.setMap(w, h)
  width, height = w, h
end

return data