---
type: Printed Part
title: Z base
description: "Printed base on the turntable bearing's inner race that holds the spine's lower end in a 45 mm socket with tee-nut bolts."
timestamp: "2026-09-27T00:00:00Z"
status: "printed, in use (fins variant)"
resource: cad/parts/z-base.scad
tags: [base]
---

Bolts to the bearing's inner race and carries the spine. Three variants share the file:
`full` (revolved cone), `fast` (hub and arms) and `fins` (four gusset fins round a square
boss). `fins` is the one on the rig, `z-base-fins.stl`.

* Socket clearance 0.375 mm per side, chosen from the [base fit test](/parts/base-fit-test.md).
* Rail held by M5 × 10 button heads into drop-in tee nuts at two heights, loaded through
  one shared keyhole window (iteration 21, iteration 22).
* Rail end sits on a 2 mm ledge (iteration 23).
* Mounts to the inner race, see [inner race mount](/decisions/inner-race-mount.md).
* The guide-line groove was removed on 2026-09-27 (iteration 59).

The [socket test](/parts/socket-test.md) prints just the boss from this file's modules.

# Files

* [`z-base.scad`](../../cad/parts/z-base.scad)
* [`z-base.stl`](../../cad/parts/z-base.stl)
