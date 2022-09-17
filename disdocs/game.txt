Gra = {
    data = {
        sprite = {
            love.image,
            ...,
            draw = function (self, N, x, y) end,
            add = function (self, filename, w, h) end,
        },
    },
    map = {
        files = {
            'filename',
            ...,
        },
        load = function (self, N) end,
        draw = function (self) end,
        data = {
            tile = {
                {
                    nazva = '',
                    zahyst = 0,
                    zem = { lvl = N, cost = N },
                    vod = { lvl = N, cost = N },
                    pov = { lvl = N, cost = N },
                    vartist = {},
                    spritecodes = {},
                },
                ...,
            },
            unit = {
                ...,
            },
            strc = {
                ...,
            },
        },
        spritecodes = {
            tile = {
                N = Game.map.data.tile[N],
                ...,
            },
            unit = {
                N = Game.map.data.unit[N],
                ...,
            },
            strc = {
                N = Game.map.data.strc[N],
                ...,
            },
        },
        grid = {
            cell = {
                xNyN = {
                    key = 'xNyN',
                    position = { x = N, y = N },
                    screen = { x = N, y = N },
                    nearest = { Gra.map.cell[N] },
                    sprites = { sN, sN, sN },
                    tile = Gra.data.map.cell[N] or nil,
                    strc = Gra.map.strc[N] or nil,
                    unit = Gra.map.unit[N] or nil,
                    draw = function (self) end,
                },
                ...,
            },
            strc = {
                ...,
            },
            unit = {
                -- стати
                hp = {
                    value = N,
                    max = N,
                    screen = N,
                },
                ap = {
                    value = N,
                    max = N,
                },
                -- інфа
                cell = Gra.map.cell[xNyN],
                screen = { x = N, y = N },
                -- дії
                mov = {
                    unit = Gra.map.unit[N],
                    cost = {ap = N, cd = N},
                    delay = N,
                    typ = string,
                    lvl = N,
                    pass = N,
                    value = N,
                    -- пошук шляху
                    grid = { xNyN = N }, -- варість шляху до кожної чарунки
                    ui = nil, -- 
                    path = { N = Gra.map.cell[N] },
                    --
                    pathUpdate = function (self) end, -- розрахувати вартість шляху до всіх чарунок
                    uiUpdate = function (self, xNyN) end, -- отримати пункт призначення й розрахувати шлях
                    actUpdate = function (self) end, -- робити пересування
                },
                atk = nil,
                cap = nil,
                --
                draw = function (self) end,
            },
        },
    },
    nums = {
        zero = 0,
        impass = 10,
    },
}