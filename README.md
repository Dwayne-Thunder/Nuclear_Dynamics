# Nuclear Dynamics

**Version:** 0.1.0 · **Factorio:** 2.0 · **Author:** [AzuraHimura](https://steamcommunity.com/id/AzuraHimura)

Realistic nuclear and thermobaric weapons with scalable yields, blast physics, cratering, radiation, and extensive configuration options.

Based on [True Nukes](https://mods.factorio.com/mod/True-Nukes) / [True Nukes Continued](https://mods.factorio.com/mod/True-Nukes_Continued). The former **Warheads** / Warheads Continued framework is **built into this mod** — no separate Warheads dependency.

---

## English

### Overview

Nuclear Dynamics expands Factorio’s atomic arsenal with physically inspired blast effects: thermal flash, blast wave, fireball, crater, lingering radiation, and pollution. Yields range from tiny ammo rounds up to gigaton-class building detonations. Thermobaric (fuel-air) weapons fill an earlier “wide area” niche.

This is a rebranded fork maintained by **AzuraHimura**, for Factorio **2.0**. Upstream lineage: **BicycleEater** (original True Nukes), **Daimonfire** (2.0 Continued port), with thanks to **azrogers** for fixes. Latest known True Nukes Continued release on the portal: **0.3.36**.

### Effects

| Effect | What it does |
|--------|----------------|
| **Thermal radiation** | Instant burn/damage over a wide area |
| **Blast wave** | Expanding pressure wave that damages structures and trees |
| **Fireball** | Vaporizes everything within its radius |
| **Crater** | Inner depression (can slowly fill with water) + outer overturned land (landfill-style tiles); configurable |
| **Radiation** | Long-lasting poison-like cloud (dark) |
| **Pollution** | Roughly `tonnage + 1000×uranium + 100×californium + 10000×tritium` |

Graphics/sounds are based on **MushroomCloud** (Arcitos), bundled/adapted in-mod. Optional high-res large explosions: [True-Nukes-Graphics_Continued](https://mods.factorio.com/mod/True-Nukes-Graphics_Continued) (VRAM trade-off). Yield numbers are informed by [NUKEMAP](https://nuclearsecrecy.com/nukemap/).

### Nuclear weapons (summary)

- **MG ammo:** ~0.1 t · high-yield ~0.5 t  
- **Tank cannon:** ~2 t · high-yield ~4 t  
- **Rockets:** ~2 / 4 / 8 t  
- **Base atomic bomb:** ~20 t (“Davy Crockett” class)  
- **Artillery:** ~20 t · ~500 t · ~1 kt · ~15 kt (Hiroshima-class) · ~100 kt  
- **Rocket-launched** variants of the 500 t and 1 kt shells  
- **Nuclear weapon building:** 15 kt, 100 kt, 1 Mt, 5 Mt, 10 Mt, 50 Mt, 100 Mt, **1 Gt**

**Schall Tank Platoon** (optional): nuclear and thermobaric shells for auto-cannon, 88 mm, and 128 mm (yields aligned with the main progression, e.g. 0.5–20 t).

**100 kt+:** chunk-based detonation to avoid loading the whole map; damage applies as chunks generate. Keep “Optimise 100 kt” enabled unless you accept heavy RAM/CPU cost. New crater tiles must stay enabled for these yields.

### Thermobaric weapons

Not nuclear — fuel that ignites with air; share blast/fire systems and act as expensive early/mid-game area weapons:

| Size | Delivery | Outer blast radius |
|------|----------|--------------------|
| Small | Tank cannon shell | ~40 m |
| Medium | Rocket | ~80 m |
| Large | Artillery shell | ~120 m |

Own research (chemical + military science). Weaker vs behemoths than nukes; lots of fire → can hitch FPS if spammed. Can be disabled in settings if they feel too strong early.

### Materials & equipment

- **Californium** — refined from U-235; justifies small yields. Can be skipped via settings (weapons use U-235 directly).  
- **Tritium** — from special fuel cells after reactor use; needed for 100 kt+.  
- **Fogbank** — exotic material for the 100 kt artillery shell.  
- **Fire shield** — equipment that stops nukes/thermobarics from setting *you* on fire; high power draw, limited other protection (especially helpful for light vehicles / aircraft mods).

### Performance & settings tips

- Smaller yields (&lt;20 t) are usually fine; 500 t / 1 kt / 15 kt cause longer freezes and post-blast slowdown; 100 kt+ can freeze for seconds to minutes on dense maps.  
- If slow or OOM: disable short-lived fire spam, raise fire/blast reduction settings, use the optimised detonation system, keep 100 kt optimisation on, prefer 500 t for routine clearing.  
- Artillery auto-fire with nuclear shells is risky — clear nearby nests with normal shells first.  
- Crater water fill is on by default; ghosts/landfill helpers mitigate factory flooding. Older crater mode exists for tile-slot compatibility but blocks 100 kt+.

### Compatibility

Optional soft deps (see `info.json`): SchallTankPlatoon, bobwarfare, space-exploration, Krastorio2, RampantArsenal, aai-vehicles-ironclad, lightArtillery (+ Balanced). Hard conflict with standalone **Warheads** / **Warheads_Continued** (bundled here).

Does not coexist cleanly with other mods that rewrite nuclear weapons. Chunk detonations can clash with scripted chunk-load mods (e.g. Ruins) — disable chunk-based 100 kt if needed. Bob’s: costs adjusted; Bob’s atomic artillery removed in favour of this mod’s shells.

### Credits & license

| Role | Credit |
|------|--------|
| Current fork (Nuclear Dynamics) | **AzuraHimura** |
| True Nukes (original) | **BicycleEater** |
| True Nukes Continued (2.0) | **Daimonfire** |
| Fixes | **azrogers** |
| Explosion graphics/sounds | **Arcitos** (MushroomCloud) |

- License: **MIT** (see `LICENSE`)  
- Upstream mod portal: [True Nukes Continued](https://mods.factorio.com/mod/True-Nukes_Continued)  
- Upstream source (Continued): [Daimonfire1/Factorio-True-Nukes_Continued](https://github.com/Daimonfire1/Factorio-True-Nukes_Continued)  
- This repository: [Dwayne-Thunder/Nuclear_Dynamics](https://github.com/Dwayne-Thunder/Nuclear_Dynamics)  
- Author contact: [Steam — AzuraHimura](https://steamcommunity.com/id/AzuraHimura)

---

## Русский

### Кратко

**Nuclear Dynamics** — мод для Factorio **2.0** с реалистичными ядерными и термобарическими взрывами: тепловая вспышка, ударная волна, огненный шар, кратер, радиация, загрязнение. Мощности — от магазина патронов до гигатонного здания-детонатора.

Форк и ребренд поддерживает **AzuraHimura**. Основано на **True Nukes** (BicycleEater) и **True Nukes Continued** (порт 2.0 — Daimonfire; правки — azrogers). Фреймворк **Warheads** / Warheads Continued **встроен в мод** — отдельная зависимость не нужна. Последняя известная версия Continued на портале: **0.3.36**. Текущая версия этого мода: **0.1.0**.

### Эффекты

| Эффект | Суть |
|--------|------|
| **Тепловое излучение** | Мгновенный урон/ожог на большой площади |
| **Ударная волна** | Расходящаяся волна давления по постройкам и деревьям |
| **Огненный шар** | Уничтожает всё в радиусе |
| **Кратер** | Внутренняя воронка (может заполняться водой) + внешний перевёрнутый грунт; настраивается |
| **Радиация** | Долгоживущее «ядовитое» облако (тёмное) |
| **Загрязнение** | Примерно `тоннаж + 1000×уран + 100×калифорний + 10000×тритий` |

Графика/звук — на базе **MushroomCloud** (Arcitos). Для менее пиксельных больших взрывов опционально: [True-Nukes-Graphics_Continued](https://mods.factorio.com/mod/True-Nukes-Graphics_Continued). Оценки мощностей — с опорой на [NUKEMAP](https://nuclearsecrecy.com/nukemap/).

### Ядерное оружие (кратко)

- **Патроны ПУ:** ~0,1 т · усиленные ~0,5 т  
- **Снаряды танка:** ~2 т · усиленные ~4 т  
- **Ракеты:** ~2 / 4 / 8 т  
- **Базовая атомная бомба:** ~20 т  
- **Артиллерия:** ~20 т · ~500 т · ~1 кт · ~15 кт · ~100 кт  
- **Ракетные** варианты снарядов 500 т и 1 кт  
- **Здание ядерного оружия:** 15 кт … **1 Гт**

**Schall Tank Platoon** (опционально): ядерные и термобарические снаряды под автопушку, 88 мм и 128 мм.

**100 кт+:** детонация по чанкам (урон при генерации чанка). Не отключайте оптимизацию 100 кт без нужды. Нужна новая система тайлов кратера.

### Термобарики

Не ядерное оружие — топливовоздушные заряды с общей физикой волны/огня:

| Размер | Носитель | Внешний радиус |
|--------|----------|----------------|
| Малый | Снаряд танка | ~40 м |
| Средний | Ракета | ~80 м |
| Большой | Артиллерия | ~120 м |

Отдельное исследование; слабее против бегемотов; много огня → нагрузка на FPS. Можно отключить в настройках.

### Материалы и снаряжение

- **Калифорний** — из U-235; для малых мощностей (можно убрать из цепочки).  
- **Тритий** — из спец. ТВЭЛов после реактора; для 100 кт+.  
- **Fogbank** — для артиллерийского снаряда 100 кт.  
- **Огненный щит** — модуль экипировки: не даёт поджечь носителя ядерным/термобарическим огнём (много энергии).

### Производительность и настройки

- До ~20 т обычно быстро; 500 т / 1 кт / 15 кт — заметные фризы; 100 кт+ — от секунд до минут на плотной карте.  
- При лагах/OOM: меньше короткоживущего огня, выше reduction огня/волны, оптимизированная детонация, не отключать Optimise 100 kt.  
- Ядерную артиллерию лучше не ставить на автоогонь.  
- Затопление кратеров водой по умолчанию; в базе могут мешать — см. настройки / старый режим кратера (без 100 кт+).

### Совместимость

Мягкие зависимости — в `info.json` (Schall, Bob’s Warfare, SE, K2 и др.). Жёсткий конфликт с отдельными **Warheads** / **Warheads_Continued**.

Плохо уживается с модами, которые сами меняют ядерное оружие. Чанковые детонации конфликтуют со скриптовой загрузкой чанков (напр. Ruins). С Bob’s — пересчитаны цены, атомная артиллерия Bob’s убирается в пользу снарядов этого мода.

### Авторы, лицензия, ссылки

| Роль | Кто |
|------|-----|
| Текущий форк (Nuclear Dynamics) | **AzuraHimura** |
| Оригинал True Nukes | **BicycleEater** |
| True Nukes Continued (2.0) | **Daimonfire** |
| Правки | **azrogers** |
| Графика/звук взрывов | **Arcitos** (MushroomCloud) |

- Лицензия: **MIT** (файл `LICENSE`)  
- Портал оригинального Continued: [True Nukes Continued](https://mods.factorio.com/mod/True-Nukes_Continued)  
- Исходники Continued: [Daimonfire1/Factorio-True-Nukes_Continued](https://github.com/Daimonfire1/Factorio-True-Nukes_Continued)  
- Этот репозиторий: [Dwayne-Thunder/Nuclear_Dynamics](https://github.com/Dwayne-Thunder/Nuclear_Dynamics)  
- Автор: [Steam — AzuraHimura](https://steamcommunity.com/id/AzuraHimura)
