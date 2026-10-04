# Ultimate Belts Logistics

**Version:** 0.1.9 · **Factorio:** 2.0 · **Author:** Brian_Thunderstruck

Loaders and high-speed inserters that adapt to:

- [Ultimate Belts Space Age](https://mods.factorio.com/mod/UltimateBeltsSpaceAge) (`UltimateBeltsSpaceAge`)
- [Double Speed Belts](https://mods.factorio.com/mod/DoubleSpeedBelts) (`DoubleSpeedBelts`)

Enable **at least one** of those belt mods. Both can be enabled together.

## How compatibility works

- **UBSA present:** creates `ubsa-*-loader` / `ubsa-*-inserter` for the five UBSA belt tiers (inserters from **ultra-fast** upward).
- **DSB present:** creates `ubsa-dsb-*-loader` for vanilla/SA `transport` → `fast` → `express` → `turbo` (no DSB inserters).
- **DSB speed rewrite:** Double Speed Belts changes belt speeds in `data-final-fixes`. This mod runs **after** DSB and resyncs loader/inserter speeds from the final `transport-belt.speed`.

Inserter scaling (UBSA tiers):

```
items/s = belt.speed * 480
factor = max(items/s / 60, 1)   -- bulk-inserter ≈ turbo 60/s baseline
extension_speed = 0.14 * factor
rotation_speed  = 0.04 * factor
```

## UBSA tiers

| Belt | Loader | Inserter |
|------|--------|----------|
| ultra-fast-belt | ubsa-ultra-fast-loader | ubsa-ultra-fast-inserter |
| extreme-fast-belt | ubsa-extreme-fast-loader | ubsa-extreme-fast-inserter |
| ultra-express-belt | ubsa-ultra-express-loader | ubsa-ultra-express-inserter |
| extreme-express-belt | ubsa-extreme-express-loader | ubsa-extreme-express-inserter |
| ultimate-belt | ubsa-ultimate-loader | ubsa-ultimate-inserter |

## DSB vanilla / SA loaders

| Belt | Loader |
|------|--------|
| transport-belt | ubsa-dsb-transport-loader |
| fast-transport-belt | ubsa-dsb-fast-loader |
| express-transport-belt | ubsa-dsb-express-loader |
| turbo-transport-belt | ubsa-dsb-turbo-loader |

## Inserter tooltips

Each UBSA `ubsa-*-inserter` description shows max supported belt throughput (`items/s = belt.speed × 480`), refreshed after Double Speed Belts.

## Loader descriptions

Loader tooltips note the paired belt, then two lines matching the GUI checkboxes:

```
Split lanes
Overfill machines
```

(RU: `Разделять полосы` / `Переполнять механизмы`)

## Loader GUI

Open any `ubsa-*` loader to get toggles (like Loaders Modernized):

- **Split lanes** / **Разделять полосы** — per-lane filters (`-split` variant)
- **Overfill machines** / **Переполнять механизмы** — ignore machine insert limits (`-fill` variant)

State is stored by swapping entity variants (`name`, `name-split`, `name-fill`, `name-split-fill`).

## Install

1. Enable Ultimate Belts Space Age and/or Double Speed Belts.
2. Keep/copy `UltimateBelts_Logistics` in `%APPDATA%\Factorio\mods` (folder or `UltimateBelts_Logistics_0.1.9.zip`).
3. Restart Factorio.

Optional soft deps: Load-Furn-2-SpaceAgeFix, loaders-modernized (name prefixes avoid clashes).

## Credits

- Ultimate Belts Space Age (Jabor047 / Tyarns lineage)
- Double Speed Belts (darkfrei)
- Tintable loader sprites adapted from loaders-modernized (MIT, kryojenik)
