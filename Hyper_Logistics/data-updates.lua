-- Soft Space Age compatibility: copy heating / surface rules from vanilla roboport
-- once SA (or other mods) have finished adjusting the base prototype.
local function sync_roboport_sa_fields(name)
  local src = data.raw.roboport and data.raw.roboport.roboport
  local dst = data.raw.roboport and data.raw.roboport[name]
  if not src or not dst then
    return
  end
  if src.heating_energy then
    dst.heating_energy = src.heating_energy
  end
  if src.surface_conditions then
    dst.surface_conditions = table.deepcopy(src.surface_conditions)
  end
  if src.frozen_patch then
    dst.frozen_patch = table.deepcopy(src.frozen_patch)
  end
end

for i = 1, 3 do
  sync_roboport_sa_fields("hl-roboport-" .. i)
end

-- If Space Age materials exist, enrich the top-tier recipes slightly.
if data.raw.item["superconductor"] and data.raw.recipe["hl-roboport-3"] then
  local recipe = data.raw.recipe["hl-roboport-3"]
  recipe.ingredients = {
    { type = "item", name = "hl-roboport-2", amount = 1 },
    { type = "item", name = "processing-unit", amount = 60 },
    { type = "item", name = "low-density-structure", amount = 40 },
    { type = "item", name = "superconductor", amount = 20 },
  }
end

if data.raw.item["superconductor"] and data.raw.recipe["hl-logistic-robot-3"] then
  local function bump_robot(name)
    local recipe = data.raw.recipe[name]
    if not recipe then
      return
    end
    local ingredients = table.deepcopy(recipe.ingredients)
    table.insert(ingredients, { type = "item", name = "superconductor", amount = 2 })
    recipe.ingredients = ingredients
  end
  bump_robot("hl-logistic-robot-3")
  bump_robot("hl-construction-robot-3")
end
