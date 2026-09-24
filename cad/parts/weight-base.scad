// Weighted base: a 1.25 kg dumbbell plate as the arm's foot, clamped between
// two printed discs (Matt, 2026-09-20). The UNDER disc is Ø200 x 2 on the
// desk with a Ø28 hub standing in its middle; the iron drops over the hub.
// The OVER disc lies on the iron and one M4 down the centre into the hub
// clamps the three together. The turntable bearing's outer race is then
// screwed to the over disc with M4s. This replaces desk screws and the
// clamped board: nothing is fixed to the desk.
//
// The iron, as Matt measured it: about 150 OD, 28 bore, 15 thick at a rim
// about 10 wide and a hub about 60 across, with the web between them
// recessed 4.5 on both faces, so 6 thick. Only the rim and the hub are
// bearing surfaces. OD and bore are nominal; measure before printing.
//
// Why it is worth doing: what resists tipping is total weight times the
// footprint's radius, against about 2.1 N.m from the arm at full reach. The
// bearing alone on the mat gives about 1.8 N.m and tips. With the iron and
// a footprint that really is 100 mm, it is about 3.8.
//
// Two things here are more than the flat discs that were asked for, each
// with a switch to take it off:
//
//  wall and ribs (under). A flat 2 mm disc is not a 100 mm footprint. As the
//    arm tips, the iron pivots on its own front edge at 75 and the 25 mm of
//    disc in front of that just bends: about 27 N/mm, so it takes 2 degrees
//    of lean before it carries anything much. A low wall round the iron and
//    gussets from it out to the edge make the overhang stiff, and the wall
//    keeps the iron from creeping. ribs = 0 gives the plain disc.
//
//  seat (over). The bearing's outer holes are at about r 64 (photo estimate)
//    and the iron's rim starts at about r 65, so an M4 coming through a flat
//    2 mm disc lands on iron: no room for the screw's tip, let alone a nut.
//    A raised ring under the outer race, seat_h tall, gives the screws
//    plastic to tap into without coming out underneath, and it stiffens a
//    disc that the race's rear screws otherwise lift like a lid. It also
//    stops short of the race boundary, so the inner race, which turns, hangs
//    over air; on a flat disc it would rub unless it is relieved. seat_h = 0
//    gives the flat disc with clearance holes, for nuts in the recess, if
//    the measured hole circle turns out to clear the rim.
//
// Wheel (under_style = "wheel", Matt 2026-09-20): the Ø200 disc was going to
// take a long time to print and it is not there for weight, so it is a wheel:
// one hub, one outer ring, four spokes, all disc_t thick and flat on the desk.
// A first cut had posts beside the iron with jack screws and tall gussets;
// Matt: no ribs, or eight at most, 4 mm and subtle. So each spoke carries two
// low ribs along its edges, rib_h tall, eight in all. They live in the
// iron's recess over the web, which is 4.5 deep, and stop short of the hub
// and the rim, where the iron sits on the flange. So with the iron on, none
// of them shows: what is seen is a ring and four flat spokes. rib_outer adds
// a short fading pair outside the iron on each spoke; they do little.
//
// What that accepts: the spoke is a bare 2 mm strip where it passes under the
// iron's rim, and that strip is a hinge. A 0.5 N.m push leans the arm several
// degrees before the ring answers, so the footprint that counts is the
// iron's own 75 mm and the ring is a catch, not a foot. 75 mm is 1.35x at
// full reach now and about 2x once the printed cradle replaces the clamp.
// rib_seat = true is the way back if it proves lively: the ribs run unbroken
// from hub to ring and the iron sits on them, rib_h higher, which takes the
// hinge out at the cost of that height.
//
// The over part is a wheel too (over_style = "wheel", Matt 2026-09-20): a
// disc over the iron's hub for the centre M4, a flat ring lying on the
// iron's rim, and four spokes between them, each running out to one of the
// race's screws. The seat is cut down to pads, eight of them, every other
// one at a screw, all standing on the ring. They are clipped to the outer
// race only, starting seat_in outside the race boundary, so nothing stands
// under the inner race, which turns. "disc" keeps the full disc and the full seat ring.
//
// Both print flat as drawn, no support.
part        = "pair";   // [pair, under, over]

/* [The iron] */
weight_od   = 150;
weight_bore = 28;
weight_t    = 15;       // at the rim and the hub
rim_w       = 10;       // flat rim, full thickness
recess      = 4.5;      // web below the rim, each face

/* [Under] */
under_style = "wheel";  // [wheel, disc]
under_d     = 200;      // both: outside diameter
ring_w      = 12;       // wheel: the outer ring
spoke_n     = 4;
spoke_w     = 12;
hub_disc_d  = 55;       // wheel: disc under the iron's hub
rib_h       = 0;        // wheel: two low ribs a spoke, 4 max; 0 for none (the test print, Matt 2026-09-20)
rib_t       = 2;
rib_outer   = false;    // a second, fading pair outside the iron
rib_end     = 1;        // outer rib's height where it meets the ring
rib_gap     = 2;        // ribs stop this far from the iron's hub, rim and OD
rib_seat    = false;    // ribs unbroken and the iron sits on them
disc_t      = 2;        // both discs
hub_fit     = 0.25;     // a side, hub in the bore
hub_short   = 0.5;      // hub stops this far under the iron's top, so the M4 clamps iron, not hub
od_clr      = 1.5;      // a side, wall round the iron: castings are not round
wall_t      = 2;
wall_h      = 8;        // above the disc
ribs        = 12;       // disc: gussets, wall to edge; 0 for the plain disc
edge_c      = 0.6;      // chamfer on the under disc's bed edge, for elephant's foot

