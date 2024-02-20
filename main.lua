
function love.load(...)

  Numbers = require 'scripts.mods.numbers'

  GState = require 'scripts.mods.GState'
  require 'scripts.state.game_gs'

  GState.game_gs()

end
