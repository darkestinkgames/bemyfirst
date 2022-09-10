---@class game.Ctrl
---@field getFocus fun(): FocusValue
Ctrl = {
    focus = {
        map = nil,
        ui = nil,

        ---@type FocusValue
        value = nil,
    },

    ---@type FocusInput
    player = 'mouse',

    -- -- навряд чи буде, та якщо буде попит хот-сіт — реалізую приблизно так
    -- ---@type FocusInput[]
    -- player = {
    --     'mouse', -- гравець №1
    --     'gpad', -- гравець №2
    --     -- і т.ін.
    -- },
}

function Ctrl:getFocus()
    return self.focus.ui or self.focus.map
end

---@alias FocusValue 'map'|'ui'|nil
---@alias FocusInput 'mouse'|'touch'|'gpad'|'kb'