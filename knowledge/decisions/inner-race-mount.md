---
type: Design Decision
title: Z base on the inner race
description: "The Z base bolts to the turntable bearing's inner race; the countersunk outer race is the fixed one."
timestamp: "2026-09-13T00:00:00Z"
status: settled
tags: [base, bearing]
---

A zoom on the race boundary showed countersinks on the outer ring and plain holes on the
inner. A countersink seen from above takes a flat head driven down into what sits below,
so the outer ring is fixed and the inner ring turns.

Not a two-number swap: the underside relief has to move with the bolt circle, or the plate
rests on the fixed ring and rubs as it turns. `mount_race` in
[`z-base.scad`](../../cad/parts/z-base.scad) drives all three together.
