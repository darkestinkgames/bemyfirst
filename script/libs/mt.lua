--[[

objClass = {}

~mtClass = {__index = objClass} <br />
local obj = setmetatable({}, mtClass)~

local obj = mt.getMt(objClass)

]]
local mt = {}

local mts = {}

function mt.setMt(obj, from)
  print( type(obj), type(from) )
  assert(type(from) == "table" and type(obj) == "table")
  local key = tostring(from)
  if not mts[key]
  then mts[key] = {__index = from} end
  return setmetatable(obj, mts[key])
end

function mt.setCall(objClass, fn)
  assert(type(objClass) == "table")
  local key = tostring(objClass)
  mts[key].__call = fn
end

return setmetatable(mt, {__index = mt.setCall})