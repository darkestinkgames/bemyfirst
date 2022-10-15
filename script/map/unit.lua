
---@class map.Unit
local Unit = {}
local mtUnit = {}

function Unit:pathCost(cell) end
function Unit:pathReset() end
function Unit:pathUpdate() end
function Unit:pathDraw() end

function Unit:getTeam() end
function Unit:getPlayer() end
function Unit:getPathpoint(cell) end

function Unit:setCell(cell) end

function Unit:isReady() end -- чи готовий діяти? (очки дій/черга)

function Unit:actWait() end -- по факту: розміняти усі очки дій на витривалість
function Unit:actBuild(cell) end -- будувати усяке 
function Unit:actRegroup() end -- продати/звільнити
function Unit:actMove(cell) end -- пересуватися
function Unit:actMelee(cell) end -- атакувати (ближній бій) чарунку (тому, що будівлі можна руйнувати)
function Unit:actShoot(cell) end -- атакувати чарунку (дальній бій)
function Unit:actCapture(strc) end -- захопити будівлю
function Unit:actHire(unit) end -- найм
function Unit:actJoin(unit) end -- об’єднатися з пораненим юнітом того ж типу
function Unit:actLoad(cell) end -- загрузитися у транспорт
function Unit:actUnload(cell) end -- вигрузка
function Unit:actFly() end -- дехто вміє літати (зміна типу пересування)
function Unit:actLand() end -- літуни з амфібіями втрачають витривалість, доведеться повертатися на землю
function Unit:actDive() end -- покищо ніхто не вміє плавати, але нехай


local unit = {}

function unit.new(player, cell)
  ---@class map.Unit
  local obj = {
  }
  return setmetatable(obj, mtUnit)
end

return unit