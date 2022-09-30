-- усі прошарки карти знаходяться у головному контейнері
-- DataInput.layers

-- розмір карти можна брати звідти ж
-- DataInput.width
-- DataInput.height
-- або з кожного нашарування окремо
-- DataInput.layers[1].width
-- DataInput.layers[1].height

-- і список усіх тайлів на прошарку зберігається у власному контейнері
-- DataInput.layers[1].data
-- по суті це прямий масив з порядковими номерами

-- тобто в мене є купка однакових тайлів, але розкиданих по різних прошарках
-- отже, мені доведеться вирахувати координату х/у кожного тайлу з кожного нашарування
-- та згрупувати їх по цій координаті в окрему чарунку


---@param filename string # шлях до файлу
function getSpritecodeGrid(filename)
    local grid = {}

    local data_input = require(filename)
    local width = data_input.width

    for i = 1, #data_input.layers[1].data do
        local sprites = {
            x = (i - 1) % width + 1,
            y = math.floor((i - 1) / width + 1)
        }
        for f = 1, #data_input.layers do
            table.insert(sprites, data_input.layers[f].data[i])
        end

        grid[#grid+1] = sprites
    end

    return grid
end


-- local nrst = {0, -1, -1, 0, 1, 0, 0, 1}