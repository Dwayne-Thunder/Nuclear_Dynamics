local tiers_mod = require("prototypes.tiers")
local graphics = require("prototypes.graphics")
local loader_variants = require("prototypes.loader-variants")

local generate = {}

local function tinted_inserter_icons(tint)
  return {
    {
      icon = "__base__/graphics/icons/bulk-inserter.png",
      icon_size = 64,
      icon_mipmaps = 4,
    },
    {
      icon = "__base__/graphics/icons/bulk-inserter.png",
      icon_size = 64,
      icon_mipmaps = 4,
      tint = { r = tint.r, g = tint.g, b = tint.b, a = 0.45 },
    },
  }
end

-- items/s = belt.speed * 480 (both lanes). Parameterized so DSB resync updates the tooltip.
local function inserter_belt_description(belt)
  local ips = math.floor((belt.speed or 0) * 480 + 0.5)
  local belt_name = belt.localised_name or { "entity-name." .. belt.name }
  return {
    "",
    { "ubsa-inserter-description.max-belt-speed", tostring(ips) },
    "\n",
    { "ubsa-inserter-description.paired-belt", belt_name },
  }
end

local function apply_inserter_description(tier, belt)
  local desc = inserter_belt_description(belt)
  local inserter = data.raw.inserter[tier.inserter_name]
  local item = data.raw.item[tier.inserter_name]
  if inserter then
    inserter.localised_description = desc
  end
  if item then
    item.localised_description = desc
  end
end

-- Shared tooltip for all ubsa loaders (item, entity, -split/-fill variants).
-- Feature lines reuse GUI locale keys so wording matches the checkboxes exactly.
local function loader_gui_description(belt)
  local belt_name = belt.localised_name or { "entity-name." .. belt.name }
  return {
    "",
    { "ubsa-loader-description.summary", belt_name },
    "\n",
    { "ubsa-loader-gui.split-lanes" },
    "\n",
    { "ubsa-loader-gui.overfill-machines" },
  }
end

local function apply_loader_description(loader_name, desc)
  local item = data.raw.item[loader_name]
  if item then
    item.localised_description = desc
  end
  for _, suffix in ipairs({ "", "-split", "-fill", "-split-fill" }) do
    local loader = data.raw["loader-1x1"][loader_name .. suffix]
    if loader then
      loader.localised_description = desc
    end
  end
end

local function make_loader(tier)
  local belt = data.raw["transport-belt"][tier.belt]
  if not belt then
    return
  end

  local ug = data.raw["underground-belt"][tier.underground]
  local belt_animation_set = (ug and ug.belt_animation_set) or belt.belt_animation_set
  local desc = loader_gui_description(belt)

  data:extend({
    {
      type = "item",
      name = tier.loader_name,
      localised_name = { "item-name." .. tier.loader_name },
      localised_description = desc,
      icons = graphics.loader_icons(tier.tint),
      subgroup = "belt",
      order = tier.order,
      place_result = tier.loader_name,
      stack_size = 50,
    },
    {
      type = "recipe",
      name = tier.loader_name,
      localised_name = { "recipe-name." .. tier.loader_name },
      enabled = false,
      energy_required = 2,
      ingredients = tier.loader_ingredients,
      results = { { type = "item", name = tier.loader_name, amount = 1 } },
    },
    {
      type = "loader-1x1",
      name = tier.loader_name,
      localised_name = { "entity-name." .. tier.loader_name },
      localised_description = desc,
      icons = graphics.loader_icons(tier.tint),
      flags = { "placeable-neutral", "player-creation" },
      minable = { mining_time = 0.1, result = tier.loader_name },
      max_health = belt.max_health or 300,
      corpse = "small-remnants",
      dying_explosion = "underground-belt-explosion",
      resistances = belt.resistances or { { type = "fire", percent = 60 } },
      collision_box = { { -0.4, -0.45 }, { 0.4, 0.45 } },
      selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
      animation_speed_coefficient = 32,
      belt_animation_set = belt_animation_set,
      container_distance = 1,
      belt_length = 0.5,
      filter_count = 5,
      per_lane_filters = false,
      respect_insert_limits = true,
      structure_render_layer = "object",
      structure = graphics.loader_structure(tier.tint),
      speed = belt.speed,
      fast_replaceable_group = "ubsa-loader",
      next_upgrade = tier.next_loader,
      open_sound = { filename = "__base__/sound/open-close/inserter-open.ogg" },
      close_sound = { filename = "__base__/sound/open-close/inserter-close.ogg" },
      circuit_wire_max_distance = transport_belt_circuit_wire_max_distance,
      max_belt_stack_size = feature_flags.space_travel and 4 or 1, -- uint8
      adjustable_belt_stack_size = feature_flags.space_travel and true or nil,
    },
  })
end

