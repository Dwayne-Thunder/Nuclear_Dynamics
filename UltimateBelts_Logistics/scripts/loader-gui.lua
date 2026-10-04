-- Relative GUI toggles for split lanes / overfill machines on ubsa loaders.
-- Swaps between prototype variants (Factorio 2.0 prototype flags are not runtime-writable).

local loader_gui = {}

local GUI_NAME = "ubsa_loader_options"
local SPLIT_CB = "ubsa_cb_split"
local FILL_CB = "ubsa_cb_fill"

local function is_ubsa_loader_name(name)
  return name and string.sub(name, 1, 5) == "ubsa-" and string.find(name, "%-loader", 1, false)
end

local function variant_base(name)
  name = string.gsub(name, "%-fill", "")
  name = string.gsub(name, "%-split", "")
  return name
end

local function flags_from_name(name)
  return {
    split = string.find(name, "%-split", 1, false) ~= nil,
    fill = string.find(name, "%-fill", 1, false) ~= nil,
  }
end

local function variant_name(base, flags)
  return base
    .. (flags.split and "-split" or "")
    .. (flags.fill and "-fill" or "")
end

local function entity_proto_name(entity)
  if entity.name == "entity-ghost" then
    return entity.ghost_name
  end
  return entity.name
end

function loader_gui.swap_variant(old, flags, player_index)
  local proto_name = entity_proto_name(old)
  local base = variant_base(proto_name)
  local new_name = variant_name(base, flags)
  if new_name == proto_name then
    return old
  end
  if not prototypes.entity[new_name] then
    return old
  end

  local player = player_index and game.get_player(player_index) or nil
  local params = {
    name = new_name,
    position = old.position,
    direction = old.direction,
    force = old.force,
    type = old.loader_type,
    quality = old.quality,
    fast_replace = true,
    create_build_effect_smoke = false,
    spill = false,
  }
  if old.name == "entity-ghost" then
    params.name = "entity-ghost"
    params.inner_name = new_name
  end

  local new_entity = old.surface.create_entity(params)
  if not new_entity then
    return old
  end
  if player then
    new_entity.last_user = player
  end
  return new_entity
end

local function destroy_gui(player)
  local gui = player.gui.relative[GUI_NAME]
  if gui and gui.valid then
    gui.destroy()
  end
end

local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then
    return
  end

  local player = game.get_player(event.player_index)
  if not player then
    return
  end

  destroy_gui(player)

  local name = entity_proto_name(entity)
  if not is_ubsa_loader_name(name) then
    return
  end

  local flags = flags_from_name(name)
  local frame = player.gui.relative.add({
    type = "frame",
    name = GUI_NAME,
    direction = "vertical",
    anchor = {
      gui = defines.relative_gui_type.loader_gui,
      position = defines.relative_gui_position.bottom,
    },
  })
  frame.add({
    type = "checkbox",
    name = SPLIT_CB,
    caption = { "ubsa-loader-gui.split-lanes" },
    state = flags.split,
  })
  frame.add({
    type = "checkbox",
    name = FILL_CB,
    caption = { "ubsa-loader-gui.overfill-machines" },
    state = flags.fill,
  })

  storage.players = storage.players or {}
  storage.players[player.index] = storage.players[player.index] or {}
  storage.players[player.index].open_loader = entity
end

local function on_gui_closed(event)
  local player = game.get_player(event.player_index)
  if not player then
    return
  end
  destroy_gui(player)
  if storage.players and storage.players[player.index] then
    storage.players[player.index].open_loader = nil
  end
end

local function on_checkbox_changed(event)
  local element = event.element
  if not element or not element.valid then
    return
  end
  if element.name ~= SPLIT_CB and element.name ~= FILL_CB then
    return
  end

  local player = game.get_player(event.player_index)
  if not player then
    return
  end

  local pd = storage.players and storage.players[player.index]
  local entity = pd and pd.open_loader
  if not entity or not entity.valid then
    return
  end

  local name = entity_proto_name(entity)
  local flags = flags_from_name(name)
  if element.name == SPLIT_CB then
    flags.split = element.state
  else
    flags.fill = element.state
  end

  local new_entity = loader_gui.swap_variant(entity, flags, event.player_index)
  if pd then
    pd.open_loader = new_entity
  end
  if new_entity and new_entity.valid then
    player.opened = new_entity
  end
end

local function on_settings_pasted(event)
  local dest = event.destination
  local source = event.source
  if not dest or not dest.valid or not source or not source.valid then
    return
  end
  local dest_name = entity_proto_name(dest)
  local src_name = entity_proto_name(source)
  if not is_ubsa_loader_name(dest_name) or not is_ubsa_loader_name(src_name) then
    return
  end
  local src_flags = flags_from_name(src_name)
  local dst_flags = flags_from_name(dest_name)
  if src_flags.split ~= dst_flags.split or src_flags.fill ~= dst_flags.fill then
    loader_gui.swap_variant(dest, src_flags)
  end
end

loader_gui.on_init = function()
  storage.players = storage.players or {}
end

loader_gui.on_configuration_changed = function()
  storage.players = storage.players or {}
end

loader_gui.events = {
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_gui_closed] = on_gui_closed,
  [defines.events.on_gui_checked_state_changed] = on_checkbox_changed,
  [defines.events.on_pre_entity_settings_pasted] = on_settings_pasted,
}

loader_gui.is_ubsa_loader_name = is_ubsa_loader_name
loader_gui.variant_base = variant_base

return loader_gui
