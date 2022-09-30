function fnDrawables()
    for key, layer in pairs(Drawables) do
        for index, obj in ipairs(layer) do
            obj:draw()
        end
    end
end

function fnInitDrawables(obj, _layer)
    if obj.draw then
        Drawables[_layer or 1][#Drawables[_layer or 1]+1] = obj
    end
end

Drawables = {{}}