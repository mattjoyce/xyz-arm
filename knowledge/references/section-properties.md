---
type: Analysis
title: 2020 V-slot section properties
description: "Area, second moment and mass per metre of the 2020 V-slot, integrated from the OpenBuilds DXF."
timestamp: "2026-09-12T00:00:00Z"
resource: datasheets/section-properties.md
tags: [rail, analysis]
---

| Quantity | Value |
|---|---|
| Area | 171.41 mm² |
| Ix = Iy | 0.699 cm⁴ |
| Mass | 463 g/m |
| EI (6063-T5) | 4.82 × 10⁸ N·mm² |

Reproducing needs the OpenBuilds DXF, which is not in the repository
(see [the drawing](/references/openbuilds-vslot-20x20.md)). Then run `python3 datasheets/section_properties.py datasheets/openbuilds-vslot-20x20.dxf`.
See [`datasheets/section-properties.md`](../../datasheets/section-properties.md).
