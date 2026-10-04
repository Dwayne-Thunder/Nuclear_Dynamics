local tiers = require("prototypes.tiers")

local function tinted_icons(base_icon, tint, icon_a)
  return {
    {
      icon = base_icon,
      icon_size = 64,
    },
    {
      icon = base_icon,
      icon_size = 64,
      tint = { r = tint.r, g = tint.g, b = tint.b, a = icon_a or 0.55 },
    },
  }
end

local function tinted_tech_icons(base_icon, tint, icon_a)
  return {
    {
      icon = base_icon,
      icon_size = 256,
    },
    {
      icon = base_icon,
      icon_size = 256,
      tint = { r = tint.r, g = tint.g, b = tint.b, a = icon_a or 0.55 },
    },
  }
end

-- Tint drawable layers; skip shadows / lights so they stay readable.
local function apply_tint(obj, tint)
  if type(obj) ~= "table" then
    return
  end
  if obj.filename and not obj.draw_as_shadow and not obj.draw_as_light and not obj.draw_as_glow then
    obj.tint = { r = tint.r, g = tint.g, b = tint.b, a = tint.a or 1 }
  end
  for k, v in pairs(obj) do
    if type(v) == "table" and k ~= "tint" then
      apply_tint(v, tint)
    end
  end
end

local function format_mj(megajoules)
  local s = string.format("%.3f", megajoules)
  s = s:gsub("0+$", ""):gsub("%.$", "")
  return s .. "MJ"
end

local function make_roboport(def, tint, charging_offsets, next_upgrade)
  local base = table.deepcopy(data.raw.roboport.roboport)
  base.name = def.name
  base.minable = { mining_time = 0.1, result = def.name }
  base.max_health = def.max_health
  base.robot_slots_count = def.robot_slots_count
  base.material_slots_count = def.material_slots_count
  base.logistics_radius = def.logistics_radius
  base.construction_radius = def.construction_radius
  base.charging_energy = def.charging_energy
  base.energy_usage = def.energy_usage
  base.recharge_minimum = def.recharge_minimum
  base.energy_source = table.deepcopy(def.energy_source)
  base.charging_offsets = table.deepcopy(charging_offsets)
  base.next_upgrade = next_upgrade
  base.fast_replaceable_group = "roboport"
  base.icons = tinted_icons("__base__/graphics/icons/roboport.png", tint)
  base.icon = nil

  apply_tint(base.base, tint)
  apply_tint(base.base_patch, tint)
  apply_tint(base.base_animation, tint)

  data:extend({
    base,
    {
      type = "item",
      name = def.name,
      icons = tinted_icons("__base__/graphics/icons/roboport.png", tint),
      subgroup = "logistic-network",
      order = def.order,
      inventory_move_sound = data.raw.item.roboport.inventory_move_sound,
      pick_sound = data.raw.item.roboport.pick_sound,
      drop_sound = data.raw.item.roboport.drop_sound,
      place_result = def.name,
      stack_size = 10,
      weight = data.raw.item.roboport.weight,
    },
    {
      type = "recipe",
      name = def.name,
      enabled = false,
      energy_required = def.energy_required,
      ingredients = table.deepcopy(def.ingredients),
      results = { { type = "item", name = def.name, amount = 1 } },
    },
    {
      type = "technology",
      name = def.tech.name,
      icons = tinted_tech_icons("__base__/graphics/technology/logistic-system.png", tint),
      effects = {
        { type = "unlock-recipe", recipe = def.name },
      },
      prerequisites = table.deepcopy(def.tech.prerequisites),
      unit = {
        count = def.tech.count,
        ingredients = table.deepcopy(def.tech.ingredients),
        time = def.tech.time,
      },
      order = "c-k-d-hl-" .. def.tier,
    },
  })
end

