-- Hyper Logistics tier definitions.
-- Vanilla roboport (2.0): robot_slots=7, material_slots=7, logistics_radius=25, construction_radius=55,
--   4×500kW chargers, buffer 100MJ, input 5MW.
-- Vanilla robots: logistic payload=1 speed=0.05 energy=1.5MJ; construction payload=1 speed=0.06 energy=3MJ.
--
-- Roboport: slots ×2 each tier; radii ×1.5 each tier (from previous); chargers scale with capacity.
-- Robots: cargo & speed ×4 each tier vs previous (1→4→16→64); batteries ×4 so range stays usable.

local M = {}

M.tints = {
  {
    r = 0.25, g = 0.85, b = 1.0, a = 1,
    icon_a = 0.55,
  },
  {
    r = 0.75, g = 0.35, b = 1.0, a = 1,
    icon_a = 0.55,
  },
  {
    r = 1.0, g = 0.72, b = 0.15, a = 1,
    icon_a = 0.55,
  },
}

-- Charging pad layouts around a 4×4 roboport footprint
M.charging_offsets = {
  {
    { -1.5, -1.5 }, { 0, -1.5 }, { 1.5, -1.5 },
    { -1.5, 1.5 }, { 0, 1.5 }, { 1.5, 1.5 },
  },
  {
    { -1.5, -1.5 }, { 0, -1.5 }, { 1.5, -1.5 },
    { -1.9, 0 }, { 1.9, 0 },
    { -1.5, 1.5 }, { 0, 1.5 }, { 1.5, 1.5 },
  },
  {
    { -1.5, -1.8 }, { -0.5, -1.8 }, { 0.5, -1.8 }, { 1.5, -1.8 },
    { -2.0, -0.6 }, { 2.0, -0.6 },
    { -2.0, 0.6 }, { 2.0, 0.6 },
    { -1.5, 1.8 }, { -0.5, 1.8 }, { 0.5, 1.8 }, { 1.5, 1.8 },
  },
}

-- Absolute stats derived from vanilla ×2 / ×1.5 chains
M.roboports = {
  {
    tier = 1,
    name = "hl-roboport-1",
    previous_item = "roboport",
    robot_slots_count = 14,
    material_slots_count = 14,
    logistics_radius = 37.5,   -- 25 × 1.5
    construction_radius = 82.5, -- 55 × 1.5
    charging_energy = "750kW",
    energy_usage = "75kW",
    recharge_minimum = "80MJ",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "10MW",
      buffer_capacity = "200MJ",
    },
    max_health = 750,
    order = "c[signal]-b[hl-roboport-1]",
    ingredients = {
      { type = "item", name = "roboport", amount = 1 },
      { type = "item", name = "processing-unit", amount = 20 },
      { type = "item", name = "steel-plate", amount = 40 },
      { type = "item", name = "electric-engine-unit", amount = 10 },
    },
    energy_required = 10,
    tech = {
      name = "hl-roboports-1",
      count = 400,
      time = 30,
      prerequisites = { "logistic-system" },
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "utility-science-pack", 1 },
      },
    },
  },
  {
    tier = 2,
    name = "hl-roboport-2",
    previous_item = "hl-roboport-1",
    robot_slots_count = 28,
    material_slots_count = 28,
    logistics_radius = 56.25,    -- 37.5 × 1.5
    construction_radius = 123.75, -- 82.5 × 1.5
    charging_energy = "1MW",
    energy_usage = "100kW",
    recharge_minimum = "160MJ",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "20MW",
      buffer_capacity = "400MJ",
    },
    max_health = 1000,
    order = "c[signal]-c[hl-roboport-2]",
    ingredients = {
      { type = "item", name = "hl-roboport-1", amount = 1 },
      { type = "item", name = "processing-unit", amount = 40 },
      { type = "item", name = "low-density-structure", amount = 20 },
      { type = "item", name = "electric-engine-unit", amount = 20 },
    },
    energy_required = 15,
    tech = {
      name = "hl-roboports-2",
      count = 600,
      time = 45,
      prerequisites = { "hl-roboports-1", "production-science-pack" },
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 },
      },
    },
  },
  {
    tier = 3,
    name = "hl-roboport-3",
    previous_item = "hl-roboport-2",
    robot_slots_count = 56,
    material_slots_count = 56,
    logistics_radius = 84.375,    -- 56.25 × 1.5
    construction_radius = 185.625, -- 123.75 × 1.5
    charging_energy = "1.5MW",
    energy_usage = "150kW",
    recharge_minimum = "320MJ",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "40MW",
      buffer_capacity = "800MJ",
    },
    max_health = 1500,
    order = "c[signal]-d[hl-roboport-3]",
    ingredients = {
      { type = "item", name = "hl-roboport-2", amount = 1 },
      { type = "item", name = "processing-unit", amount = 80 },
      { type = "item", name = "low-density-structure", amount = 40 },
      { type = "item", name = "steel-plate", amount = 100 },
    },
    energy_required = 20,
    tech = {
      name = "hl-roboports-3",
      count = 1000,
      time = 60,
      prerequisites = { "hl-roboports-2", "space-science-pack" },
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 },
        { "space-science-pack", 1 },
      },
    },
  },
}

