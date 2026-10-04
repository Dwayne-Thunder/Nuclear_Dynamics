-- Run after optional DoubleSpeedBelts so loader/inserter speeds match final belt.speed.
local generate = require("prototypes.generate")
generate.sync_speeds()
