---
type: Project
title: XYZ Arm
description: A counterbalanced 2020 V-slot desk arm that holds a phone camera over a bench calibration mat.
timestamp: "2026-09-27T00:00:00Z"
tags: [overview]
---

The XYZ Arm holds a Pixel 6a flat over a calibration mat so the DeskCam tool can photograph
and measure things on the bench. Hand-positioned, balanced so it stays where it is left.

# Structure

| Axis or role | What does it |
|---|---|
| Rotation | Salvaged 140 mm lazy-susan bearing, see [turntable bearing](/parts/turntable-bearing.md) |
| Foot | [V base](/parts/v-base.md) under the outer race, [Z base](/parts/z-base.md) on the inner race |
| Z | 500 mm 2020 V-slot spine |
| Joint | [Gantry plate](/parts/compact-carriage.md), 4 wheels on the spine, 3 on the gantry |
| X | 500 mm 2020 V-slot gantry, sliding through the plate |
| Balance | 0.37 mm braid over the [pulley cap](/parts/spine-cap-pulley.md) to the [load stack](/parts/load-stack.md) |
| Payload | Phone on the [camera mount](/parts/camera-mount.md), Olight on a [steel strip](/parts/arm-strip-collar.md) |

# Design rules that held

* Balance, don't latch. See [balance not brake](/decisions/balance-not-brake.md).
* Design for stability, not stiffness. The mat's fiducials read scale out of every frame, so
  static droop is measured away; drift during an exposure is not. See the
  [design note](/references/design-note.md).
* Keep printed plastic in compression or shear, never in bending, wherever it carries the
  tipping moment. See [V base not weighted base](/decisions/v-base-not-weighted-base.md).

# Where the detail lives

The [design log](/references/design-log.md) is the record; this bundle summarises it.
