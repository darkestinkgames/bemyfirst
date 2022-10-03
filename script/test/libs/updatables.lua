local function updateField(self, dt)
  local obj = self.obj[self.field]
  local fn = obj[self.fnkey]
  fn(obj, dt)
end
local function update(self, dt)
  local fn = self.obj[self.fnkey]
  fn(self.obj, dt)
end

local function setField(self, name)
  assert(type(name) == "string")
  self.update = self.updateField
  self.field = name
  return self
end
local function setFnName(self, name)
  assert(type(name) == "string")
  self.fnkey = name
  return self
end

----------------------------------

local updatables = {
  list = {},
}

function updatables:addItem(obj)
  local item = {
    obj         = obj,          -- об’єкт, що треба апдейтити
    field       = '',           -- якщо апдейтити треба не об’єкт, а його поле, яке змінюватися
    fnkey       = "update",     -- якщо `update(dt)` називається інакше

    update      = update,       -- 
    updateField = updateField,  -- 
    setField    = setField,     -- 
    setFnName   = setFnName,    -- 
  }
  self.list[#self.list+1] = item
  return item
end

function updatables:update(dt)
  for index, item in ipairs(self.list) do
    item:update(dt)
  end
end

----------------------------------

return updatables