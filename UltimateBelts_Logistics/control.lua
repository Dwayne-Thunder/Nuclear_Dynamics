-- Belt snapping + loader GUI toggles (split lanes / overfill machines).

local loader_gui = require("scripts.loader-gui")

local function is_ubsa_loader(name)
  return loader_gui.is_ubsa_loader_name(name)
end

local belt_types = {
  "transport-belt",
  "underground-belt",
  "splitter",
  "loader",
  "loader-1x1",
  "linked-belt",
}

local opposite = {
  [defines.direction.north] = defines.direction.south,
  [defines.direction.south] = defines.direction.north,
  [defines.direction.east] = defines.direction.west,
  [defines.direction.west] = defines.direction.east,
}

local function offset(position, direction)
  if direction == defines.direction.north then
    return { x = position.x, y = position.y - 1 }
  elseif direction == defines.direction.south then
    return { x = position.x, y = position.y + 1 }
  elseif direction == defines.direction.east then
    return { x = position.x + 1, y = position.y }
  elseif direction == defines.direction.west then
    return { x = position.x - 1, y = position.y }
  end
  return position
end

local function find_belt(surface, position)
  return surface.find_entities_filtered({ position = position, type = belt_types })[1]
end

local function snap_loader(entity)
  if not entity or not entity.valid then
    return
  end
  local type = entity.type == "entity-ghost" and entity.ghost_type or entity.type
  if type ~= "loader-1x1" then
    return
  end
  local name = entity.type == "entity-ghost" and entity.ghost_name or entity.name
  if not is_ubsa_loader(name) then
    return
  end

  local front_dir = entity.direction
  if entity.loader_type == "input" then
    front_dir = opposite[front_dir]
  end
  local back_dir = opposite[front_dir]

  local front = find_belt(entity.surface, offset(entity.position, front_dir))
  local back = find_belt(entity.surface, offset(entity.position, back_dir))
  local belt = front or back
  if not belt then
    return
  end

  if not front and back then
    entity.direction = opposite[entity.direction]
  end

  if belt.direction == opposite[entity.direction] then
    entity.loader_type = "input"
  else
    entity.loader_type = "output"
  end
end

local function on_built(event)
  local entity = event.entity or event.destination
  if not entity or not entity.valid then
    return
  end

  local type = entity.type == "entity-ghost" and entity.ghost_type or entity.type
  local name = entity.type == "entity-ghost" and entity.ghost_name or entity.name

  if type == "loader-1x1" and is_ubsa_loader(name) then
    snap_loader(entity)
    return
  end

  if entity.type == "transport-belt"
    or entity.type == "underground-belt"
    or entity.type == "splitter"
  then
    local neighbors = entity.surface.find_entities_filtered({
      area = {
        { entity.position.x - 1.5, entity.position.y - 1.5 },
        { entity.position.x + 1.5, entity.position.y + 1.5 },
      },
      type = "loader-1x1",
    })
    for _, loader in pairs(neighbors) do
      local lname = loader.name
      if is_ubsa_loader(lname) then
        snap_loader(loader)
      end
    end
  end
end

script.on_init(function()
  loader_gui.on_init()
end)

script.on_configuration_changed(function()
  loader_gui.on_configuration_changed()
end)

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)
script.on_event(defines.events.script_raised_built, on_built)
script.on_event(defines.events.script_raised_revive, on_built)
script.on_event(defines.events.on_entity_cloned, on_built)
if defines.events.on_space_platform_built_entity then
  script.on_event(defines.events.on_space_platform_built_entity, on_built)
end

for event_id, handler in pairs(loader_gui.events) do
  script.on_event(event_id, handler)
end
