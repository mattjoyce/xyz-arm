---
type: Test Print
title: Base fit test
description: A 2 mm gauge plate testing three 2020 socket clearances and both candidate bearing bolt circles in one short print.
timestamp: "2026-09-13T00:00:00Z"
status: "printed, answered"
resource: cad/parts/base-fit-test.scad
tags: [test]
---

Apertures at 0.15 / 0.30 / 0.45 mm per side, marked with tally holes that also key
orientation. 0.45 slid on easily, 0.30 went on hard, so the [Z base](/parts/z-base.md) took
0.375 (iteration 14, iteration 15).

Cutout clearances are checked numerically by `cad/studies/check-cutouts.py`, because an edge
between two vertices passed within 5.3 mm of a bolt hole that the vertices cleared by 12.7.

# Files

* [`base-fit-test.scad`](../../cad/parts/base-fit-test.scad)
* [`base-fit-test.stl`](../../cad/parts/base-fit-test.stl)
