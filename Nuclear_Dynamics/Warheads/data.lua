require("Warheads.prototypes.warheads")
require("Warheads.prototypes.basegame-weapontype-add")

if mods["SchallTankPlatoon"] then
  require("Warheads.prototypes.compatibility.SchallTankPlatoon-weapontypes")
  --require("Warheads.prototypes.compatibility.SchallTankPlatoon-warheads")
end
if mods["space-exploration"] then
  require("Warheads.prototypes.compatibility.SE-weapontypes")
end
if mods["lightArtillery"] or mods["lightArtillery-Balanced"]then
  require("Warheads.prototypes.compatibility.LightArtillery-weapontypes")
end


if mods["bobwarfare"] then
  require("Warheads.prototypes.compatibility.bobs-weapontypes")
end


if mods["Krastorio2"] then
  require("Warheads.prototypes.compatibility.K2-weapontypes")
end

if mods["IndustrialRevolution"] then
  require("Warheads.prototypes.compatibility.IR2-tmp-patch")
end
if mods["aai-vehicles-ironclad"] then
  require("Warheads.prototypes.compatibility.aai-ironclad")
end
if mods["RampantArsenal"] then
  require("Warheads.prototypes.compatibility.rampant-arsenal")
end




