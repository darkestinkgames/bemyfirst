---Вивести зміст таблиці
---@param obj table таблиця на друк
---@param max any на скільки рівнів
function printTable(obj, max)
    local max = max or 4
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
    print('---->')
    output(obj, pre_key)
    print('----<')
end