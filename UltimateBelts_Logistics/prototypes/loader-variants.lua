-- Create -split / -fill entity variants for each base ubsa loader.
-- Behavior matches loaders-modernized (prototype flags cannot be changed at runtime).

local SPLIT_SUFFIX = "-split"
local FILL_SUFFIX = "-fill"

local SPLIT_ICON = "__UltimateBelts_Logistics__/graphics/icon/split-lane-out.png"
local FILL_ICON = "__UltimateBelts_Logistics__/graphics/icon/fill.png"

local function append_icon(icons, path, shift)
  icons[#icons + 1] = {
    icon = path,
    icon_size = 64,
    scale = 0.16,
    shift = shift,
  }
end

local function make_variant(base, flags)
  local variant = table.deepcopy(base)
  local suffix = (flags.split and SPLIT_SUFFIX or "") .. (flags.fill and FILL_SUFFIX or "")
  if suffix == "" then
    return nil
  end

  variant.name = base.name .. suffix
  variant.localised_name = base.localised_name
  variant.factoriopedia_alternative = base.name
  variant.deconstruction_alternative = base.name
  variant.placeable_by = { item = base.name, count = 1 }
  variant.minable = { mining_time = 0.1, result = base.name }
  if base.next_upgrade then
    variant.next_upgrade = base.next_upgrade .. suffix
  end

  variant.icons = table.deepcopy(base.icons) or {}
  if flags.split then
    variant.filter_count = 2
    variant.per_lane_filters = true
    append_icon(variant.icons, SPLIT_ICON, { -11, 9 })
  end
  if flags.fill then
    variant.respect_insert_limits = false
    append_icon(variant.icons, FILL_ICON, { 11, 9 })
  end

  return variant
end

local function create_variants_for_loader(base_name)
  local base = data.raw["loader-1x1"][base_name]
  if not base then
    return
  end

  -- Default: respect machine insert limits (overfill off).
  if base.respect_insert_limits == nil then
    base.respect_insert_limits = true
  end
  base.per_lane_filters = false

  local variants = {
    make_variant(base, { split = true, fill = false }),
    make_variant(base, { split = false, fill = true }),
    make_variant(base, { split = true, fill = true }),
  }
  data:extend(variants)
end

local M = {}

function M.create_all(tiers)
  for _, tier in ipairs(tiers) do
    create_variants_for_loader(tier.loader_name)
  end
end

function M.sync_variant_speeds(tiers)
  for _, tier in ipairs(tiers) do
    local base = data.raw["loader-1x1"][tier.loader_name]
    if not base then
      goto continue
    end
    local belt = data.raw["transport-belt"][tier.belt]
    if belt then
      base.speed = belt.speed
      if belt.speed >= 0.5 then
        base.animation_speed_coefficient = 0
      end
    end
    for _, suffix in ipairs({ SPLIT_SUFFIX, FILL_SUFFIX, SPLIT_SUFFIX .. FILL_SUFFIX }) do
      local variant = data.raw["loader-1x1"][tier.loader_name .. suffix]
      if variant then
        variant.speed = base.speed
        variant.belt_animation_set = base.belt_animation_set
        variant.animation_speed_coefficient = base.animation_speed_coefficient
      end
    end
    ::continue::
  end
end

M.SPLIT_SUFFIX = SPLIT_SUFFIX
M.FILL_SUFFIX = FILL_SUFFIX

return M