local function make_inserter(tier)
  local belt = data.raw["transport-belt"][tier.belt]
  local base = table.deepcopy(data.raw.inserter["bulk-inserter"])
  if not base or not belt then
    return
  end

  local factor = tiers_mod.speed_factor_for_belt(belt)
  local name = tier.inserter_name

  base.name = name
  base.localised_name = { "entity-name." .. name }
  base.minable = { mining_time = 0.1, result = name }
  base.icons = tinted_inserter_icons(tier.tint)
  base.icon = nil
  base.fast_replaceable_group = "ubsa-inserter"
  base.next_upgrade = tier.next_inserter
  base.extension_speed = tiers_mod.BULK_EXTENSION * factor
  base.rotation_speed = tiers_mod.BULK_ROTATION * factor
  -- Do not inherit bulk-inserter stack_size_bonus; set a modest clamped value.
  base.stack_size_bonus = tiers_mod.stack_bonus_for_factor(factor, tier.stack_size_bonus)
  -- Cap health growth so extreme DSB factors do not produce absurd values.
  base.max_health = (base.max_health or 160) + math.min(math.floor(40 * factor), 2000)
  base.energy_per_movement = "10kJ"
  base.energy_per_rotation = "10kJ"
  if base.energy_source and base.energy_source.drain then
    base.energy_source.drain = "1kW"
  end
  if feature_flags.space_travel then
    base.max_belt_stack_size = math.min(math.max(base.max_belt_stack_size or 1, 4), 255)
  end
  if base.platform_picture and base.platform_picture.sheet then
    base.platform_picture.sheet.tint = tier.tint
  end

  local desc = inserter_belt_description(belt)
  base.localised_description = desc

  data:extend({
    {
      type = "item",
      name = name,
      localised_name = { "item-name." .. name },
      localised_description = desc,
      icons = tinted_inserter_icons(tier.tint),
      subgroup = "inserter",
      order = tier.inserter_order,
      place_result = name,
      stack_size = 50,
    },
    {
      type = "recipe",
      name = name,
      localised_name = { "recipe-name." .. name },
      enabled = false,
      energy_required = 2,
      ingredients = tier.inserter_ingredients,
      results = { { type = "item", name = name, amount = 1 } },
    },
    base,
  })
end

function generate.create_all()
  local tiers = tiers_mod.get_active_tiers()
  for _, tier in ipairs(tiers) do
    make_loader(tier)
    -- Inserters only from UBSA ultra-fast and above (no DSB yellow→turbo inserters).
    if tier.make_inserter then
      make_inserter(tier)
    end
  end
  loader_variants.create_all(tiers)
  return tiers
end

function generate.sync_speeds()
  local tiers = tiers_mod.get_active_tiers()
  for _, tier in ipairs(tiers) do
    local belt = data.raw["transport-belt"][tier.belt]
    local loader = data.raw["loader-1x1"][tier.loader_name]
    local inserter = data.raw.inserter[tier.inserter_name]
    if not belt then
      goto continue
    end

    if loader then
      loader.speed = belt.speed
      local ug = data.raw["underground-belt"][tier.underground]
      if ug and ug.belt_animation_set then
        loader.belt_animation_set = ug.belt_animation_set
      else
        loader.belt_animation_set = belt.belt_animation_set
      end
      if belt.speed >= 0.5 then
        loader.animation_speed_coefficient = 0
      end
      apply_loader_description(tier.loader_name, loader_gui_description(belt))
    end

    if tier.make_inserter and inserter then
      local factor = tiers_mod.speed_factor_for_belt(belt)
      inserter.extension_speed = tiers_mod.BULK_EXTENSION * factor
      inserter.rotation_speed = tiers_mod.BULK_ROTATION * factor
      inserter.stack_size_bonus = tiers_mod.stack_bonus_for_factor(factor, tier.stack_size_bonus)
      if feature_flags.space_travel and inserter.max_belt_stack_size then
        inserter.max_belt_stack_size = math.min(math.max(inserter.max_belt_stack_size, 1), 255)
      end
      apply_inserter_description(tier, belt)
    end

    ::continue::
  end
  loader_variants.sync_variant_speeds(tiers)
end

function generate.add_tech_unlocks()
  local function add_unlock(tech_name, recipe_name)
    local tech = data.raw.technology[tech_name]
    if not tech then
      return
    end
    tech.effects = tech.effects or {}
    for _, effect in pairs(tech.effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
        return
      end
    end
    table.insert(tech.effects, { type = "unlock-recipe", recipe = recipe_name })
  end

  for _, tier in ipairs(tiers_mod.get_active_tiers()) do
    local tech_name = tier.technology
    if not data.raw.technology[tech_name] then
      -- Space Age turbo tech name differs in some packs; fall back sensibly.
      if tier.belt == "turbo-transport-belt" and data.raw.technology["logistics-3"] then
        tech_name = "logistics-3"
      end
    end
    add_unlock(tech_name, tier.loader_name)
    if tier.make_inserter and tier.inserter_name then
      add_unlock(tech_name, tier.inserter_name)
    end
  end
end

return generate
