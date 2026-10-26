---
type: Printed Part
title: Gantry plate
description: "Printed 8 mm plate joining spine and gantry: four V wheels on the spine, three on the gantry, eccentric spacers for preload."
timestamp: "2026-09-23T00:00:00Z"
status: "exported, not yet printed"
resource: cad/parts/compact-carriage.scad
tags: [carriage, wheels]
---

The joint between the vertical spine and the horizontal gantry. One printed plate, wheels on
both faces, each rail running between its own set.

# Wheel layout

| Face | Fixed | Eccentric | Pitch |
|---|---|---|---|
| Spine | 2, at x = -20.32, y = ±30 | 2, opposite them | 60 mm |
| Gantry | 2 | 1, centre, opposing | 60 mm |

Wheel-axis offset from rail centre is 20.32 mm at drawn tangency. Eccentric collar holes are
7.5 mm because 7.31 printed about 0.3 small on this printer (iteration 51).

# History

* v2 printed with 3 + 3 wheels (iteration 29), then with eccentrics (iteration 30).
* Eccentrics only gripped at the end of their travel; real contact sits about 0.59 mm
  inside drawn tangency (iteration 46).
* The 3-wheel spine set could not hold the arm's moment, so a fourth spine wheel was added.
  See [four spine wheels](/decisions/four-spine-wheels.md).
* A metal-plate hybrid was drawn and dropped, see [gantry carriage](/parts/gantry-carriage.md).

`compact-carriage-solid.scad` is a Cura modifier mesh that sets 100 % infill round each wheel
station. The 3 + 3 plate is kept in `cad/backup/2026-09-23-compact-carriage-3wheel/`.

Hardware data comes from [wheel spacer](/parts/wheel-spacer.md) and [V wheel](/parts/vslot-wheel.md).

# Files

* [`compact-carriage.scad`](../../cad/parts/compact-carriage.scad)
* [`compact-carriage.stl`](../../cad/parts/compact-carriage.stl)
