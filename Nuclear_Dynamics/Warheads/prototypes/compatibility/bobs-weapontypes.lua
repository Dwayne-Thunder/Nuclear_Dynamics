-- bobwarfare 2.x (Factorio 2.0) renamed many prototypes with a "bob-" prefix.
local function first_ammo(...)
  for _, name in ipairs({...}) do
    if data.raw.ammo[name] then
      return data.raw.ammo[name]
    end
  end
  return nil
end

local function first_projectile(...)
  for _, name in ipairs({...}) do
    if data.raw.projectile[name] then
      return data.raw.projectile[name]
    end
  end
  return nil
end

local bob_rocket_ammo = first_ammo("bob-rocket", "rocket")
local bob_rocket_proj = first_projectile("bob-rocket", "rocket")
local bob_magazine = first_ammo("bob-bullet-magazine", "bullet-magazine", "piercing-rounds-magazine")
local bob_shotgun_ammo = first_ammo("bob-better-shotgun-shell", "better-shotgun-shell", "piercing-shotgun-shell")
local bob_shotgun_proj = first_projectile("bob-better-shotgun-projectile", "better-shotgun-projectile", "piercing-shotgun-pellet")

local rocket_body = (data.raw.item["bob-rocket-body"] and "bob-rocket-body")
  or (data.raw.item["rocket-body"] and "rocket-body")
  or "rocket"
local shotgun_casing = (data.raw.item["bob-shotgun-shell-casing"] and "bob-shotgun-shell-casing")
  or (data.raw.item["shotgun-shell-casing"] and "shotgun-shell-casing")
  or "piercing-shotgun-shell"
local bullet_casing = (data.raw.item["bob-bullet-casing"] and "bob-bullet-casing")
  or (data.raw.item["bullet-casing"] and "bullet-casing")
local cordite = (data.raw.item["bob-cordite"] and "bob-cordite")
  or (data.raw.item["cordite"] and "cordite")

if bob_rocket_ammo and bob_rocket_proj then
  weaponTypes["small-rocket"].base_item = rocket_body
  weaponTypes["small-rocket"].item = table.deepcopy(bob_rocket_ammo)
  weaponTypes["small-rocket"].projectile = table.deepcopy(bob_rocket_proj)

  weaponTypes["big-rocket"].base_item = rocket_body
  weaponTypes["big-rocket"].item = table.deepcopy(bob_rocket_ammo)
  weaponTypes["big-rocket"].projectile = table.deepcopy(bob_rocket_proj)

  weaponTypes["rocket"].base_item = rocket_body
  weaponTypes["rocket"].item = table.deepcopy(bob_rocket_ammo)
  weaponTypes["rocket"].projectile = table.deepcopy(bob_rocket_proj)
end

if bob_magazine then
  weaponTypes["rounds-magazine"].base_item = "piercing-rounds-magazine"
  weaponTypes["rounds-magazine"].icon = "__bobwarfare__/graphics/icons/bullet-magazine.png"
  if bullet_casing and cordite then
    weaponTypes["rounds-magazine"].extra_ingredients = {
      {type = "item", name = bullet_casing, amount = 5},
      {type = "item", name = cordite, amount = 5}
    }
  end
  weaponTypes["rounds-magazine"].item = table.deepcopy(bob_magazine)
end

if bob_shotgun_ammo and bob_shotgun_proj then
  local shotgun_extra = nil
  if cordite then
    shotgun_extra = {{type = "item", name = cordite, amount = 1}}
  end

  for _, key in ipairs({
    "shotgun-shell",
    "shotgun-shell-slug",
    "shotgun-shell-buckshot",
    "shotgun-shell-birdshot"
  }) do
    if weaponTypes[key] then
      weaponTypes[key].base_item = shotgun_casing
      weaponTypes[key].extra_ingredients = shotgun_extra
      weaponTypes[key].icon = {icon = "__bobwarfare__/graphics/icons/shotgun-shell.png", icon_size = 32}
      weaponTypes[key].projectile = table.deepcopy(bob_shotgun_proj)
    end
  end
  weaponTypes["shotgun-shell"].item = table.deepcopy(bob_shotgun_ammo)
end
