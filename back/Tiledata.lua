Tiledata = {}

-- pass зберігає вартість входу по землі та по воді
-- zem, vod
-- а також необхідний рівень для входження
-- nazem, navod
-- рівень загону має бути вищим за рівень входження

Tiledata.tiles = {
    -- (1) Фортеця
    {
        nazva = 'Фортеця',
        -- nazva = 'Fortetcia',
        pass = {zem = 1, nazem = 0, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 1, verhy = 1, kolesom = 1},
        vartist = {},
        ukryttya = 4,
        tilecodes = {50,51,52,53,54,55,56,57,58,59,60,61,62},
    },
    -- (1) Дорога
    {
        nazva = 'Дорога',
        -- nazva = 'Doroga',
        pass = {zem = 1, nazem = 0, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 1, verhy = 1, kolesom = 1},
        vartist = {},
        ukryttya = 0,
        tilecodes = {64,65,66,67,68,69,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90},
    },
    -- (1) Місток
    {
        nazva = 'Міст',
        -- nazva = 'Mist',
        pass = {zem = 1, nazem = 0, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 1, verhy = 1, kolesom = 1},
        vartist = {},
        ukryttya = 0,
        tilecodes = {241,242,243,244},
    },
    -- (2) Галявина
    {
        nazva = 'Галявина',
        -- nazva = 'Galiavina',
        pass = {zem = 2, nazem = 0, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 1, verhy = 1, kolesom = 2},
        vartist = {},
        ukryttya = 1,
        tilecodes = {1,2},
    },
    -- (2) Узбережжя
    {
        nazva = 'Узбережжя',
        -- nazva = 'Uzberezhzhia',
        pass = {zem = 2, nazem = 0, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 1, verhy = 1, kolesom = 2},
        vartist = {},
        ukryttya = 0,
        tilecodes = {176,177,178,179,180,181,183,185,186,188,190,191,192,193,194,195,197,202,204,206,207,209,211,216},
    },
    -- (3) Золота руда
    {
        nazva = 'Золота руда',
        -- nazva = 'Zolota ruda',
        pass = {zem = 4, nazem = 1, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 2, verhy = 3, kolesom = 99},
        vartist = {},
        ukryttya = 2,
        tilecodes = {210},
    },
    -- (3) Ліс
    {
        nazva = 'Ліс',
        -- nazva = 'Lis',
        pass = {zem = 3, nazem = 0, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 1, verhy = 2, kolesom = 3},
        vartist = {},
        ukryttya = 3,
        tilecodes = {5,6,7},
    },
    -- (3) Схили
    {
        nazva = 'Схили',
        -- nazva = 'Skhili',
        pass = {zem = 3, nazem = 0, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 1, verhy = 2, kolesom = 3},
        vartist = {},
        ukryttya = 1,
        tilecodes = {14},
    },
    -- (4) Гори
    {
        nazva = 'Гори',
        -- nazva = 'Gori',
        pass = {zem = 4, nazem = 1, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 2, verhy = 99, kolesom = 99},
        vartist = {},
        ukryttya = 4,
        tilecodes = {11,12,13},
    },
    -- (4) Річка
    {
        nazva = 'Річка',
        -- nazva = 'Richka',
        pass = {zem = 4, nazem = 1, vod = 9, navod = 9, pov = 1, povit = 0},
        -- vartist = {pishky = 2, verhy = 99, kolesom = 99},
        vartist = {},
        ukryttya = 0,
        tilecodes = {92,93,94,95,96,99,100,101,102,103,106,107,108},
    },
    -- Глибокі води
    {
        nazva = 'Море',
        -- nazva = 'More',
        pass = {zem = 9, nazem = 9, vod = 1, navod = 0, pov = 1, povit = 0},
        -- vartist = {pishky = 99, verhy = 99, kolesom = 99},
        vartist = {},
        ukryttya = 0,
        tilecodes = {169,170,171,172},
    },
    -- Рифи
    {
        nazva = 'Рифи',
        -- nazva = 'Rifi',
        pass = {zem = 9, nazem = 9, vod = 1, navod = 1, pov = 1, povit = 0},
        -- vartist = {pishky = 99, verhy = 99, kolesom = 99},
        vartist = {},
        ukryttya = 0,
        tilecodes = {239,240},
    },
}

Tiledata.codes = {}
do
    for key, value in ipairs(Tiledata.tiles) do
        for f, id in ipairs(value.tilecodes) do
            Tiledata.codes[id] = key

            -- print(key, id)
        end
    end
end