/* [Centre M4] */
m4_pilot    = 3.5;      // self-tapping down the hub
m4_clear    = 4.4;      // through the over disc
nut_trap    = true;     // hex pocket under the hub, in case the plastic thread strips
nut_af      = 7.2;      // M4 nut 7.0 across flats
nut_h       = 3.4;

/* [Over and bearing] */
over_style  = "wheel";  // [wheel, disc]
over_ring_w = 18;       // wheel: flat ring on the iron's rim, in from over_d
over_hub_d  = 55;       // wheel: disc over the iron's hub
over_spoke_w = 12;
pad_d       = 18;       // wheel: seat pad round each screw, clipped to the race
over_d      = 150;
bearing_od  = 140;      // measured by hand
race_inner  = 113;      // race boundary, photo estimate
outer_pcd   = 128;      // outer race's hole circle: photo estimate, then proved on the 2026-09-13
                        // fit gauge, whose rim carried this circle (Matt: the outer holes were fine)
outer_n     = 4;
seat_h      = 4;        // raised seat under the outer race; 0 for flat and nuts below. It is also
                        // the room under the turning inner race for the heads of the base's
                        // bolts: an M4 cap head is 4, a pan head 3.1
seat_margin = 1;        // seat past the race's OD by this
seat_in     = 2.5;      // and this far outside the race boundary, which is a photo estimate:
                        // nothing may stand under the inner race, which turns
pads        = 8;        // wheel: seat pads, every other one at a screw
race_pilot  = 3.5;      // M4 self-tapping into seat and disc
race_clear  = 4.4;      // seat_h = 0: clearance, nut in the recess

$fn = 96;
hub_d    = weight_bore - 2*hub_fit;
hub_h    = weight_t - hub_short;          // above the iron's seat
wall_r   = weight_od/2 + od_clr;             // wall's inner radius
rim_in   = weight_od/2 - rim_w;              // where the iron's rim starts
screw_r  = outer_pcd/2;
lift     = disc_t + (under_style == "wheel" && rib_seat ? rib_h : 0) + weight_t + disc_t + seat_h;

wheel    = under_style == "wheel";
seat     = wheel && rib_seat && rib_h > 0 ? rib_h : 0;   // what the iron is lifted by
hub_top  = 30;                                // the iron's hub flat, radius
assert(wheel || wall_r + wall_t < under_d/2 - 5, "no overhang left outside the wall");
assert(!wheel || rib_seat || rib_h <= recess - 0.4, "ribs taller than the iron's recess");
assert(!wheel || wall_r + rib_gap + 5 < under_d/2 - ring_w, "no room for a rib between the iron and the ring");
assert(wheel || wall_h < weight_t, "wall taller than the iron: the over disc would sit on it");
assert(seat_h > 0 || screw_r + nut_af/2/cos(30) < rim_in - 0.5,
       "flat over disc: the nut under it lands on the iron's rim; use seat_h or re-measure outer_pcd and rim_w");
assert(screw_r + 4 < over_d/2, "bearing screws too near the over disc's edge");
assert(over_style != "wheel" || over_d/2 - over_ring_w <= race_inner/2 + seat_in, "over ring does not reach in under the seat pads");
assert(pads % outer_n == 0, "pads must be a multiple of the screws, so each screw has one");
assert(screw_r - race_pilot/2 - (race_inner/2 + seat_in) >= 2.5, "too little pad inboard of the screw");
assert(over_style != "wheel" || over_d/2 - over_ring_w < rim_in + 3, "over ring barely lands on the iron's rim");
echo(str("bearing sits ", lift, " above the desk; hub ", hub_d, " x ", hub_h, "; bearing screws at r ", screw_r,
         ", iron rim from r ", rim_in,
         seat_h > 0 ? str("; M4 taps ", seat_h + disc_t, " of plastic, nothing below the disc")
                    : "; clearance holes, nuts in the recess"));
echo(str("under: ", under_style, ", Ø", under_d, wheel ? str(", ", spoke_n, " spokes, ", 2*spoke_n, " ribs ", rib_h,
         rib_seat ? " high and the iron on them" : " high, in the iron's recess") : ""));