-- Robot tier shared stats; cargo & speed ×4 vs previous; battery ×4 so range stays usable.
M.robots = {
  {
    tier = 1,
    max_payload_size = 4,   -- 1 × 4
    speed_mult = 4,         -- vanilla × 4
    energy_mult = 4,
    energy_per_move = "5kJ",
    order_suffix = "c",
    logistic_prev = "logistic-robot",
    construction_prev = "construction-robot",
    ingredients_logistic = {
      { type = "item", name = "logistic-robot", amount = 1 },
      { type = "item", name = "processing-unit", amount = 2 },
      { type = "item", name = "electric-engine-unit", amount = 1 },
      { type = "item", name = "battery", amount = 4 },
    },
    ingredients_construction = {
      { type = "item", name = "construction-robot", amount = 1 },
      { type = "item", name = "processing-unit", amount = 2 },
      { type = "item", name = "electric-engine-unit", amount = 1 },
      { type = "item", name = "battery", amount = 4 },
    },
    energy_required = 5,
    tech = {
      name = "hl-robots-1",
      count = 300,
      time = 30,
      prerequisites = { "logistic-system", "utility-science-pack" },
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "utility-science-pack", 1 },
      },
    },
  },
  {
    tier = 2,
    max_payload_size = 16,  -- 4 × 4
    speed_mult = 16,        -- 4^2
    energy_mult = 16,
    energy_per_move = "5kJ",
    order_suffix = "d",
    logistic_prev = "hl-logistic-robot-1",
    construction_prev = "hl-construction-robot-1",
    ingredients_logistic = {
      { type = "item", name = "hl-logistic-robot-1", amount = 1 },
      { type = "item", name = "processing-unit", amount = 4 },
      { type = "item", name = "low-density-structure", amount = 2 },
      { type = "item", name = "battery", amount = 8 },
    },
    ingredients_construction = {
      { type = "item", name = "hl-construction-robot-1", amount = 1 },
      { type = "item", name = "processing-unit", amount = 4 },
      { type = "item", name = "low-density-structure", amount = 2 },
      { type = "item", name = "battery", amount = 8 },
    },
    energy_required = 8,
    tech = {
      name = "hl-robots-2",
      count = 500,
      time = 45,
      prerequisites = { "hl-robots-1", "production-science-pack" },
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 },
      },
    },
  },
  {
    tier = 3,
    max_payload_size = 64,  -- 16 × 4
    speed_mult = 64,        -- 4^3
    energy_mult = 64,
    energy_per_move = "5kJ",
    order_suffix = "e",
    logistic_prev = "hl-logistic-robot-2",
    construction_prev = "hl-construction-robot-2",
    ingredients_logistic = {
      { type = "item", name = "hl-logistic-robot-2", amount = 1 },
      { type = "item", name = "processing-unit", amount = 8 },
      { type = "item", name = "low-density-structure", amount = 4 },
      { type = "item", name = "battery", amount = 16 },
    },
    ingredients_construction = {
      { type = "item", name = "hl-construction-robot-2", amount = 1 },
      { type = "item", name = "processing-unit", amount = 8 },
      { type = "item", name = "low-density-structure", amount = 4 },
      { type = "item", name = "battery", amount = 16 },
    },
    energy_required = 12,
    tech = {
      name = "hl-robots-3",
      count = 800,
      time = 60,
      prerequisites = { "hl-robots-2", "space-science-pack" },
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 },
        { "space-science-pack", 1 },
      },
    },
  },
}

return M
