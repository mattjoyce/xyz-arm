---
type: Design Decision
title: Braided line as the balance member
description: "0.37 mm PE braid carries the counterweight, chosen over a GT2 belt for pulley size and routing, accepting creep."
timestamp: "2026-09-12T00:00:00Z"
status: settled
tags: [balance]
---

Braid and belt differ by about 2 g in a 1078 g budget, so mass was never the argument. Braid
allows a pulley an order of magnitude smaller, routes inside the rail's slots, needs no
printed clip and is silent.

Creep costs travel, not balance: tension is set by the hanging mass. The line's working load
is about 10 N, roughly 7 % of a realistic 15 kg break. Tie off with a capstan wrap before the
knot, since knots in braid lose 20 to 30 %.

[Open Task Light](/references/open-task-light.md) uses a GT2 belt for the same job.
