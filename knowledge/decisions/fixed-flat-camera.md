---
type: Design Decision
title: Camera fixed flat
description: "The phone looks straight down with no tilt or roll adjustment, so its alignment error is constant and measured once."
timestamp: "2026-09-12T00:00:00Z"
status: settled
tags: [camera]
---

An articulated head has an alignment error that changes every time it is touched. A fixed
head has a constant one, rectified by the mat's fiducials from then on, and keeps the rig a
pure translation stage. Any one-time levelling belongs at the base.

Consequence: the gantry-to-plate joint has to be square by construction.
