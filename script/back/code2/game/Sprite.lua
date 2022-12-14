---Усі спрайти гри тут
---@class gameSprite
---@field add fun(self: gameSprite, filename: string, width: number, height?: number) # Підвантажити спрайт-сет з файлу й додати до загального списку окремими спрайтами
---@field filter fun(self: gameSprite, min?: love.FilterMode, mag?: love.FilterMode) # Фільтр маштабування спрайтів

---@type gameSprite | love.Canvas[]
---Вивести вказаний спрайт на екран
---@overload fun(key: number, x?: number, y?: number)
Sprite = {}


---@diagnostic disable-next-line: param-type-mismatch
Sprite = setmetatable(Sprite, {
    __index = {
        add = function (list, filename, width, height)
            -- перевірка
            local image = love.graphics.newImage(filename)
            assert(width)
            height = height or width
            -- тех.дані
            local sw, sh = image:getDimensions()
            -- пройтись по кожному тайлу
            for y = 0, sh - 1, height do
                for x = 0, sw - 1, width do
                    -- зробити окремим зображенням
                    local sprite = love.graphics.newCanvas(width, height)
                    local quad = love.graphics.newQuad(x, y, width, height, sw, sh)
                    love.graphics.setCanvas(sprite)
                    love.graphics.draw(image, quad, 0, 0)
                    love.graphics.setCanvas()
                    -- завантажити у загальний список
                    table.insert(list, sprite)
                end
            end
        end,
        filter = function (list, min, mag)
            min = min or "nearest"
            mag = mag or min
            for key, sprite in pairs(list) do
                sprite:setFilter(min, mag)
            end
        end,
    },
    __call = function (list, sprite, x, y, scale)
        if list[sprite] then
            love.graphics.draw(list[sprite], x, y, nil, scale)
        end
    end,
})

Sprite:add('assets/sprite/medival16.png', 16)