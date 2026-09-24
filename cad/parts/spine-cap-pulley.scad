// Spine cap, pulley version: a closed 20 x 20 hood over the top of the
// vertical 2020 with a small pulley inside it. Replaces spine-cap.scad's V
// groove, which Matt found too stiff on the rig (2026-09-20): a groove is a
// 180 degree capstan, 4 to 6 N at 10 N hanging. The pulley is one from his
// parts box: 12 OD, 10.3 at the line, 4 wide, a ball bearing on a 3 mm bore.
//
// One pulley is enough because of where the rail's slots are. With the
// 0.37 braid on, the two runs leave the pulley 10.7 apart, and the front and
// rear slot channels are 4.3 deep each side of a 7.8 core. Centred on the
// rail's axis, axle across X, the pulley drops both runs into the channels,
// 4.65 under each face. The rear run goes straight down the channel through
// the load stack's slit sliders (load-stack.scad; the slits run the sliders'
// full depth, so 5.35 from centre suits them as well as 8 did). The front run
// angles out through the slot's opening to the gantry plate's tie hole, 6 mm
// in front of the face: at x = 0 the rail has no metal outboard of the
// channel floor, so the line touches nothing, and the angle is in the
// pulley's plane. A slit up the hood's front wall lets it through as the
// carriage nears the top and the angle opens.
//
// The rail's core is solid under the pulley, so the pulley sits above the
// rail's end and the hood is as tall as that makes it. The line's load, about
// twice what hangs, presses the hood onto the rail; the tee tabs in the side
// slots (spine-cap.scad's, unchanged) only have to keep it there when slack.
//
// Axle: an M3 x 16 cap head across X, head sunk in one side, self-tapping
// into a pilot in the other. The bearing sits on the thread, which is fine:
// nothing turns on it. Two low bosses on the pocket's walls bear on the
// bearing's inner race and keep the pulley's flanges off the walls. The
// pocket is too narrow beside the pulley for the braid to drop past it.
//
// Assembly: lay the line over the pulley, push the pulley up into the
// pocket, run the screw through, press the hood onto the rail.
//
// Open for now (open_top, Matt 2026-09-20): no roof, so the pulley can be
// watched and got at, and the pulley raised onto a flat floor across the
// rail's end, so the cap has a clean base. The pocket is then a trough open
// upward, and the slit is cut at both ends, full height and through the
// floor to run_y, so the line is laid in from above with the cap on the rail:
// pulley out, line down both slits, pulley and screw back. open_top = false
// gives the closed hood back: roof, no floor, the pocket open to the rail and
// the one slit at the front.
//
// Two parts (part = plate | block | pair, Matt 2026-09-20): the one-piece
// open cap was tricky to print, tabs on one end and a trough on the other, so
// neither end is a good bed face. Split at the rail's end, each half gets one.
// The PLATE is the rail interface, split_t thick with the tee tabs under it,
// printed upside down with its flat top on the bed. The BLOCK is the pulley's
// trough and cheeks on a flat base, printed as it stands. One M2 down the
// middle joins them: head sunk in the trough's floor under the pulley, thread
// cut into a pilot in the plate, tip free in the rail's Ø4.2 bore. The line's
// load clamps the joint anyway; the screw only locates it. One screw leaves
// yaw to friction, so both faces also carry two blind Ø2 holes for stubs of
// 1.75 filament as dowels. Both faces are bed faces, so holes are all the
// registration they can have. Both parts carry the two slits.
//
// part = "cap" is the one piece, open or closed by open_top. It prints upside
// down (print_flip): rims or roof on the bed, tabs standing, and when open
// the floor bridging the pocket's 4.6.
use <spine-cap.scad>
rail        = 20;
pulley_od   = 12;
pulley_line = 10.3;    // diameter at the groove's root
pulley_w    = 4;
axle        = 3;
line_d      = 0.37;
part        = "pair";  // [pair, plate, block, cap]
open_top    = true;    // cap only: no roof, flat floor, slits both ends
floor_t     = 2;       // open cap: floor across the rail's end
split_t     = 3;       // two part: the plate, on the rail's end
block_floor = 3.2;     // two part: the block's floor, which sinks the M2's head
m2_clear    = 2.3;
m2_pilot    = 1.6;     // self-tapping into the plate
m2_head_d   = 4.2;     // cap head 3.8; must pass down the pocket
m2_head_h   = 2.2;     // cap head 2.0
m2_len      = 8;
dowel_d     = 2.0;     // 1.75 filament
dowel_h     = 2.5;     // into each face
dowel_x     = 6.5;     // either side of centre, under the cheeks
rim_over    = 0.5;     // open only: walls this far above the pulley's rim
lift        = 0.8;     // pulley's rim above the floor, or the rail's end
rim_clr     = 0.75;    // pocket round the pulley's rim
side_clr    = 0.3;     // pocket beside the pulley, a side: less than the braid
boss_h      = 0.15;    // bosses on the pocket walls, onto the inner race
boss_d      = 5;       // the inner race; keep under the bearing's outer ring
roof        = 1.6;
edge_c      = 1.5;     // chamfer on all four top edges
axle_clear  = 3.3;     // head side
axle_pilot  = 2.7;     // M3 self-tapping into the far wall
head_d      = 6;       // cap head 5.5
head_sink   = 3.2;
screw_l     = 16;
front_slit  = 2;       // slit width: front wall only when closed, both ends when open
print_flip  = false;   // plate and cap only: top face down, tabs up
show_context = false;  // rail stub, pulley and the two runs; preview only
$fn = 48;

