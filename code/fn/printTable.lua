---Вивести зміст таблиці
---@param obj table таблиця на друк
---@param max any на скільки рівнів
function printTable(...)
    local obj = nil
    local max = 4
    local name = ''

    local input = {...}
    for key, value in pairs(input) do
        if type(value) == "table" then
            obj = value
        end
        if type(value) == "number" then
            max = value
        end
        if type(value) == "string" then
            name = value
        end
    end

    local pre_key = '['
    local post_key = '] '

    -- 
    function output(obj, pre_key, lvl)
        lvl = (lvl or 0) + 1
        for key, value in pairs(obj) do
            print(pre_key .. key .. post_key .. tostring(value))
            if type(value) == "table" and max > lvl then
                output(value, '   ' .. pre_key, lvl)
            end
        end
    end

    -- фінал
    print('----> ' .. name)
    output(obj, pre_key)
    print('----<')
end