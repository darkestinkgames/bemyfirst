-- за аналогією з fnDrawables

function fnUpdatables(dt)
    for index, obj in ipairs(Updatables) do
        obj:update(dt)
    end
end

function fnInitUpdatables(obj)
    if obj.update then
        Updatables[#Updatables+1] = obj
    end
end

Updatables = {}