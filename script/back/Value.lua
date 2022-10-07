Value = {}
do
    function init(self, ...)
        local a = {...}
        self.min = #a == 1 and 0 or math.min(...)
        self.value = self.min
        self.max = math.max(...)
        return self
    end
    function sync(self, from)
        local delta_self = self.max - self.min
        local delta_from = from.max - from.min
        self.value = from.value * delta_self / delta_from + self.min
        return self.value
    end
    function syncFloor(self, from)
        local delta_self = self.max - self.min
        local delta_from = from.max - from.min
        self.value = math.floor(from.value * delta_self / delta_from + self.min)
        return self.value
    end
    function new(self, ...)
        local obj = {
            init = init,
            sync = sync,
        }
        return obj:init(...)
    end
    Value = setmetatable(Value, {__call = new})
end