function gameResizeFit(size)
    local w, h = love.graphics.getDimensions()
    local k = w / h
    
    local map_w = 30 * 16
    local map_h = 20 * 16
    local map_k = map_w / map_h
    
    if size then
        Gra.scale = size
    else
        Gra.scale = k > map_k and h / map_h or w / map_w
    end
    map_x = w / 2 - map_w * Gra.scale / 2
    map_y = h / 2 - map_h * Gra.scale / 2
end