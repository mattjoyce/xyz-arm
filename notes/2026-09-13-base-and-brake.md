# 2026-09-13 session notes: Z brake idea, fit gauge, spine base

Notes from one working session. `design.html` hasn't been updated to match yet, and parts of it are now stale (see the end). The CAD details are in `cad/README.md`, iterations 15 and 16.

## Z brake: GT2 belt and toothed latch

The payload will change. A light, a different phone and a ball-socket mount all weigh different amounts, so one counterweight can't balance every setup. Matt proposed a GT2 belt up one channel of the spine, with a latch on the carriage.

Matt's spec:

- GT2 belt fixed up one spine channel.
- A spring-loaded toothed latch on the carriage, engaged by default, holding in both directions.
- Unlatch to raise or lower. Let go and it holds.
- One-handed, by a squeeze, a thumb press or a pinch.

What follows from that:

- **The releasing hand also carries the imbalance.** So the release belongs in a grip on the carriage. A squeeze works best, with the palm on a fixed handle and the fingers pulling a lever. A pinch is fine while the imbalance is small. A thumb press alone gives the hand nothing to hold against.
- **The counterweight only has to be roughly right.** Aim it at the middle setup. The hand then carries a few hundred grams at most.
- **A toothed shoe with 2 or 3 reversed GT2 teeth**, sliding in a guide square to the belt.
- **Cam-out sets the spring.** GT2 teeth are rounded, so load along the belt pushes the shoe out, maybe 0.4 × the load. At 5 N of imbalance a 5 N spring holds. Measure it on a print. A toggle or wedge lock that the load can't push back is the fallback.
- **Tip-on-tip engagement** lets the carriage slip up to 1 mm before the shoe seats. That's harmless before a capture.
- **Better than a friction lock.** A friction pad needs about 17 N of clamp to hold 5 N at μ 0.3, and that force goes into the wheel preload. The latch holds along the axis.
- **It catches the arm if the braid breaks.**
- **Heights step in 2 mm.** That's fine, since the fiducials give scale.
- **Placement.** All four spine slots are in use. The line runs in the front and rear slots, and the wheels ride the sides. The belt fits in a wheel slot's inner channel. The tooth tips sit about 5.3 mm from the rail centre and the wheel edge reaches 8.37 mm, so the clearance is about 3 mm. The shoe reaches through the slot mouth, between the two wheels on one side.
- **Alternative: a locked pulley.** A GT2 pulley on the carriage, wrapped by the belt over two idlers, locked by a spring pin in an index wheel. It can't cam out or land tip-on-tip, and a motor could later drive the same pulley. The cost is that the belt leaves the channel.

Superseded along the way: a one-way gravity pawl that clicked up when you lifted and needed the counterweight set light. Matt wants it holding both ways, released by hand.

Tracked as kanban card `ukrp` (`~/kanban/xyz-arm/cards/z-belt-pawl-brake.md`).

## Fit gauge results

The Ø145 gauge (`base-fit-test.scad`) printed cleanly. Tally holes 1, 2 and 3 map to 0.15, 0.30 and 0.45 mm per side.

- 3 holes (0.45) went on easily. 2 holes (0.30) was hard but possible, at only 2 mm of depth.
- **Socket fit chosen as 0.375 mm per side**, halfway between them. The real socket is 45 mm deep, so 0.30 would bind. The tee bolts locate the rail, so the socket only has to guide it.

## Turntable bearing

It isn't a precision part. An M4 passes through some of the holes and has to tap its way into others. They're sized for wood screws and loosely placed.

