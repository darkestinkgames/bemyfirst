


local function newMovement(range, pass)
  ---@class map.UnitMov
  local obj = {
    name   = "",
    range  = range,
    pass   = pass,
    ap     = 1,
    delay  = 1,
    cd     = 0,
  }
  return obj
end


---@class map.Unit
local Unit = {}
local mtUnit = {}

function Unit:pathCost(cell) end
function Unit:pathReset()
  for key, pp in pairs(self.pathpoint_list)
  do pp:reset() end
end
function Unit:pathUpdate() end
function Unit:pathDraw()
  if self.target then
    local pp = self:getPathpoint(self.target)
    while pp do
      pp:draw()
      pp = pp.from
    end
  else
    for key, pp in pairs(self.pathpoint_list)
    do pp:draw() end
  end
end

function Unit:getTeam()
  return self.owner.team
end
function Unit:getPlayer()
  return self.owner.id
end
function Unit:getPathpoint(cell) ---@param cell map.Cell
  return self.pathpoint_list[cell.key]
end

function Unit:setCell(cell)
  assert(not cell.unit, "Десь трапилась помилка")
  self.cell.unit = nil
  self.cell, cell.unit = cell, self
end

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

---@param owner map.Player
---@param cell map.Cell
---@return map.Unit
function unit.new(owner, movement, cell)
  ---@class map.Unit
  local obj = {
    pathpoint_list = {}, ---@type table<string, map.PathPoint>
    owner   = owner,  ---@type map.Player  # гравець та команда
    cell    = cell,   ---@type map.Cell    # місце розташування
    target  = nil,    ---@type map.Cell?   # пункт призначення
  }
  return setmetatable(obj, mtUnit)
end

return unit