function getScreenResize(width, height)
    width = width or (30 * 16)
    height = height or (20 * 16)
    local map_k = width / height

    local w, h = love.graphics.getDimensions()
    local k = w / h

    local scale = k > map_k and h / height or w / width

    return (w / 2 - width * scale / 2), (h / 2 - height * scale / 2), scale
end