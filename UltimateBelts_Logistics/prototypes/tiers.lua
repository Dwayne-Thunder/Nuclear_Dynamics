-- Tier templates for Ultimate Belts Space Age and/or Double Speed Belts.
-- Entity names use ubsa-* / ubsa-dsb-* prefixes to avoid Load-Furn / Deadlock clashes.
-- Inserter speed_factor is recomputed in data-final-fixes from live belt.speed.

local M = {}

-- items/s = belt.speed * 480; bulk-inserter baseline ≈ turbo 60/s
M.REFERENCE_IPS = 60
M.BULK_EXTENSION = 0.14
M.BULK_ROTATION = 0.04

M.ubsa_tiers = {
  {
    key = "ultra-fast",
    belt = "ultra-fast-belt",
    underground = "ultra-fast-underground-belt",
    technology = "ultra-fast-logistics",
    order = "d[ubsa-loader]-a[ultra-fast]",
    inserter_order = "z[ubsa-inserter]-a[ultra-fast]",
    tint = { r = 0 / 255, g = 211 / 255, b = 37 / 255, a = 1 },
    stack_size_bonus = 1,
    loader_ingredients = {
      { type = "item", name = "ultra-fast-belt", amount = 5 },
      { type = "item", name = "bulk-inserter", amount = 2 },
      { type = "item", name = "iron-gear-wheel", amount = 10 },
      { type = "item", name = "advanced-circuit", amount = 5 },
    },
    inserter_ingredients = {
      { type = "item", name = "bulk-inserter", amount = 2 },
      { type = "item", name = "ultra-fast-belt", amount = 4 },
      { type = "item", name = "iron-gear-wheel", amount = 10 },
      { type = "item", name = "advanced-circuit", amount = 5 },
    },
  },
  {
    key = "extreme-fast",
    belt = "extreme-fast-belt",
    underground = "extreme-fast-underground-belt",
    technology = "extreme-fast-logistics",
    order = "d[ubsa-loader]-b[extreme-fast]",
    inserter_order = "z[ubsa-inserter]-b[extreme-fast]",
    tint = { r = 245 / 255, g = 17 / 255, b = 24 / 255, a = 1 },
    stack_size_bonus = 2,
    loader_ingredients = {
      { type = "item", name = "ubsa-ultra-fast-loader", amount = 1 },
      { type = "item", name = "extreme-fast-belt", amount = 5 },
      { type = "item", name = "iron-gear-wheel", amount = 10 },
      { type = "item", name = "advanced-circuit", amount = 10 },
    },
    inserter_ingredients = {
      { type = "item", name = "ubsa-ultra-fast-inserter", amount = 1 },
      { type = "item", name = "extreme-fast-belt", amount = 4 },
      { type = "item", name = "iron-gear-wheel", amount = 10 },
      { type = "item", name = "advanced-circuit", amount = 10 },
    },
  },
  {
    key = "ultra-express",
    belt = "ultra-express-belt",
    underground = "ultra-express-underground-belt",
    technology = "ultra-express-logistics",
    order = "d[ubsa-loader]-c[ultra-express]",
    inserter_order = "z[ubsa-inserter]-c[ultra-express]",
    tint = { r = 86 / 255, g = 0 / 255, b = 204 / 255, a = 1 },
    stack_size_bonus = 2,
    loader_ingredients = {
      { type = "item", name = "ubsa-extreme-fast-loader", amount = 1 },
      { type = "item", name = "ultra-express-belt", amount = 5 },
      { type = "item", name = "processing-unit", amount = 5 },
      { type = "item", name = "speed-module", amount = 1 },
    },
    inserter_ingredients = {
      { type = "item", name = "ubsa-extreme-fast-inserter", amount = 1 },
      { type = "item", name = "ultra-express-belt", amount = 4 },
      { type = "item", name = "processing-unit", amount = 5 },
      { type = "item", name = "speed-module", amount = 1 },
    },
  },
  {
    key = "extreme-express",
    belt = "extreme-express-belt",
    underground = "extreme-express-underground-belt",
    technology = "extreme-express-logistics",
    order = "d[ubsa-loader]-d[extreme-express]",
    inserter_order = "z[ubsa-inserter]-d[extreme-express]",
    tint = { r = 0 / 255, g = 0 / 255, b = 204 / 255, a = 1 },
    stack_size_bonus = 3,
    loader_ingredients = {
      { type = "item", name = "ubsa-ultra-express-loader", amount = 1 },
      { type = "item", name = "extreme-express-belt", amount = 5 },
      { type = "item", name = "processing-unit", amount = 10 },
      { type = "item", name = "speed-module-2", amount = 1 },
    },
    inserter_ingredients = {
      { type = "item", name = "ubsa-ultra-express-inserter", amount = 1 },
      { type = "item", name = "extreme-express-belt", amount = 4 },
      { type = "item", name = "processing-unit", amount = 10 },
      { type = "item", name = "speed-module-2", amount = 1 },
    },
  },
  {
    key = "ultimate",
    belt = "ultimate-belt",
    underground = "original-ultimate-underground-belt",
    technology = "ultimate-logistics",
    order = "d[ubsa-loader]-e[ultimate]",
    inserter_order = "z[ubsa-inserter]-e[ultimate]",
    tint = { r = 0 / 255, g = 230 / 255, b = 204 / 255, a = 1 },
    stack_size_bonus = 4,
    loader_ingredients = {
      { type = "item", name = "ubsa-extreme-express-loader", amount = 1 },
      { type = "item", name = "ultimate-belt", amount = 5 },
      { type = "item", name = "processing-unit", amount = 10 },
      { type = "item", name = "speed-module-3", amount = 1 },
    },
    inserter_ingredients = {
      { type = "item", name = "ubsa-extreme-express-inserter", amount = 1 },
      { type = "item", name = "ultimate-belt", amount = 4 },
      { type = "item", name = "processing-unit", amount = 10 },
      { type = "item", name = "speed-module-3", amount = 1 },
    },
  },
}

