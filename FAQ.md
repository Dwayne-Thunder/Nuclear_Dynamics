# Nuclear Dynamics — FAQ

Copy either language section (or both) into the Mod Portal **FAQ** field.

---

## English

### Is this a fork of True Nukes Continued?

Yes. **Nuclear Dynamics** is a rebranded fork of [True Nukes Continued](https://mods.factorio.com/mod/True-Nukes_Continued) for Factorio 2.0 (upstream lineage: True Nukes → True Nukes Continued → this mod).

Internal mod name is `Nuclear_Dynamics`, **not** `True-Nukes_Continued`. It is **not** a drop-in rename for old saves. Disable **True Nukes Continued** (and standalone Warheads — see below) before enabling this mod. Expect broken/missing items if you swap mid-save; a new game or careful migration is safer.

### Do I need Warheads / Warheads Continued separately?

**No.** The Warheads framework is **built into** Nuclear Dynamics. Do **not** install or enable standalone **Warheads** or **Warheads Continued**.

### Why does it conflict with Warheads?

The mod declares a hard conflict (`! Warheads`, `! Warheads_Continued`) because the same framework is already bundled. Running both would double-register prototypes and break loading. Turn Warheads / Warheads Continued **off**, then enable Nuclear Dynamics.

### Big nukes (15 kt / 100 kt+) freeze the game — what can I do?

Expected on dense maps. Tips:

- Keep **Optimise 100kt** enabled (runtime setting). Required path for very large yields; damage applies as chunks load.
- Raise fire/blast **scaledown** settings; disable short-lived random fires if needed.
- Prefer ~500 t for routine nest clearing; save 15 kt / 100 kt+ for special cases.
- Don’t leave nuclear artillery on autofire near your base.
- If still OOM/lagging: disable **Generate Crater**, or avoid 100 kt+ over fully generated factory areas.

Under ~20 t is usually fine; 500 t–15 kt can hitch; 100 kt+ can freeze for seconds to minutes.

### Craters fill with water — how do I stop that?

By design, crater tiles can slowly fill / connect to nearby water and flood low areas (bad for factories). Mitigations:

- Don’t detonate large yields over/next to water or factory floors you care about.
- Landfill / reconstruction ghosts after the blast.
- Turn off **Generate Crater** (runtime) if you want no crater tiles at all (also helps performance; large yields that need the new crater tile system may be limited).

There is no separate “pretty crater but never floods” toggle in current settings.

### Can I disable thermobarics?

Yes. Startup settings:

- **Enable small thermobaric warheads**
- **Enable medium thermobaric warheads**
- **Enable large thermobaric warheads**

Turn all three off to remove thermobaric content. Changing startup settings requires a restart / reload.

### Can I remove Californium from the crafting chain?

Yes. Startup setting **small-boom-material** (low-yield material):

- Set to **Same as medium-large** (usually Uranium-235) to skip Californium for small yields.
- Default / “True Nukes Default” uses Californium-251.

Restart required after changing startup settings.

### Compatibility with other nuke mods / MushroomCloud / Space Age quality?

- **Other nuclear-weapon overhaul mods:** generally poor coexistence — they rewrite the same techs/items. Prefer one nuke overhaul.
- **MushroomCloud:** not required. Explosion graphics/sounds are adapted from Arcitos’ MushroomCloud and bundled/adapted in-mod. Optional flash style setting: **TN-mushroom-cloud-style-nuclear-flash**.
- **Space Age quality:** enrichment recipes support **quality** and **productivity** similar to Kovarex.
- Soft compatibility exists for mods like Schall Tank Platoon, Bob’s Warfare, Space Exploration, Krastorio 2, etc. Chunk-based 100 kt detonations can clash with scripted chunk-load mods (e.g. Ruins) — disable Optimise 100kt only if you accept the cost.

### “Unexpected UTF-8 BOM” / how should I install the mod?

Install from the **Mod Portal** (recommended), or place the official zip so Factorio sees a folder named `Nuclear_Dynamics` under your `mods` directory (e.g. `mods/Nuclear_Dynamics_0.1.0/...` with `info.json` inside).

If you rebuild/repack yourself: `info.json` must be **UTF-8 without BOM**. A UTF-8 BOM (`EF BB BF`) causes portal upload error: *Unexpected UTF-8 BOM*. Don’t save `info.json` as “UTF-8 with BOM” in Windows editors.

### Languages?

**English** and **Russian** locales are included. UI language follows Factorio’s language setting.

### Who made this? Credits?

| Role | Credit |
|------|--------|
| Nuclear Dynamics (this fork) | **Brian_Thunderstruck** |
| True Nukes (original) | **BicycleEater** |
| True Nukes Continued (2.0) | **Daimonfire** |
| Fixes | **azrogers** |
| Explosion graphics/sounds | **Arcitos** (MushroomCloud) |

License: **MIT**. Source: [Dwayne-Thunder/Nuclear_Dynamics](https://github.com/Dwayne-Thunder/Nuclear_Dynamics).

### Do I need True-Nukes-Graphics / True-Nukes-Graphics_Continued?

**No, optional.** Base explosion graphics are already in Nuclear Dynamics. The separate [True-Nukes-Graphics_Continued](https://mods.factorio.com/mod/True-Nukes-Graphics_Continued) pack only upgrades large-explosion visuals (higher VRAM use). Install only if you want less pixelated big blasts and can afford the memory cost.

---

## Русский

### Это форк True Nukes Continued? Совместимы ли сейвы?

Да. **Nuclear Dynamics** — ребренд-форк [True Nukes Continued](https://mods.factorio.com/mod/True-Nukes_Continued) для Factorio 2.0 (линия: True Nukes → True Nukes Continued → этот мод).

Внутреннее имя: `Nuclear_Dynamics`, **не** `True-Nukes_Continued`. Это **не** drop-in замена по имени мода. Перед включением отключите **True Nukes Continued** и отдельные Warheads (см. ниже). Сейв «просто переключить мод» часто ломает предметы/исследования — безопаснее новая игра или осторожная миграция.

### Нужен ли отдельно Warheads / Warheads Continued?

**Нет.** Фреймворк Warheads **встроен**. Отдельные **Warheads** / **Warheads Continued** ставить и включать **не нужно**.

### Почему conflict с Warheads?

Жёсткий конфликт в `info.json` (`! Warheads`, `! Warheads_Continued`): тот же код уже внутри Nuclear Dynamics. Два мода сразу дублируют прототипы и ломают загрузку. Выключите Warheads / Warheads Continued, затем включите Nuclear Dynamics.

### Большие ядра (15 кт / 100 кт+) фризят игру — что делать?

Нормально на плотной карте. Что помогает:

- Не отключайте **Optimise 100kt** (runtime) — для крупных мощностей урон идёт по мере загрузки чанков.
- Поднимите **scaledown** огня/волны; при необходимости отключите короткие случайные пожары.
- Для зачистки обычно хватает ~500 т; 15 кт / 100 кт+ — редко.
- Не ставьте ядерную артиллерию на автоогонь у базы.
- При OOM/лагах: выключите **Generate Crater** или не взрывайте 100 кт+ над полностью прогруженной базой.

До ~20 т обычно быстро; 500 т–15 кт — заметные фризы; 100 кт+ — от секунд до минут.

### Кратеры заливает водой — как отключить?

Так задумано: тайлы кратера могут медленно заполняться / соединяться с водой и топить низины (опасно для фабрики). Что делать:

- Не взрывайте крупные заряды над водой или над важной базой.
- Засыпайте landfill’ом / восстанавливайте по ghost.
- Выключите **Generate Crater** (runtime), если кратер не нужен вообще (плюс к производительности; без новой системы тайлов кратера крупные 100 кт+ ограничены).

Отдельной настройки «красивый кратер, но без затопления» в текущих settings нет.

### Можно ли выключить термобарики?

Да. Startup-настройки:

- **Enable small thermobaric warheads**
- **Enable medium thermobaric warheads**
- **Enable large thermobaric warheads**

Выключите все три. После смены startup нужен перезапуск / reload.

### Можно ли убрать калифорний из цепочки?

Да. Startup **small-boom-material** (материал малых мощностей):

- **Same as medium-large** — обычно Uranium-235, без калифорния для малых зарядов.
- Default / «True Nukes Default» — Californium-251.

Нужен restart после смены startup.

### Совместимость с другими nuke-модами / MushroomCloud / quality Space Age?

- **Другие моды, переписывающие ядерное оружие:** обычно плохо уживаются. Лучше один overhaul.
- **MushroomCloud:** не нужен. Графика/звук взрывов на базе Arcitos (MushroomCloud), уже в моде. Опционально: **TN-mushroom-cloud-style-nuclear-flash**.
- **Space Age quality:** enrichment поддерживает **quality** и **productivity** как у Kovarex.
- Мягкая совместимость: Schall Tank Platoon, Bob’s Warfare, Space Exploration, Krastorio 2 и др. Чанковые детонации 100 кт могут конфликтовать со скриптовой загрузкой чанков (напр. Ruins) — Optimise 100kt отключайте только если готовы к цене по CPU/RAM.

### Ошибка UTF-8 BOM / как ставить мод (zip)?

Лучше ставить с **Mod Portal**. Вручную: zip должен разворачиваться в папку `Nuclear_Dynamics` в каталоге `mods` (внутри — `info.json`).

Если собираете zip сами: `info.json` только **UTF-8 без BOM**. BOM (`EF BB BF`) даёт ошибку портала *Unexpected UTF-8 BOM*. Не сохраняйте файл как «UTF-8 с BOM» в Windows.

### Языки?

Есть локали **английская** и **русская**. Язык UI = язык Factorio.

### Автор / кредиты?

| Роль | Кто |
|------|-----|
| Nuclear Dynamics (этот форк) | **Brian_Thunderstruck** |
| True Nukes (оригинал) | **BicycleEater** |
| True Nukes Continued (2.0) | **Daimonfire** |
| Правки | **azrogers** |
| Графика/звук взрывов | **Arcitos** (MushroomCloud) |

Лицензия: **MIT**. Репозиторий: [Dwayne-Thunder/Nuclear_Dynamics](https://github.com/Dwayne-Thunder/Nuclear_Dynamics).

### Нужен ли True-Nukes-Graphics / True-Nukes-Graphics_Continued?

**Нет, опционально.** Базовая графика взрывов уже в Nuclear Dynamics. Отдельный пак [True-Nukes-Graphics_Continued](https://mods.factorio.com/mod/True-Nukes-Graphics_Continued) только улучшает большие взрывы (больше VRAM). Ставьте, если хотите менее «пиксельные» крупные вспышки и хватает памяти.
