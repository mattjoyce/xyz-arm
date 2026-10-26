---
type: Printed Part
title: Camera mount
description: "A light block under the gantry rail with a 1/4-20 tapped hole, replacing the heavier Manfrotto clamp block at the end of the lever."
timestamp: "2026-09-21T00:00:00Z"
status: "bolt style drawn, not yet printed"
resource: cad/parts/camera-mount.scad
tags: [payload, camera]
---

Each 100 g at the gantry tip is 0.39 N·m at 400 mm, so the camera hardware is the cheapest
mass to cut.

| `style` | Form |
|---|---|
| `slide` | T slider in the rail's underside slot, held by the camera's weight (iteration 42) |
| `bolt` | Right-angle bracket on one tee nut, shelf under the rail with the 1/4 hole on centre (iteration 41, iteration 48) |

The 1/4-20 hole is Ø5.3, a 5.1 tap drill plus 0.2 for printed-hole shrink.
`camera-mount-bolt.stl` is the bolt export.

# Files

* [`camera-mount.scad`](../../cad/parts/camera-mount.scad)
* [`camera-mount.stl`](../../cad/parts/camera-mount.stl)