half     = rail/2;
two_part = part != "cap";
open     = open_top || two_part;
base     = two_part ? block_floor : open_top ? floor_t : 0;
pz       = base + lift + pulley_od/2;          // axle height above the rail's end
pocket_w = pulley_w + 2*side_clr;
pocket_d = pulley_od + 2*rim_clr;
cap_h    = open ? pz + pulley_od/2 + rim_over : pz + pocket_d/2 + roof;
run_y    = (pulley_line + line_d)/2;           // each run, from the rail's centre
wall     = (rail - pocket_w)/2;
screw_end = -half + head_sink + screw_l;       // x of the screw's tip

// 2020 channel: 3.9 to 8.2 from centre at x = 0 (datasheets/section-properties.md).
assert(run_y > 3.9 + 0.5 && run_y < 8.2 - 0.5, "runs miss the slot channels");
assert(side_clr - boss_h < line_d, "the braid can drop past the pulley");
assert(screw_end < half && screw_end > pocket_w/2 + 4, "screw length does not suit the walls");
assert(edge_c < wall - head_d/2 || pz + head_d/2 < cap_h - edge_c, "head counterbore breaks the chamfer");
assert(!two_part || m2_head_d < pocket_w, "the M2's head will not pass down the pocket");
assert(!two_part || block_floor - m2_head_h >= 1, "too little floor under the M2's head");
assert(!two_part || m2_len > block_floor - m2_head_h + split_t, "M2 too short to come through the plate");
assert(!two_part || dowel_h < split_t, "dowel holes through the plate");
if(two_part) echo(str("plate ", split_t, " + block ", cap_h, " = ", split_t + cap_h, " above the rail's end; M2 x ", m2_len,
         " has ", block_floor - m2_head_h, " under its head, ", split_t, " of thread, ",
         m2_len - (block_floor - m2_head_h) - split_t, " spare in the rail's bore"));
echo(str(two_part ? "block " : open ? "open cap " : "hood ", cap_h, " high; axle ", pz, " above the rail's end; runs ", run_y, " from centre, ",
         half - run_y, " under each face; pocket ", pocket_w, " x ", pocket_d, "; M3 x ", screw_l,
         " reaches ", screw_end - pocket_w/2, " into the far wall"));