- **The screws clamp and don't locate.** The float lives in the bearing's loose holes. Nothing sets concentricity, so the base may sit up to about 1 mm off centre. That's harmless, because the fiducials solve pose on every frame.
- **Base to inner race.** M4 self-tapping screws go up from below, through the inner ring, into Ø3.5 pilots in the base. The load is about 21 N per screw. If the screws drive too tight, open the pilots to 3.6. If they're loose, drop to 3.3.
- **Outer race to whatever is under it.** It might be the desk, or it might be a wooden board clamped to the desk. I'd go with the board, overhanging the desk edge, so the counterweight line drops through the board and past the desk with no hole in the desk. The board lifts the arm by its own thickness. With the mat on the desk, the lowest camera position rises from about 117 to 135 mm, still inside the 100 to 300 mm working range.
- **Assembly order.** Screw the base to the inner ring first, while you can still reach underneath. Then screw the outer ring down.
- **Unverified.** The 102 mm inner hole circle and the 114 mm race boundary are still photo estimates. Check both against the gauge or calipers before the long print.

## Rail hold-down

- **Four M5 × 8 socket heads into M5 drop-in T-nuts**, two in each side slot.
- **Stack under the head.** 2.8 mm of plastic, 0.375 gap, 1.8 lip, which leaves 3.0 mm into the nut. An M5 × 10 would bottom in the 4.3 mm channel, and an M5 × 6 wouldn't grip. Asserts in `z-base.scad` now check this.
- **I got this wrong once.** I first quoted 2.8 mm under the head while the model actually had 3.8. That would have left only 2 mm of thread in the nut. The counterbore was deepened by 1 mm to match, and both STLs were re-exported.
- Put the T-nuts in the slots before seating the rail.
- Tighten one side hard with a square against the rail, then just snug the other side. Tightening both sides hard pulls in opposite directions and bends a plastic wall.
- Hammer-head T-bolts won't work here. The socket walls leave them no room to twist.

## Base shape, how it evolved

1. Eight ribs, which Matt didn't like.
2. A plain cone from the plate to the boss flats. Its corners scalloped down the slope.
3. A truncated cone, Ø48 flat top at 20 mm.
4. A truncated cone up to the socket mouth, with the top at the boss diagonal + 5 mm (Ø49.1). This buries the square boss, and both tee bolt pairs are reached through Ø9.5 bores in the flank.
5. The plate cut back so it doesn't cover the outer race. That saves print time, removes the access holes and the underside relief, and leaves the desk screws in the open. The race boundary is taken as 113 to be safe, so the plate is Ø111 with 2.75 mm of plastic outside each pilot.
6. Edges broken. The plate and cone became one revolved profile. The rims have 1.0 mm chamfers on top and 0.5 mm underneath. The cone foot has a 4 mm fillet and the top edge a 2 mm round. The socket mouth and pilot holes got lead-in chamfers. The tee bores stay sharp.

This is `variant = "full"`, exported to `cad/parts/z-base.stl`. It's 204 cm³, about 4 h even at 10% infill. Matt plans 20% infill. For that, use 4 perimeters and 5 top and 5 bottom layers, since the walls do the work.

## Fast variant

`variant = "fast"`, exported to `cad/parts/z-base-fast.stl`. It's 70 cm³, about a third of the full one. The slicer will give the real print time, which won't drop by the full two thirds.

- A Ø70 hub with four 12 mm arms out to screw lugs on the same Ø111 rim.
- The square socket stands open on a 12 mm flared, filleted foot.
- The tee bolts move up to 20 and 38 mm to clear the foot. Still M5 × 8.
- Its weak spot is the arms. They bend at about 6 MPa where they meet the hub. That's fine for strength, but they'll flex more than the full plate.

## Still open

- Confirm the 102 mm circle lands on the inner race holes, and caliper the race boundary.
- Print one of the two bases and try an M4 self-tapper in a pilot.
- Desk screws or a clamped board. If it's a board, model it overhanging the desk edge in the assembly.
- `design.html` is behind in these places:
  - the counterweight balance rule (now "roughly right, aimed at the middle setup")
  - the Z lock (now the spring-loaded toothed latch)
  - the base shape and fixings
  - the wheel spacing (the carriage uses 60 mm, the note still says 150)
