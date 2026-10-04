# Hyper Logistics

**Version:** 0.1.2 · **Factorio:** 2.0 · **Author:** Brian_Thunderstruck

Three roboport tiers above vanilla and three tiers of improved logistic **and** construction robots. Tint-based graphics from vanilla sprites (no third-party assets). Soft-compatible with Space Age.

## Balance

### Vanilla baselines (Factorio 2.0)

| Entity | Key stats |
|--------|-----------|
| Roboport | 7 robot slots, 7 material slots, logistics **25**, construction **55**, 4×500 kW chargers |
| Logistic robot | cargo **1**, speed **0.05**, battery **1.5 MJ** |
| Construction robot | cargo **1**, speed **0.06**, battery **3 MJ** |

Space Age does not add a higher roboport; it only adjusts heating / surface conditions on the vanilla one. This mod copies those fields onto Hyper roboports when present.

### Roboports

- **Robot / material slots:** strict **×2** each tier from the previous (vanilla → MK1 → MK2 → MK3).
- **Radii:** both `logistics_radius` and `construction_radius` scale **×1.5** each tier (covers logistic, construction, and the practical delivery/build reach of the network).
- **Charging:** more pads + higher `charging_energy` / buffer / input limit so large fleets can recharge.

| Tier | Entity | Robot slots | Material slots | Logistics r | Construction r | Chargers | Charge rate | Buffer / input |
|------|--------|-------------|----------------|-------------|----------------|----------|-------------|----------------|
| Vanilla | `roboport` | 7 | 7 | 25 | 55 | 4 | 500 kW | 100 MJ / 5 MW |
| MK1 | `hl-roboport-1` | **14** | **14** | **37.5** | **82.5** | 6 | 750 kW | 200 MJ / 10 MW |
| MK2 | `hl-roboport-2` | **28** | **28** | **56.25** | **123.75** | 8 | 1 MW | 400 MJ / 20 MW |
| MK3 | `hl-roboport-3` | **56** | **56** | **84.375** | **185.625** | 12 | 1.5 MW | 800 MJ / 40 MW |

Upgrade planner: `roboport` → MK1 → MK2 → MK3 (`fast_replaceable_group = roboport`).

### Robots

Cargo and speed are a strict **×4 chain** vs the previous tier (vanilla → MK1 → MK2 → MK3). Batteries scale **×4** the same way so flight range stays usable. `energy_per_move` stays at vanilla **5 kJ**. No engine cargo clamp applied (64 is within normal `max_payload_size` range).

| Tier | Cargo | Speed mult | Logistic speed | Construction speed | Logistic energy | Construction energy | energy/move |
|------|-------|------------|----------------|--------------------|-----------------|---------------------|-------------|
| Vanilla | 1 | 1× | 0.05 | 0.06 | 1.5 MJ | 3 MJ | 5 kJ |
| MK1 | **4** | **4×** | 0.20 | 0.24 | 6 MJ | 12 MJ | 5 kJ |
| MK2 | **16** | **16×** | 0.80 | 0.96 | 24 MJ | 48 MJ | 5 kJ |
| MK3 | **64** | **64×** | 3.20 | 3.84 | 96 MJ | 192 MJ | 5 kJ |

Worker robot storage researches still apply on top of these base cargo values. Roboport slot capacity remains the **×2** chain (unchanged).

## Tech / recipe unlock chain

```
logistic-system
 ├─ hl-roboports-1  →  hl-roboport-1
 │    └─ (+ production-science-pack) hl-roboports-2  →  hl-roboport-2
 │         └─ (+ space-science-pack) hl-roboports-3  →  hl-roboport-3
 └─ hl-robots-1  →  hl-logistic-robot-1 + hl-construction-robot-1
      └─ (+ production-science-pack) hl-robots-2  →  MK2 both
           └─ (+ space-science-pack) hl-robots-3  →  MK3 both
```

Recipes craft from the previous tier plus processing units, batteries / engines, and later low-density structures. With Space Age, MK3 recipes soft-add superconductors when that item exists.

## Install

1. Copy `Hyper_Logistics` into `%APPDATA%\Factorio\mods` (folder or `Hyper_Logistics_0.1.2.zip`).
2. Enable in the mods list and restart Factorio.

Dependencies: `base >= 2.0`. Optional: `space-age` (load order + heating/surface sync + superconductor recipe tweak).

## License

MIT — see `LICENSE`. Thumbnail is a tinted crop of the vanilla roboport icon for mod identification only; runtime graphics reference `__base__` sprites with tints.
