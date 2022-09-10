Cooldown = {
    value = 1,
    on_turn = -1,
    count = 0,
}

do
    function Cooldown:new(value)
        local cpt = {
            value = value,
            count = 0,
            on_turn = 1,
        }
        for k, v in pairs(self.component) do
            cpt[k] = v
        end
        return cpt
    end

    setmetatable(Cooldown, {__call = Cooldown.new})
end

do
    local cpt = {}
    Cooldown.component = cpt
    
    function cpt:isReady()
        return 1 > self.count
    end
    
    function cpt:turn()
        self.count = math.max(0, self.count - self.on_turn)
    end
    
    function cpt:use()
        self.count = self.count + self.value
    end
end