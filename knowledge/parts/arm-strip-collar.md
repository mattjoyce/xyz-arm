---
type: Printed Part
title: Strip collar
description: "A thin band round the gantry rail that holds a 2 x 15.5 mm steel strip flat along one face, as a track for the magnetic Olight."
timestamp: "2026-09-27T00:00:00Z"
status: drawn
resource: cad/parts/arm-strip-collar.scad
tags: [gantry, lighting]
---

With `floor_t = 0` the strip's pocket is open to the rail, so pushing the strip in pulls the
band tight: one push fit holds both. With the strip out, the band slides along the rail
(iteration 58).

The strip exists for lighting reach. A light on a magnet track can sit up to 400 mm off the
camera for a raking angle; see the [design note](/references/design-note.md). Use carbon steel,
since austenitic stainless is not magnetic.

# Files

* [`arm-strip-collar.scad`](../../cad/parts/arm-strip-collar.scad)
* [`arm-strip-collar.stl`](../../cad/parts/arm-strip-collar.stl)
