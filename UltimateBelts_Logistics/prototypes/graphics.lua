-- Tintable loader graphics adapted from loaders-modernized (MIT, kryojenik).
-- Sprites are vendored under graphics/ with attribution in LICENSE / README.

local graphics = {}

local PREFIX = "__UltimateBelts_Logistics__/graphics/"

local function icon_layers(tint)
  return {
    { icon = PREFIX .. "item/mdrn-loader-icon-base.png", icon_size = 64 },
    { icon = PREFIX .. "item/mdrn-loader-icon-mask.png", icon_size = 64, tint = tint },
  }
end

function graphics.loader_icons(tint)
  return icon_layers(tint)
end

function graphics.tech_icons(tint)
  return {
    { icon = PREFIX .. "technology/mdrn-loader-technology-base.png", icon_size = 128 },
    { icon = PREFIX .. "technology/mdrn-loader-technology-mask.png", icon_size = 128, tint = tint },
  }
end

local function structure_sheets(tint, y_offset)
  local base = {
    filename = PREFIX .. "entity/mdrn-loader-structure-base.png",
    priority = "extra-high",
    width = 192,
    height = 192,
    scale = 0.5,
  }
  local mask = {
    filename = PREFIX .. "entity/mdrn-loader-structure-mask.png",
    priority = "extra-high",
    width = 192,
    height = 192,
    scale = 0.5,
    tint = tint,
  }
  local shadow = {
    filename = PREFIX .. "entity/mdrn-loader-structure-shadow.png",
    draw_as_shadow = true,
    priority = "extra-high",
    width = 192,
    height = 192,
    scale = 0.5,
  }
  if y_offset > 0 then
    base.y = y_offset
    mask.y = y_offset
    shadow.y = y_offset
  end
  return { base, mask, shadow }
end

function graphics.loader_structure(tint)
  return {
    direction_in = { sheets = structure_sheets(tint, 0) },
    direction_out = { sheets = structure_sheets(tint, 192) },
    back_patch = {
      sheet = {
        filename = PREFIX .. "entity/mdrn-loader-structure-back-patch.png",
        priority = "extra-high",
        width = 192,
        height = 192,
        scale = 0.5,
      },
    },
    front_patch = {
      sheet = {
        filename = PREFIX .. "entity/mdrn-loader-structure-front-patch.png",
        priority = "extra-high",
        width = 192,
        height = 192,
        scale = 0.5,
      },
    },
  }
end

return graphics
