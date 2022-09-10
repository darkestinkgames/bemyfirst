function setGameFont()
    MyFont = love.graphics.newFont('font/Neucha/Neucha-Regular.ttf', 24, "normal")
    MyFont:setFilter('nearest', 'nearest')
    love.graphics.setFont(MyFont)
end