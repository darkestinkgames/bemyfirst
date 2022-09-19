function setGameFont()
    MyFont = love.graphics.newFont('font/Neucha/Neucha-Regular.ttf', 24, "normal")
    MyFont:setFilter('linear' , 'linear')
    love.graphics.setFont(MyFont)
end