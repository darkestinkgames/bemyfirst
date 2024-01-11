function getCopy(from, into)
    into = into or {}
    for key, value in pairs(from) do
        into[key] = type(value) == 'table' and getCopy(value) or value
    end
    return into
end