module body() {
    hull() {
        translate([0, 0, (cap_h - edge_c)/2]) cube([rail, rail, cap_h - edge_c], center=true);
        translate([0, 0, cap_h - 0.005]) cube([rail - 2*edge_c, rail - 2*edge_c, 0.01], center=true);
    }
}
// Closed, a tombstone: round the pulley above the axle, straight down to the
// rail. Open, a trough from the floor up through the top.
module pocket() {
    difference() {
        if(open) translate([-pocket_w/2, -pocket_d/2, base]) cube([pocket_w, pocket_d, cap_h]);
        else union() {
            translate([0, 0, pz]) rotate([0,90,0]) cylinder(h=pocket_w, d=pocket_d, center=true);
            translate([0, 0, (pz - 1)/2]) cube([pocket_w, pocket_d, pz + 1], center=true);
        }
        for(s=[-1, 1]) translate([s*pocket_w/2, 0, pz]) rotate([0, -s*90, 0])
            cylinder(h=boss_h, d1=boss_d + 2*boss_h, d2=boss_d);
    }
}
module axle_hole() {
    translate([0, 0, pz]) rotate([0,90,0]) {
        translate([0,0,-half - 1]) cylinder(h=half + 1, d=axle_clear, $fn=24);
        cylinder(h=half + 1, d=axle_pilot, $fn=24);
        translate([0,0,-half - 1]) cylinder(h=head_sink + 1, d=head_d, $fn=32);
    }
}
// Closed: from the pocket out through the front face, rail's end up to the
// axle. Open: both ends, full height, and through the floor in to the runs.
module slit() {
    if(open) for(s=[-1, 1]) scale([1, s, 1])
        translate([-front_slit/2, run_y - front_slit/2, -1]) cube([front_slit, half + 1 - run_y + front_slit/2, cap_h + 2]);
    else translate([-front_slit/2, -half - 1, -1]) cube([front_slit, half + 1 - pocket_d/2 + 1, pz + 1]);
}
module spine_cap_pulley() {
    difference() {
        union() { body(); tabs(); }
        pocket();
        axle_hole();
        slit();
    }
}

// Two part. The joint is z = 0 for both: the block stands on it, the plate
// hangs under it.
module dowels(down) {
    for(s=[-1, 1]) translate([s*dowel_x, 0, down ? -dowel_h : -0.01]) cylinder(h=dowel_h + 0.01, d=dowel_d, $fn=24);
}
module block() {
    difference() {
        body();
        pocket();
        axle_hole();
        slit();
        translate([0,0,-1]) cylinder(h=base + 2, d=m2_clear, $fn=24);
        translate([0,0,base - m2_head_h]) cylinder(h=m2_head_h + 1, d=m2_head_d, $fn=32);
        dowels(false);
    }
}
module plate() {
    difference() {
        union() {
            translate([0,0,-split_t/2]) cube([rail, rail, split_t], center=true);
            translate([0,0,-split_t]) tabs();
        }
        translate([0,0,-split_t]) slit();
        translate([0,0,-split_t - 1]) cylinder(h=split_t + 2, d=m2_pilot, $fn=24);
        dowels(true);
    }
}
top = two_part ? split_t : 0;   // where the block or cap starts, above the rail's end
if(part == "cap")   { if(print_flip) translate([0,0,cap_h]) rotate([180,0,0]) spine_cap_pulley(); else spine_cap_pulley(); }
if(part == "block") block();
if(part == "plate") { if(print_flip) rotate([180,0,0]) plate(); else translate([0,0,split_t]) plate(); }
if(part == "pair")  { translate([0,0,split_t]) plate(); translate([0,0,split_t + (show_context ? 0 : 8)]) block(); }

if(show_context && !print_flip) %translate([0,0,0]) union() {
    color([0.66,0.71,0.75]) translate([0,0,-60]) linear_extrude(60) difference() {
        square(rail, center=true);
        for(a=[0:90:270]) rotate(a) {
            translate([-3, half - 1.8]) square([6, 3]);
            translate([-5.5, half - 5.5]) square([11, 3.7]);
        }
    }
    color([0.8,0.8,0.8]) translate([0,0,top + pz]) rotate([0,90,0]) difference() {
        cylinder(h=pulley_w, d=pulley_od, center=true);
        cylinder(h=pulley_w + 1, d=axle, center=true);
    }
    color([0.1,0.7,0.9]) for(y=[-run_y, run_y]) translate([0, y, -60]) cylinder(h=60 + top + pz, d=0.6, $fn=8);
}
