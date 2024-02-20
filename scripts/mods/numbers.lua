
--[[

масив чисел
+ мат.операції між масивами
+ мат.операції між масивом і числом
? якщо довжина різна — за основу йде найкоротший
- не можна порівнювати зі звичайним числом
- мета-довжина # в луа 5.1 не підтримується
! мета-функція для нових значеть + розпакувати
! мета-tostring

]]



local max   = math.max
local min   = math.min
local floor = math.floor
local ceil  = math.ceil

local concat = table.concat



local mt = {}

---@overload fun(...:number):number[]
local main = {}



local function new()
  return setmetatable({}, mt)
end

local function check(a,b)
  if type(a) == 'number' then
    local t = new()
    for i = 1, #b do t[i] = a end
    return t,b
  end
  if type(b) == 'number' then
    local t = new()
    for i = 1, #a do t[i] = b end
    return a,t
  end
  return a,b
end



mt.__index = {}



mt.__add = function (a, b)
  a,b = check(a,b)
  local len, t = min(#a,#b), new()
  for i = 1, len do t[i] = a[i] + b[i] end
  return t
end

mt.__sub = function (a, b)
  a, b = check(a,b)
  local len, t = min(#a,#b), new()
  for i = 1, len do t[i] = a[i] - b[i] end
  return t
end

mt.__mul = function (a, b)
  a, b = check(a,b)
  local len, t = min(#a,#b), new()
  for i = 1, len do t[i] = a[i] * b[i] end
  return t
end

mt.__div = function (a, b)
  a, b = check(a,b)
  local len, t = min(#a,#b), new()
  for i = 1, len do t[i] = a[i] / b[i] end
  return t
end

mt.__pow = function (a, b)
  a, b = check(a,b)
  local len, t = min(#a,#b), new()
  for i = 1, len do t[i] = a[i] ^ b[i] end
  return t
end

mt.__unm = function (a)
  local t = new()
  for i = 1, #a do t[i] = -a[i] end
  return t
end



mt.__eq = function (a, b)
  for i = 1, min(#a,#b) do
    if  a[i] ~= b[i]  then  return false  end
  end
  return true
end

mt.__lt = function (a, b)
  for i = 1, min(#a,#b) do
    if  a[i] >= b[i]  then  return false  end
  end
  return true
end

mt.__le = function (a, b)
  for i = 1, min(#a,#b) do
    if  a[i] > b[i]  then  return false  end
  end
  return true
end



mt.__tostring = function (a)
  return concat(a, "n")
end

mt.__call = function (a, ...)
  local t = {...}
  if #t > 0 then
    for i = 1, max(#a,#t) do a[i] = t[i] end
  end
  return unpack(a)
end



function main.new(...)
  return setmetatable({...}, mt)
end

function main.clone(a)
  return main.new( unpack(a))
end

function main.module(delta)
  local v = 0
  for i = 1, #delta do v = delta[i] ^ 2 + v end
  v = v ^ 0.5
  return v
end

function main.module1(delta)
  local m = main.module(delta)
  if m == 0 then return delta end
  local k = 1 /m
  return delta * k
end

function main.floor(a)
  local t = new()
  for i = 1, #a do t[i] = floor(a[i]) end
  return t
end

function main.ceil(a)
  local t = new()
  for i = 1, #a do t[i] = ceil( a[i]) end
  return t
end

function main.min(a)
  local v = a[1]
  for i = 2, #a do v = min(v, a[i]) end
  return v
end

function main.max(a)
  local v = a[1]
  for i = 2, #a do v = max(v, a[i]) end
  return v
end

function main.abs(a)
  local t = new()
  for i = 1, #a do t[i] = math.abs(a[i]) end
  return t
end

function main.sum(a)
  local v = 0
  for i = 1, #a do v = v + a[i] end
  return v
end



---@diagnostic disable-next-line: param-type-mismatch
return setmetatable(main, {__call = function (a, ...)
  return main.new(...)
end})
