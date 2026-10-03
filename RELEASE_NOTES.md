# Nuclear Dynamics 0.1.0 — Release notes

## English

**Nuclear Dynamics** 0.1.0 (Factorio 2.0) — rebranded fork of True Nukes Continued by **AzuraHimura**. Warheads is built in; disable standalone **Warheads** / **Warheads Continued**.

### Breaking
- Mod name is `Nuclear_Dynamics` — not a drop-in replace for `True-Nukes_Continued` saves by mod name.
- Hard conflict with `Warheads` / `Warheads_Continued` — turn them off before enabling this mod.

### Features
- Bundled Warheads framework (no separate dependency)
- Enrichment quality/productivity like Kovarex
- Full Russian locale (+ English)

### Changes
- Remote storage instead of `global`
- Nuclear test sites / recipes fixed for 2.0
- Crater tiles, rails 2.0, safer `tile.name` / `math.random` floor usage

### Bugfixes
- bobwarfare 2.1 ammo (`bob-bullet-magazine`)
- Cannon/shotgun ammo categories
- SE `originPos` crash
- `destructible=false` and nil-guards (`nukeFiredScan` / `nukeBuildingDetonate`)

### Credits
True Nukes (BicycleEater) → True Nukes Continued (Daimonfire; fixes azrogers) → Nuclear Dynamics (AzuraHimura).

---

## Русский

**Nuclear Dynamics** 0.1.0 (Factorio 2.0) — ребренд-форк True Nukes Continued от **AzuraHimura**. Warheads встроен; отключите отдельные **Warheads** / **Warheads Continued**.

### Breaking
- Внутреннее имя мода `Nuclear_Dynamics` — не drop-in замена сейвов с `True-Nukes_Continued` по имени мода.
- Жёсткий конфликт с `Warheads` / `Warheads_Continued` — выключите их перед включением этого мода.

### Features
- Warheads внутри мода (отдельная зависимость не нужна)
- Enrichment: quality/productivity как у Kovarex
- Полная русская локаль (+ английская)

### Changes
- Remote storage вместо `global`
- Правки nuclear test sites / рецептов под 2.0
- Кратерные тайлы, рельсы 2.0, безопаснее `tile.name` / `math.random` floor

### Bugfixes
- bobwarfare 2.1 ammo (`bob-bullet-magazine`)
- Категории ammo cannon/shotgun
- Краш SE `originPos`
- Guards для `destructible=false` и nil в `nukeFiredScan` / `nukeBuildingDetonate`

### Credits
True Nukes (BicycleEater) → True Nukes Continued (Daimonfire; правки azrogers) → Nuclear Dynamics (AzuraHimura).
