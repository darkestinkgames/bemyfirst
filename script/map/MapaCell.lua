---@class objMapaCell
MapaCell = {}

function MapaCell:new()
    ---@class objMapaCell
    local obj = {
        key = '',

        grid_x = 0,
        grid_y = 0,

        screen_x = 0,
        screen_y = 0,

        tile = nil,
        strc = nil,
        unit = nil,

        spriteset = {},

        -- todo
        -- aniset = {
        --     idle = {
        --         frame_spriteset_list = {
        --             {},
        --             {},
        --             dt = 0,2, 
        --         },
        --         frame = 1, -- 1 -> #spriteset_list
        --         dt = 0,
        --     },
        --     etc = nil,
        -- },

        draw = function () end,
        update = function () end,

        -- addSprite = function () end,

        -- fInitKey = function () end,
        initAniSet = function () end,

        -- fSetTileData = function () end,
        -- fInitScreen = function () end,

        -- setPosition = function () end,
    }

    for key, fn in pairs(self) do obj[key] = fn end

    fnInitDrawables(obj)
    return obj
end

-- 

function MapaCell:draw()
    love.graphics.setColor(1, 1, 1)
    self:fDrawSpriteset()
end
-- додатковий функціонал
-- * self:fInitKey() — визначає ключ
-- * self:fInitScreen() — розраховує координати на екрані
function MapaCell:setPosition(x, y)
    self.grid_x = x
    self.grid_y = y

    self:fInitKey()
    self:fInitScreen()

    return self
end
-- додатковий функціонал
-- * self:fSetTileData(sprite) — встановлює інф-у про ландашфт
function MapaCell:addSprite(sprite)
    if Sprite[sprite] then
        print(sprite)
        self.spriteset[#self.spriteset+1] = sprite

        self:fSetTileData(sprite)
    end
end

-- 

function MapaCell:fDrawSpriteset()
    for index, number in ipairs(self.spriteset) do
        Sprite(number, self.screen_x, self.screen_y, 2)
    end
end
function MapaCell:fInitScreen()
    self.screen_x = (self.grid_x - 1) * Grid.tilesize
    self.screen_y = (self.grid_y - 1) * Grid.tilesize
end
function MapaCell:fInitKey()
    self.key = 'x' .. self.grid_x .. 'y' .. self.grid_y
end
function MapaCell:fSetTileData(sprite)
    self.tile = MapaTileData.spritecodes[sprite] or self.tile
end

-- 
