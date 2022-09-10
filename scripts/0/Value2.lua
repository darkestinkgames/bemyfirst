Value = {}

function Value:new(...)
    local obj = setmetatable(
        {
            sync_default = 1,
            init = init,
            sync = sync,
        },
        {__call = self.init})
    return obj(...)
end

function Value:init(...)
    local a = {...}
    self.min = #a == 1 and 0 or math.min(...)
    self.max = math.max(...)
    self.current = self.max
    return self
end

function Value:call(...)
    local value = {...}
    if value[1] == 'table' then
        -- return 
    end
end

function Value:sync(from)
    local delta_self = self.max - self.min
    local delta_from = from.max - from.min
    self.current = from.current * delta_self / delta_from + self.min
    return self.current
end

function Value:syncFloor(from)
    local delta_self = self.max - self.min
    local delta_from = from.max - from.min
    self.current = math.floor(from.current * delta_self / delta_from + self.min)
    return self.current
end


do
    Value = setmetatable(Value, {__call = new})
end