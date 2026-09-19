# 2026-09-19 session notes: the Z brake becomes a balance problem

Matt's aim, stated plainly this session: the best experience. Well balanced, one
handed, fluid, everything on the desk. Anything that has to be squeezed or
released before the arm will move is a tax on every use, and a fiddly arm is an
arm that gets used less. That reframed the Z brake.

## What the brake was for

Payload changes only. A balanced arm stays where it is left. The belt-and-latch
brake (kanban `ukrp`) existed because a light, a heavier phone or a ball head
each shift the balance, and rolling V-wheels have so little friction that a few
tens of grams of mismatch will drift.

## What it costs

Engaged by default means every move starts with a squeeze, by the hand that is
also carrying the mismatch. Tooth steps of 2 mm mean the arm can settle a
millimetre after it is let go. A belt up the spine is also the most visible
thing on it, and Matt does not want to see it.

## Direction now

1. **Add weight, don't latch.** The counterweight is a stack of blocks on a
   plate at the end of the line. Swap payload, add or remove a block. Blocks
   are hollow, filled with steel shot on the kitchen scale to the payload they
   balance, and labelled.
2. **Blocks register by shape, not magnets.** A truncated square cone on top
   of each piece and a matching recess underneath. Matt's two plan sketches
   set the rest: the stack hangs directly behind the spine; the load line
   drops into the rear slot; two guide threads hang from the cap's rear
   corners just outside the rail. Only the two end plates touch a thread,
   because the load line hangs inside the slot and the guide threads pass in
   front of the blocks. The end plate has a lip into the slot with the line
   hole, and one split from the lip's tip back along the centre and out in a
   T to the two guide holes, so all three threads go in with one push. Blocks are closed boxes
   with a fill hole, no holes and no captures. Add one by lifting the keeper
   up the threads.
3. **Everything on the desk.** The line goes over the top of the spine and the
   stack hangs down the back. No hole in the desk, no pot below it. The stack
   travels the same 310 mm as the carriage, so it lives between about 90 and
   480 mm above the desk, behind the spine.
4. **A little friction, tunable, on the counterweight side.** The two guide
   threads the stack rides are the place for it: they stop the stack swinging
   and never touch the working line or the wheels. How the drag is set, a pad
   or the threads' own tension, is not yet drawn. Set it to a little more than
   the mismatch between blocks, perhaps a newton, and it holds anything
   smaller in both directions while staying fluid to the hand.
5. **Spares park on a ring on the desk around the turntable bearing**, with
   steel washers set in it and a magnet in each block if they need holding.
   Not yet drawn. The spine has no free face for them: the carriage sweeps
   the front and the stack sweeps the back.

The rule that made this hang together: **whatever imbalance a friction can
hold is exactly the extra force the hand pays to move the arm.** There is no
friction that tolerates a 300 g payload change and still floats. So the
blocks do the real work and the friction only swallows the noise.

## Parked, with reasons

- **Belt and toothed latch.** The default-engaged squeeze and the visible
  belt. The belt anchor collars (`cad/parts/belt-collar-test.scad`) were
  printed today anyway, as a cheap test of an M5 tip clamping rubber into a
  slot channel. Worth a pull test and a line in these notes when done.
- **Gravity tilt lock on a smooth rod.** Holds without creep and puts no side
  load on the wheels, but one way only, so the counterweight would have to be
  biased light and lowering would need a release.
- **A grip on the line in the base.** Same one-way problem: a clamped line
  stops the carriage going down, and does nothing against it going up because
  the line above the grip goes slack. Also the 0.37 mm braid is too slippery
  to grip; the fix would have been a thicker cord below the pulley zone. Not
  needed now.
- **A winding round a post at the top for friction.** Works, but a capstan
  costs more to lower than to raise, the gap grows with wrap, and the drag
  scales with the hanging weight. The guide-cord slider is better on all
  three counts. The v1 cap's groove is itself a 180° capstan (below).

## Parts drawn today

- `cad/parts/spine-cap.scad`: a minimal square 20 × 20 × 5 cap pressed into
  the rail's top with tee tabs in the side slots and a peg in the bore, and a
  45° V groove front to back that follows a 45° chamfer down each face.
  Printed upside down, no support. Both runs drop into the slot mouths at
  x = 0. (Two earlier cuts, a 32 mm collar with a rear ear and a rounded
  20 × 20 crown, were dropped as too big or awkward to print.) **v1 friction
  warning:** a groove is a capstan, and the line wraps 180° over it. At 10 N
  hanging and μ about 0.15 on smooth PLA, that is roughly 3.8 N to raise and
  6 N to lower. If that is too much in the hand, a small pulley replaces it.
- `cad/parts/load-stack.scad`: a master load, add-on cells and a keeper, in
  a 40 × 60 section, every one an open box closed by the piece above, which
  registers with a chamfered foot into the cavity below. Master and keeper
  carry the lip and the single T split. The line's end loop is clamped under an M2 beneath the master, which is
  also the length adjuster. The master is now a 1.2 mm sleeve round one or
  two of Matt's lead-in-resin blocks, 25 × 60 × 85; which depends on what a
  block weighs against the arm's 1.05 kg. Cells 24 or 47 cm³ to match. **Height budget:** the stack mirrors 310 mm of
  travel between cap and base, so everything must fit in about 130 mm; the
  block sleeve with two cells is 128.

## Still open

- **The guide threads' bottom anchors.** The top ones are on the cap, each
  cord pinched by an M2 from behind. At the base they need two fixed points
  6.5 mm either side of the rear slot, 14 mm behind the rail centre, and a
  way to tension them: a hole in the base's
  plate or a small clip in the side slots. Not drawn.
- **How much the stack leans.** Its mass centre is 30 mm behind the line, so
  it tilts until the guide threads and the lip in the slot take the couple.
  How much drag that makes, and whether it needs a pad, is for the first
  hang to show.
- The parking ring.
- Whether the capstan friction of the grooved cap is acceptable, or a pulley
  goes in. Decide by hand once the spine is up.
- The carriage's lug for the front run now wants to sit under the cap's front
  exit, 14.7 mm in front of the spine's centre. It is drawn at about 12.
- The design note's counterweight section (pot below the desk) is now stale
  on top of the four places already listed in `HANDOFF.md`.
