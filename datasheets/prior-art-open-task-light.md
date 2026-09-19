# Prior art — Open Task Light (stevenbennett/Open-Task-Light)

MIT licensed, ~1k stars, actively maintained. A CSYS-style counterbalanced task
light. Closest existing thing to the XYZ Arm mechanism, so worth mining rather
than re-deriving.

<https://github.com/stevenbennett/Open-Task-Light>

## It validates the architecture

BOM line: **`2020 V-Slot Rail - 500 mm` × 2** — the identical spine + arm choice,
independently arrived at. Rail ends are M5-tapped into the Ø4.20 centre bore,
which is what that bore is for.

## Where it differs from our design

| | Open Task Light | XYZ Arm Mk1 (current) |
|---|---|---|
| Balance member | GT2 belt, 2 mm pitch, 5 mm wide, 390 mm cut | 0.37 mm PE braid |
| Pulley | GT2 toothless idler, M5 bore, low-profile flange | plain pulley |
| Carriage wheels | 6, with 2 × M5 eccentric spacers | 4 |
| Counterweight | shot in a printed enclosure, 59 × 205 × 20 mm | undecided |
| Weight material | S550 steel shot, 1650 g (base + counterweight) | undecided |

## The counterweight answer

Measured from `counterweight-enclosure-steel_v1.0.step`: **59 × 205 × 20 mm**.
The 20 mm matches the rail width — it is a long slim slab riding alongside the
spine, not a compact slug. That is the packaging insight: make it long, not fat.

There are two enclosures of the *same envelope*, steel and lead, because shot
bulk density is far below solid:

| Fill | Bulk density | Mass in ~150 cm³ cavity |
|---|---|---|
| S550 steel shot | ~4.6 g/cm³ | ~690 g |
| Lead shot | ~6.8 g/cm³ | ~1020 g |

The XYZ Arm needs ~1.02 kg. **The steel variant will not reach it in that
envelope; the lead one lands almost exactly on it.** Either use lead shot, or
lengthen the enclosure. Cavity volume is estimated from the outer box and an
assumed 2 mm wall, so treat the masses as indicative.

Two `Counterweight Flex Tab Spring` items (6.350 × 4.369 mm music wire
compression springs) preload the enclosure's flex tabs against the rail — the
anti-rattle detail that keeps a hanging mass quiet.

## Carriage

`carriage-body_v1.1.step` measures **84.2 × 84.2 × 7.8 mm** — a shorter wheelbase
than our 150 mm. Not a contradiction: their payload is an LED head, so the
moment is nearer 1 N·m against our 2.4. Per-wheel force works out similar. It
cross-checks our spacing rather than overturning it.

## Legal note

The project README states the horizontal arm is **intentionally non-reversible**,
"a deliberate constraint related to the patent landscape surrounding this type of
mechanism", and that proposals to make it reversible will not be accepted.
Context worth knowing for anything built from this lineage; a one-off personal
build is a different matter from distributing a design.
