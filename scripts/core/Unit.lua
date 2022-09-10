---@class grid.Unit
---@field move Unit.action.move

Unit = {}

function Unit.path(self)
    -- прибрати попередні розрахунки
    for key in pairs(self.move.path) do
        self.move.path[key] = nil
    end
    for key in pairs(self.move.ui) do
        self.move.ui[key] = nil
    end

    -- початкові налаштування
    local check = {self.cell} -- масив чарунок, які треба перевірити
    -- print('Unit path', self.cell.zem)
    -- printTable(self.cell, 2)
    self.move.path[self.cell.key] = self.move.lvl > self.cell.data[self.move.typ].lvl and 0 or 9

    -- 
    while check[1] do
        local from = check[1]
        for index, into in ipairs(from.nearest) do
            local cost_new = getMapCost(self, into) + self.move.path[from.key]
            local cost_old = self.move.path[into.key] or cost_new + 1
            if cost_old > cost_new then
                self.move.path[into.key] = cost_new
                if self.move.value >= cost_new then
                    self.move.ui[into.key] = true
                end
                table.insert(check, into)
            end
        end
        table.remove(check, 1)
    end
end

function Unit.draw(self)
    love.graphics.setColor(0, 0, 0, 0.15)
    love.graphics.rectangle("fill", Map[self.cell.key].screen.x, Map[self.cell.key].screen.y, Gra.tile.width, Gra.tile.height)
    love.graphics.setColor(1, 1, 1)
    for _, value in pairs(self.animation) do
        -- print(value)
        Sprite(value, self.cell.screen())
    end
    love.graphics.setColor(1, 1, 1, 0.45)
    for key in pairs(self.move.ui) do
        love.graphics.rectangle("fill", Map[key].screen.x, Map[key].screen.y, Gra.tile.width, Gra.tile.height)
    end
end

do
    -- local obj = {team = nil}
end

function Unit:new(x, y)
    local cell = Map(x, y)
    if cell then
        ---@type game.Unit
        local obj = {
            -- animation = {246},
            -- animation = {116},
            animation = {132},
            cell = cell,
            -- move = Move:newPihota(3), -- компонент пересування
            -- move = Move:newVershnyk(6), -- компонент пересування
            move = Move:kolesa(7), -- компонент пересування
            updatePath = Unit.path,
            draw = Unit.draw,
        }
        obj:updatePath()
        return obj
    end
    return nil
end



-- printTable(Unit:new(1, 1), 'Unit')