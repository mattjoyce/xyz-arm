---
type: Design Decision
title: "Balance, don't latch"
description: "The Z axis is held by matching the counterweight to the payload, not by a belt-and-latch brake that must be squeezed before every move."
timestamp: "2026-09-19T00:00:00Z"
status: settled
tags: [balance]
---

# Context

Payloads change: a light, a heavier phone, a ball head. Rolling V wheels have almost no
friction, so a few tens of grams of mismatch drift. A GT2 belt up the spine with a
spring-loaded toothed latch was drawn to hold any payload ([belt collar test](/parts/belt-collar-test.md)).

# Decision

Set the brake aside. Change the counterweight when the payload changes, a washer at a time on
the [load stack](/parts/load-stack.md).

# Why

* Engaged-by-default means every move starts with a squeeze by the hand that is also
  carrying the mismatch.
* 2 mm tooth steps let the arm settle a millimetre after release.
* The belt is the most visible thing on the spine.
* Whatever imbalance a friction can hold is exactly the extra force the hand pays to move
  the arm, so no friction both tolerates a big payload change and still floats.

# Citations

[1] [`notes/2026-09-19-balance-and-friction.md`](../../notes/2026-09-19-balance-and-friction.md)
[2] [`notes/2026-09-13-base-and-brake.md`](../../notes/2026-09-13-base-and-brake.md)
