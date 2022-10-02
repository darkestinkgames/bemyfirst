-- замість того, щоб відображати кожен об’єкт окремо, трохи систематизую процес на час тастування

function fnDrawables()
    for key, layer in pairs(Drawables) do
        for index, obj in ipairs(layer) do
            obj:draw()
        end
    end
end

function fnInitDrawables(obj, layer)
    if obj.draw then
        Drawables[layer or 1][#Drawables[layer or 1]+1] = obj
    end
end

Drawables = {{}}