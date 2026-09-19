# Bench camera captures

DeskCam stills taken while working out the XYZ Arm design. Each image keeps its
`.json` sidecar, which records the camera settings for that exact frame — zoom,
crop centre, focus, exposure, ISO, torch. `deskcam recall <file>.json` restores
those settings if a shot needs repeating under matched conditions.

## 2026-09-12-fishing-line

Identifying the counterweight line.

| File | What it is |
|---|---|
| `wide.jpg` | Spool on the calibration mat, 1× |
| `label-zoom.jpg` | 4× on the label, torch 20 |

Reads **HERCULES PE Braided Line, 50 LB, 0.37 mm, 8 plys, 100 M**. Superseded in
part: 50 lb is an optimistic rating, realistically nearer 15 kg. See `design.html`.

## 2026-09-12-turntable

Measuring the salvaged lazy-susan bearing for the rotating base.

| File | What it is |
|---|---|
| `bare-wide.jpg` | Bearing alone on the mat, 1× — outer edge clipped at the right frame edge |
| `with-ruler.jpg` | Steel rule laid across a near-diameter, torch 18 |
| `edge-left-zoom.jpg` | 4× where the outer edge meets the rule's zero end |
| `edge-right-zoom.jpg` | 4× where the outer edge meets the rule at 9–15 cm |

**Outer diameter 140 mm**, confirmed by hand. Read from the zoomed pair as
138–140 mm: outer edge at roughly −1 mm on the left and ~13.7 cm on the right.
The rule sits slightly below centre; chord error at that offset is under 1 %.

### Scale

**13.90 px/mm** at this camera height, from 21 ticks of the mat's own
`Y CHECK · 100 mm · 5 mm TICKS` ruler. Independent of any camera claim, and the
basis for every measurement above.

`deskcam scale` itself would not run here — it needs the analysis package
(`set DESKCAM_ANALYSIS to the directory that contains it`), so this was measured
off the printed ruler instead. Worth installing if this becomes routine.

### Discarded

Two overlay renders were deleted rather than kept. An automatic circle fit to the
bearing arc returned 113.7 mm, which turned out to be tracking the **inner bore**,
not the outer edge — caught by drawing the fitted circle back onto the photo. A
second attempt with a corrected search window produced a negative ring width and
was nonsense. Both numbers are wrong; the ruler reading above is the one to trust.

## 2026-09-13-first-print

First print of the base fit gauge, on an Ender-class Creality with eSun black
matte PLA. Kept because it is a worked example of getting usable images off a
black-on-black subject, which the earlier attempts failed at.

| File | What it is |
|---|---|
| `bed-wide-printing.jpg` | Part mid-print, phone torch. Blurred — the bed shuttles in Y while printing |
| `bed-wide-paused.jpg` | Same view, paused. Part flat on the bed, no lifted edges |
| `layer-torch-paused.jpg` | 4× on the surface, phone torch, paused. Usable but low contrast |
| `raking-wide.jpg` | Olight held at a grazing angle, phone torch **off** |
| `raking-apertures.jpg` | 6× on the three apertures under the same raking light |
| `raking-stacked.jpg` | Focus stack of `sweep-frames/`, sharp corner to corner |
| `sweep-frames/` | Seven-step focus sweep, 2.6 → 4.2 dioptres |

### What made the difference

**Raking light, not more light.** Under the phone's coaxial torch the focus hunt
reported a sharpness of 291 and the images were unusable. With the Olight held at
a grazing angle and the torch off, the same subject read **7537** — a 26× gain in
measured contrast from changing the lighting angle alone. Coaxial light shows
colour; matte black PLA has none. Only raking light shows the topography. This is
the same reasoning behind putting the Olight on the gantry rather than relying on
the phone torch, now demonstrated rather than argued.

**Pause the printer first.** The bed moves in Y during printing, so anything shot
mid-print is motion-blurred no matter how good the focus.

**Lock white balance with `awbgains=`, not `awb=`/`awblock=`.** A first sweep used
the latter and the frames drifted in colour between captures, which made the stack
either speckled or visibly patched depending on how the selection map was smoothed.
The tool warns about this explicitly in its sweep output. Those failed frames and
both bad stacks were discarded.

**Focus stacking needs contrast to work at all.** The per-pixel sharpness metric
picks noise on a low-contrast subject. The stack only succeeded once the raking
light was in place; the dioptre sweep itself was identical.

### Reading these images

Raking light is a topography amplifier — it casts long shadows from features that
may be tens of microns tall. The ripple visible in the solid top surface looks far
worse here than it is, and none of it bears on what the gauge measures: aperture
wall positions and bolt-hole centres, neither of which is a top surface.