// A rib's side view, x from a to b, height ha falling to hb.
module rib(a, b, ha, hb) {
    for(y=[-1, 1]) translate([0, y*(spoke_w - rib_t)/2 + rib_t/2, 0]) rotate([90,0,0]) linear_extrude(rib_t)
        polygon([[a, disc_t - 0.01], [b, disc_t - 0.01], [b, disc_t + hb], [a, disc_t + ha]]);
}
// One spoke along +X, hub disc to ring.
module spoke() {
    translate([0, -spoke_w/2, 0]) cube([under_d/2 - ring_w/2, spoke_w, disc_t]);
    if(rib_h > 0) {
        if(rib_seat) rib(hub_d/2 - 1, wall_r, rib_h, rib_h);
        else rib(hub_top + rib_gap, weight_od/2 - rim_w - rib_gap, rib_h, rib_h);
        if(rib_seat || rib_outer) rib(rib_seat ? wall_r - 0.01 : wall_r + rib_gap, under_d/2 - ring_w/2, rib_h, rib_end);
    }
}
module under_wheel() {
    difference() {
        union() {
            cylinder(h=disc_t, d=hub_disc_d);
            cylinder(h=disc_t + seat + hub_h, d=hub_d);
            difference() {
                hull() {
                    cylinder(h=0.01, d=under_d - 2*edge_c);
                    translate([0,0,edge_c]) cylinder(h=disc_t - edge_c, d=under_d);
                }
                translate([0,0,-1]) cylinder(h=disc_t + 2, d=under_d - 2*ring_w);
            }
            for(i=[0:spoke_n-1]) rotate([0,0,i*360/spoke_n]) spoke();
        }
        translate([0,0,-1]) cylinder(h=disc_t + seat + hub_h + 2, d=m4_pilot, $fn=24);
        if(nut_trap) translate([0,0,-0.01]) cylinder(h=nut_h, d=nut_af/cos(30), $fn=6);
    }
}
module under() { if(wheel) under_wheel(); else under_disc(); }
module under_disc() {
    difference() {
        union() {
            // disc, bed edge broken
            hull() {
                cylinder(h=0.01, d=under_d - 2*edge_c);
                translate([0,0,edge_c]) cylinder(h=disc_t - edge_c, d=under_d);
            }
            cylinder(h=disc_t + hub_h, d=hub_d);
            if(ribs > 0) {
                difference() {
                    cylinder(h=disc_t + wall_h, r=wall_r + wall_t);
                    translate([0,0,disc_t]) cylinder(h=wall_h + 1, r=wall_r);
                }
                for(i=[0:ribs-1]) rotate([0,0,i*360/ribs]) translate([0, rib_t/2, 0]) rotate([90,0,0])
                    linear_extrude(rib_t) polygon([[wall_r + wall_t - 0.5, disc_t - 0.01], [under_d/2 - 2, disc_t - 0.01],
                                                   [wall_r + wall_t - 0.5, disc_t + wall_h]]);
            }
        }
        translate([0,0,-1]) cylinder(h=disc_t + hub_h + 2, d=m4_pilot, $fn=24);
        if(nut_trap) translate([0,0,-0.01]) cylinder(h=nut_h, d=nut_af/cos(30), $fn=6);
    }
}
// The outer race's width, as a ring seat_h tall: clear of the inner race, which turns.
module race_band() {
    translate([0,0,disc_t - 0.01]) difference() {
        cylinder(h=seat_h, d=bearing_od + 2*seat_margin);
        translate([0,0,-1]) cylinder(h=seat_h + 2, d=race_inner + 2*seat_in);
    }
}
module over() {
    ow = over_style == "wheel";
    difference() {
        union() {
            if(ow) {
                cylinder(h=disc_t, d=over_hub_d);
                difference() {
                    cylinder(h=disc_t, d=over_d);
                    translate([0,0,-1]) cylinder(h=disc_t + 2, d=over_d - 2*over_ring_w);
                }
                for(i=[0:outer_n-1]) rotate([0,0,i*360/outer_n])
                    translate([0, -over_spoke_w/2, 0]) cube([over_d/2 - over_ring_w/2, over_spoke_w, disc_t]);
                if(seat_h > 0) intersection() {
                    race_band();
                    for(i=[0:pads-1]) rotate([0,0,i*360/pads]) translate([screw_r, 0, 0]) cylinder(h=disc_t + seat_h + 1, d=pad_d);
                }
            } else {
                cylinder(h=disc_t, d=over_d);
                if(seat_h > 0) race_band();
            }
        }
        translate([0,0,-1]) cylinder(h=disc_t + 2, d=m4_clear, $fn=24);
        for(i=[0:outer_n-1]) rotate([0,0,i*360/outer_n]) translate([screw_r, 0, -1])
            cylinder(h=disc_t + seat_h + 2, d=seat_h > 0 ? race_pilot : race_clear, $fn=24);
    }
}
// The iron, for the preview only.
module iron() {
    color([0.25,0.25,0.27]) difference() {
        cylinder(h=weight_t, d=weight_od);
        translate([0,0,-1]) cylinder(h=weight_t + 2, d=weight_bore);
        for(z=[-0.01, weight_t - recess + 0.01]) translate([0,0,z]) difference() {
            cylinder(h=recess, r=rim_in);
            translate([0,0,-1]) cylinder(h=recess + 2, d=60);
        }
    }
}

if(part == "under") under();
if(part == "over")  over();
if(part == "pair") {
    under();
    %translate([0,0,disc_t + seat]) iron();
    translate([0,0,disc_t + seat + weight_t + 25]) over();
}
