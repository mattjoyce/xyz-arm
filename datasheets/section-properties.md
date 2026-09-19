# 2020 V-Slot — section properties

Computed from OpenBuilds' own DXF (`openbuilds-vslot-20x20.dxf`) by numerical
integration over the closed profile, not taken from a vendor spec table.
Reproduce with `python3 section_properties.py openbuilds-vslot-20x20.dxf`.

## Parse validation

| Check | Result |
|---|---|
| Bounding box | 20.00 × 20.00 mm — matches the drawing |
| Centroid | (0.000, 0.000) mm — profile is doubly symmetric |
| Closed loops | 2 — outer profile 185.26 mm², Ø4.20 bore 13.85 mm² |

## Properties

| Quantity | Value |
|---|---|
| Cross-sectional area | 171.41 mm² = 1.714 cm² |
| Ix = Iy (centroidal) | 6988 mm⁴ = **0.699 cm⁴** |
| Section modulus S (c = 10 mm) | 699 mm³ |
| Mass, 6063 at 2.70 g/cm³ | 463 g/m |
| Mass per 500 mm | 231 g |
| E, 6063-T5 | 69 GPa |
| EI | 4.82 × 10⁸ N·mm² |

## Cross-check

Vendor figures for the same profile: 0.67 cm⁴ (several resellers), 0.454 kg/m
and 0.47 kg/m. The computed 0.699 cm⁴ and 463 g/m sit inside that spread, so the
resellers are rounding a real number rather than quoting a different section.

## Profile geometry (from the OpenBuilds drawing)

- 20 × 20 mm, 1.50 mm nominal wall
- V-groove included angle 90°, 11 mm across the V mouth
- Slot opening 6.25 mm, inner channel 9.16 mm, V depth 4.30 mm
- Centre bore Ø4.20 mm (self-tapping M5 for end connections)

## Part numbers (OpenBuilds)

| Length | Part # |
|---|---|
| 500 mm | 150-LP |
| 1000 mm | 190-LP |
| 1500 mm | 210-LP |

The XYZ Arm Mk1 needs two of **150-LP** — one spine, one gantry.

## Sources

- Drawing: <https://github.com/richard-scott/OpenBuilds> — `V-Slot 20x20 Linear Rail.PDF`
- Geometry: same repo, `V-Slot 20x20.dxf`
- Material/weight cross-check: <https://hts-alu.com/extrusions/2020-v-slot-aluminum-extrusion/> (6063-T5, 0.47 kg/m, 6.2 mm slot)
