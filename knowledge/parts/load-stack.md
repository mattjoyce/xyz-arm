---
type: Printed Part
title: Load stack
description: "The counterweight: a printed frame riding the spine's rear slot, holding 50 x 50 x 5 M16 square washers on an M16 bolt."
timestamp: "2026-09-26T00:00:00Z"
status: "printed, in use"
resource: cad/parts/load-stack.scad
tags: [balance, counterweight]
---

Hangs on the balance line behind the spine and slides in the rear T-slot on two 5 mm
sliders. Travels the same 310 mm as the carriage, in the opposite direction.

# Current form

* Floor with a hex pocket for an M16 × 65 bolt head; the bolt shank is the stem.
* Front wall and two corner legs; sides and back open so washers come off by hand.
* Wall stands 4 mm off the rail's rear face to clear the carriage's nylocs.

# Mass

| Item | Mass |
|---|---|
| 50 × 50 × 5 M16 square washer, measured | 86 g each |
| Budget (moving mass, run about 5 % light) | 1.02 kg |
| 12 washers + bolt + frame | 1.161 kg |
| 11 washers | 1.075 kg |
| 10 washers | 0.989 kg |

Trim balance one washer at a time. Spares live on the [washer holder](/parts/washer-holder.md).

# History

Started as stacked shot-filled blocks with guide threads (iteration 25, iteration 26). The guide lines were
given up when the master hung from its bottom like an inverted pendulum (iteration 27). Shot
cells and a lead block gave way to steel washers (iteration 52, iteration 53, iteration 54, iteration 55, iteration 56, iteration 57).
See [counterweight behind the spine](/decisions/counterweight-behind-spine.md).

`load-stack-master.stl`, `load-stack-slide.stl` and `load-stack-test.stl` are exports of the
same file's other outputs. v7 is kept in `cad/backup/2026-09-24-load-stack-v7/`.

# Files

* [`load-stack.scad`](../../cad/parts/load-stack.scad)
* [`load-stack.stl`](../../cad/parts/load-stack.stl)
