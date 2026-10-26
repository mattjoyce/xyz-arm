---
type: Printed Part
title: Pulley spine cap
description: A 20 x 20 hood over the spine top with a 12 mm pulley inside that drops both runs of the balance line into the front and rear slot channels.
timestamp: "2026-09-20T00:00:00Z"
status: current design
resource: cad/parts/spine-cap-pulley.scad
tags: [balance, spine]
---

Replaced the V-groove [spine cap](/parts/spine-cap.md) once its capstan friction proved too
stiff on the rig. See [pulley not groove](/decisions/pulley-not-groove.md).

The pulley is from the parts box: 12 OD, 10.3 at the line, 4 wide, ball bearing on a 3 mm
bore. Centred on the rail axis with the axle across X, the two braid runs leave it 10.7 mm
apart, which puts each 4.65 mm under its face, inside the front and rear slot channels. So the
line runs hidden in the rail on both sides.

Printed in two parts after the one-piece hood proved awkward to bed (iteration 31, iteration 32, iteration 33).
`part` selects the output: `spine-cap-plate.stl` and `spine-cap-block.stl` are the pair,
joined by one M2 × 8; `spine-cap-onepiece.stl` is the original hood.

# Files

* [`spine-cap-pulley.scad`](../../cad/parts/spine-cap-pulley.scad)
