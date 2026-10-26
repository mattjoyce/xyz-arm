---
type: Design Decision
title: Four wheels on the spine
description: "The gantry plate runs four wheels on the spine, two fixed and two eccentric, because three could not hold the arm's moment."
timestamp: "2026-09-23T00:00:00Z"
status: "settled, awaiting print"
tags: [carriage, wheels]
---

# Failure

With three spine wheels, the arm's moment about the spine was held only by the centre
eccentric's preload. Pulling down on the arm made the top wheel pull sideways nearly off
the rail, and the middle bolt skewed in 3 mm of counterbored plate.

# Decision

Two fixed wheels at x = -20.32, y = ±30 and two eccentrics opposite. The moment goes into the
rail as a diagonal couple over the 60 mm pitch, about 6.7 N a wheel per newton at 400 mm.
The bought metal plate hybrid ([gantry carriage](/parts/gantry-carriage.md)) was the fallback.

# Open risk

The eccentric seats are unchanged from the one that skewed. If the new eccentrics skew,
that is the next fix.

Wheel spacing stays at 60 mm by choice, accepting about 40 N a pair at 2.4 N·m rather than
16 N at 150 mm.
