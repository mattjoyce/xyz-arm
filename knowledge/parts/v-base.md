---
type: Printed Part
title: V base
description: "Two 300 mm 2020 rails flat on the desk at right angles, with printed angle blocks and a foot holding the bearing's outer race."
timestamp: "2026-09-21T00:00:00Z"
status: "printed, on the desk"
resource: cad/parts/v-base.scad
tags: [base]
---

Replaced the [weighted base](/parts/weight-base.md) after it bent on the bench. See
[V base not weighted base](/decisions/v-base-not-weighted-base.md).

The outer race's four holes form a 90.51 mm square (128 PCD). Three fall on slot lines of the
L: rail A at x = 10 and 100.51, rail B at y = 100.51. The spine sits 78 mm out from the corner
on the diagonal. The fourth hole, the one forward tipping presses down, gets a Ø24 × 25 pillar.

Blocks are right-angle brackets: a 20 × 20 × 5 pad on the rail, a 5 mm leg down its side,
an M5 × 10 into a drop-in tee nut, and a rib in the slot opening to square it
(iteration 44, iteration 45, iteration 47).

Outputs: `v-base-block.stl`, `v-base-foot.stl`.

# Files

* [`v-base.scad`](../../cad/parts/v-base.scad)
