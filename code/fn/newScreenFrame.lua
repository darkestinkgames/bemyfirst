-- межі відображення об’єктів
function newScreenFrame(a, b, c, d)
    ---@class objScreenFrame
    local frame = {
        x_min = a or 0,
        x_max = b or 1,
        y_min = c or 0,
        y_max = d or 1,
    }
    return frame
end