-- Vanilla / Space Age loaders only when Double Speed Belts is enabled.
-- Inserters start at UBSA ultra-fast; no DSB yellow→turbo inserters.
M.dsb_tiers = {
  {
    key = "transport",
    belt = "transport-belt",
    underground = "underground-belt",
    technology = "logistics",
    order = "d[ubsa-dsb-loader]-a[transport]",
    tint = { r = 234 / 255, g = 206 / 255, b = 0 / 255, a = 1 },
    make_inserter = false,
    loader_ingredients = {
      { type = "item", name = "transport-belt", amount = 5 },
      { type = "item", name = "inserter", amount = 5 },
      { type = "item", name = "electronic-circuit", amount = 5 },
      { type = "item", name = "iron-gear-wheel", amount = 5 },
    },
  },
  {
    key = "fast",
    belt = "fast-transport-belt",
    underground = "fast-underground-belt",
    technology = "logistics-2",
    order = "d[ubsa-dsb-loader]-b[fast]",
    tint = { r = 215 / 255, g = 40 / 255, b = 40 / 255, a = 1 },
    make_inserter = false,
    loader_ingredients = {
      { type = "item", name = "ubsa-dsb-transport-loader", amount = 1 },
      { type = "item", name = "fast-transport-belt", amount = 5 },
    },
  },
  {
    key = "express",
    belt = "express-transport-belt",
    underground = "express-underground-belt",
    technology = "logistics-3",
    order = "d[ubsa-dsb-loader]-c[express]",
    tint = { r = 40 / 255, g = 120 / 255, b = 220 / 255, a = 1 },
    make_inserter = false,
    loader_ingredients = {
      { type = "item", name = "ubsa-dsb-fast-loader", amount = 1 },
      { type = "item", name = "express-transport-belt", amount = 5 },
      { type = "item", name = "bulk-inserter", amount = 2 },
    },
  },
  {
    key = "turbo",
    belt = "turbo-transport-belt",
    underground = "turbo-underground-belt",
    technology = "turbo-transport-belt",
    order = "d[ubsa-dsb-loader]-d[turbo]",
    tint = { r = 40 / 255, g = 180 / 255, b = 70 / 255, a = 1 },
    make_inserter = false,
    loader_ingredients = {
      { type = "item", name = "ubsa-dsb-express-loader", amount = 1 },
      { type = "item", name = "turbo-transport-belt", amount = 5 },
      { type = "item", name = "bulk-inserter", amount = 2 },
    },
  },
}

local function finalize_group(templates, name_prefix)
  local tiers = {}
  for _, template in ipairs(templates) do
    if data.raw["transport-belt"][template.belt] then
      local tier = {}
      for k, v in pairs(template) do
        tier[k] = v
      end
      tier.loader_name = name_prefix .. tier.key .. "-loader"
      if tier.make_inserter ~= false then
        tier.make_inserter = true
        tier.inserter_name = name_prefix .. tier.key .. "-inserter"
      else
        tier.inserter_name = nil
      end
      tiers[#tiers + 1] = tier
    end
  end
  for i, tier in ipairs(tiers) do
    if i < #tiers then
      tier.next_loader = tiers[i + 1].loader_name
      if tier.make_inserter and tiers[i + 1].make_inserter then
        tier.next_inserter = tiers[i + 1].inserter_name
      end
    end
  end
  return tiers
end

function M.get_active_tiers()
  local active = {}

  if mods["UltimateBeltsSpaceAge"] then
    for _, tier in ipairs(finalize_group(M.ubsa_tiers, "ubsa-")) do
      active[#active + 1] = tier
    end
  end

  if mods["DoubleSpeedBelts"] then
    for _, tier in ipairs(finalize_group(M.dsb_tiers, "ubsa-dsb-")) do
      active[#active + 1] = tier
    end
  end

  if #active == 0 then
    error(
      "UltimateBelts_Logistics requires Ultimate Belts Space Age and/or Double Speed Belts. "
        .. "Enable at least one of: UltimateBeltsSpaceAge, DoubleSpeedBelts."
    )
  end

  return active
end

function M.clamp_uint8(n)
  n = math.floor((n or 0) + 0.5)
  if n < 0 then
    return 0
  end
  if n > 255 then
    return 255
  end
  return n
end

function M.speed_factor_for_belt(belt)
  if not belt or not belt.speed then
    return 1
  end
  local ips = belt.speed * 480
  return math.max(ips / M.REFERENCE_IPS, 1)
end

-- Throughput comes from rotation/extension speed. Keep stack bonus modest (uint8).
-- Extra steps scale with log2(factor), not linearly with DSB-boosted speeds.
function M.stack_bonus_for_factor(factor, base_bonus)
  base_bonus = base_bonus or 0
  local extra = 0
  if factor and factor > 1 then
    extra = math.floor(math.log(factor) / math.log(2) + 0.5)
    if extra < 0 then
      extra = 0
    end
    if extra > 8 then
      extra = 8
    end
  end
  return M.clamp_uint8(base_bonus + extra)
end

return M