local function make_robot(kind, def, tint)
  local vanilla = data.raw[kind][kind]
  local name = "hl-" .. kind .. "-" .. def.tier
  local ingredients = (kind == "logistic-robot") and def.ingredients_logistic or def.ingredients_construction
  local icon_path = "__base__/graphics/icons/" .. kind .. ".png"
  local energy_num = tonumber((vanilla.max_energy:gsub("MJ", "")))
  local new_energy = format_mj(energy_num * def.energy_mult)

  local entity = table.deepcopy(vanilla)
  entity.name = name
  entity.minable = { mining_time = 0.1, result = name }
  entity.max_payload_size = def.max_payload_size
  entity.speed = vanilla.speed * def.speed_mult
  entity.max_energy = new_energy
  entity.energy_per_move = def.energy_per_move
  entity.icons = tinted_icons(icon_path, tint)
  entity.icon = nil
  entity.factoriopedia_simulation = nil
  -- Required for next_upgrade: all tiers must share the same group as vanilla
  entity.fast_replaceable_group = kind
  -- Keep collision/selection identical to vanilla for upgrade planner validity
  entity.collision_box = table.deepcopy(vanilla.collision_box)
  entity.selection_box = table.deepcopy(vanilla.selection_box)

  apply_tint(entity.idle, tint)
  apply_tint(entity.idle_with_cargo, tint)
  apply_tint(entity.in_motion, tint)
  apply_tint(entity.in_motion_with_cargo, tint)
  if entity.working then
    apply_tint(entity.working, tint)
  end

  local order_prefix = (kind == "logistic-robot") and "a[robot]-a[logistic-robot]-" or "a[robot]-b[construction-robot]-"
  local item_vanilla = data.raw.item[kind]

  data:extend({
    entity,
    {
      type = "item",
      name = name,
      icons = tinted_icons(icon_path, tint),
      subgroup = "logistic-network",
      order = order_prefix .. def.order_suffix .. "[hl]",
      inventory_move_sound = item_vanilla.inventory_move_sound,
      pick_sound = item_vanilla.pick_sound,
      drop_sound = item_vanilla.drop_sound,
      place_result = name,
      stack_size = 50,
      weight = item_vanilla.weight,
    },
    {
      type = "recipe",
      name = name,
      enabled = false,
      energy_required = def.energy_required,
      ingredients = table.deepcopy(ingredients),
      results = { { type = "item", name = name, amount = 1 } },
    },
  })

  return name
end

local function make_robot_tech(def, tint, recipe_names)
  data:extend({
    {
      type = "technology",
      name = def.tech.name,
      icons = tinted_tech_icons("__base__/graphics/technology/logistic-robotics.png", tint),
      effects = {
        { type = "unlock-recipe", recipe = recipe_names[1] },
        { type = "unlock-recipe", recipe = recipe_names[2] },
      },
      prerequisites = table.deepcopy(def.tech.prerequisites),
      unit = {
        count = def.tech.count,
        ingredients = table.deepcopy(def.tech.ingredients),
        time = def.tech.time,
      },
      order = "c-k-e-hl-" .. def.tier,
    },
  })
end

-- Roboports
for i, def in ipairs(tiers.roboports) do
  local next_name = tiers.roboports[i + 1] and tiers.roboports[i + 1].name or nil
  make_roboport(def, tiers.tints[i], tiers.charging_offsets[i], next_name)
end

if data.raw.roboport.roboport then
  data.raw.roboport.roboport.next_upgrade = "hl-roboport-1"
  data.raw.roboport.roboport.fast_replaceable_group = data.raw.roboport.roboport.fast_replaceable_group or "roboport"
end

-- Robots + techs (both types unlocked per tier)
for i, def in ipairs(tiers.robots) do
  local tint = tiers.tints[i]
  local log_name = make_robot("logistic-robot", def, tint)
  local con_name = make_robot("construction-robot", def, tint)
  make_robot_tech(def, tint, { log_name, con_name })
end

-- Robot upgrade planner chain (same fast_replaceable_group on every step)
local function wire_robot_upgrades(kind)
  local names = { kind }
  for t = 1, 3 do
    names[#names + 1] = "hl-" .. kind .. "-" .. t
  end
  for i, name in ipairs(names) do
    local ent = data.raw[kind][name]
    if ent then
      ent.fast_replaceable_group = kind
      if i < #names then
        ent.next_upgrade = names[i + 1]
      else
        ent.next_upgrade = nil
      end
    end
  end
end

wire_robot_upgrades("logistic-robot")
wire_robot_upgrades("construction-robot")
