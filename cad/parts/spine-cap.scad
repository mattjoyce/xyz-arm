// Spine cap, v3: a square 20 x 20 block that plugs into the top of the
// vertical 2020 and carries the balance line over it in a 45 degree V groove.
// The line comes up the spine's front slot from the carriage, crosses the top,
// and drops THROUGH the cap into the rear slot's channel, so it runs down
// inside the channel to the load stack's T slider (load-stack.scad). No
// guide line anchors any more: Matt tried guide lines on the rig, 2026-09-19,
// and gave them up for the rail's own channel.
//
// Press fit from the rail's own geometry: a tee tab into each SIDE slot,
// stem a touch wider than the slot opening, head a diamond under the lips
// with every face at 45 degrees or vertical. No centre peg. The front and
// rear slots are left open.
//
// Cut for plain T-slot 2020, not V-slot: a 6 mm straight opening, lips about
// 1.8 thick, an 11 mm channel. Measure the rail: slot_w is what the fit
// rides on, and generic extrusion runs 6.0 to 6.3.
//
// The top's front edge is chamfered 45 degrees and the V groove follows the
// chamfer down to the face, so the line bends twice by 45 on its way down to
// the carriage. At the rear the groove runs level to drop_y, where a thin slit
// goes down through the cap into the channel and out through the rear face,
// so the line is laid in with the cap on and sits at the slit's front end.
//
// Printed upside down (print_flip = true, which the STL is): the top face is
// on the bed, the V groove is a 45 degree cavity, the chamfer a 45 degree
// overhang, the tabs stand up. No support.
//
// Friction: a groove is a capstan and the line wraps 180 degrees. At 10 N
// hanging and mu ~0.15 on smooth PLA that is about 3.8 N to raise the arm
// and 6 N to lower it. Keep the groove smooth; a pulley is the fallback.
rail        = 20;
// Plain T-slot 2020. Measure yours.
slot_w      = 6.0;     // opening at the face
lip_t       = 1.8;     // face to the underside of the lip
chan_w      = 11;      // channel width just under the lips
chan_str    = 1.6;     // how far below the lips the channel stays full width, before it angles in at 45
chan_d      = 5.5;     // face to the deepest the tab may go
cap_h       = 5;       // above the rail's end
groove_w    = 3;       // at the surface; 45 degree walls, so 1.5 deep
edge_c      = 1.5;     // chamfer on the front top edge; the groove follows it, so at least groove_d
side_c      = 1.5;     // chamfer on the rear and side top edges, the same
tab_len     = 5;       // into the rail
tab_fit     = 0.0;     // a side, in the opening: 0.1 sheared on the first print, printed stems run fat anyway
tab_clr     = 0.2;     // a side, everywhere else
drop_y      = 8.0;     // the slit's front end: the line drops here into the channel, at load-stack.scad's line_y
drop_slit   = 1.2;     // a thin slit from there out through the rear face
print_flip  = false;   // top face down, tabs up
show_context = false;  // rail stub and the two line runs; preview only
$fn = 48;

half       = rail/2;
groove_d   = groove_w/2;
// Tab, distances from the rail centre: stem through the opening to just under
// the lip, then a head full width for the channel's straight part, then 45
// degrees in to the bottom: the shape of a 2020 channel. The first cut was a
// diamond widest 4 mm down, where the channel has already narrowed, and it
// sheared going in.
stem_h     = slot_w/2 + tab_fit;
stem_top   = half - lip_t - tab_clr;          // underside of the lip
head_h     = chan_w/2 - tab_clr;              // full width
head_y     = half - lip_t - chan_str + tab_clr;   // down to where the channel angles in
bottom_y   = half - chan_d + tab_clr;         // deepest point
bottom_h   = head_h - (head_y - bottom_y);    // half width there

assert(groove_d < cap_h - 1, "groove through the cap");
assert(edge_c >= groove_d, "chamfer shallower than the groove");
assert(bottom_h > 1.5, "tab bottom too narrow: raise chan_d or chan_str");
assert(head_y > bottom_y, "channel too shallow for the head");
echo(str("cap ", cap_h, " high; tab stem ", 2*stem_h, " wide, head ", 2*head_h,
         " wide from ", half - stem_top, " to ", half - head_y, " below the face, then 45 in to ",
         2*bottom_h, " wide at ", half - bottom_y));

module tab_2d() {   // for the +Y slot, y outward; rotated to the side slots
    polygon([
        [-stem_h, half], [-stem_h, stem_top], [-head_h, stem_top], [-head_h, head_y],
        [-bottom_h, bottom_y], [ bottom_h, bottom_y],
        [ head_h, head_y], [ head_h, stem_top], [ stem_h, stem_top], [ stem_h, half]
    ]);
}
module tabs() {
    for(a=[90, -90]) rotate([0,0,a]) translate([0,0,-tab_len]) linear_extrude(tab_len + 0.01) tab_2d();
}

// Body: YZ profile with the two chamfers, extruded across X.
module body_2d() {   // YZ: front chamfer edge_c, rear chamfer side_c
    polygon([[-half, 0], [half, 0], [half, cap_h - side_c], [half - side_c, cap_h],
             [-half + edge_c, cap_h], [-half, cap_h - edge_c]]);
}
module sides_2d() {  // XZ: side chamfers
    polygon([[-half, 0], [half, 0], [half, cap_h - side_c], [half - side_c, cap_h],
             [-half + side_c, cap_h], [-half, cap_h - side_c]]);
}
module yz(w) { rotate([90,0,90]) linear_extrude(w, center=true) children(); }

// V cutter cross-section: apex groove_d below the surface, flared above it.
module vee_2d() {
    polygon([[-groove_w/2 - 1, 1], [-groove_w/2, 0], [0, -groove_d], [groove_w/2, 0], [groove_w/2 + 1, 1]]);
}
// The V section at a point on the path, tilted about X by `tilt` so it stays
// square to the surface (0 on the top, -45 down the rear chamfer).
module vee_at(y, z, tilt) {
    translate([0, y, z]) rotate([tilt, 0, 0]) rotate([90,0,0]) linear_extrude(0.02, center=true) vee_2d();
}
module groove() {
    yt = half - edge_c;   // front chamfer starts
    e  = 1.5;             // run past the face
    hull() { vee_at(-yt, cap_h, 22.5); vee_at(half + e, cap_h, 0); }
    hull() { vee_at(-yt, cap_h, 22.5); vee_at(-half - e, cap_h - edge_c - e, 45); }
}

assert(drop_y + drop_slit/2 < half, "drop slit starts outside the rear face");
assert(groove_d >= side_c, "rear chamfer reaches down to the drop hole mouth");
module drop() {
    hull() for(y=[drop_y, half + 1]) translate([0, y, -1]) cylinder(h=cap_h + 2, d=drop_slit, $fn=16);
    // eased front end, where the line turns down out of the groove
    translate([0, drop_y, cap_h - groove_d - 1]) cylinder(h=1.01, d1=drop_slit, d2=drop_slit + 2, $fn=16);
}
module spine_cap() {
    difference() {
        union() {
            intersection() { yz(rail) body_2d(); rotate([90,0,0]) linear_extrude(rail + 2, center=true) sides_2d(); }
            tabs();
        }
        groove();
        drop();
    }
}

if(print_flip) translate([0,0,cap_h]) rotate([180,0,0]) spine_cap();
else spine_cap();

if(show_context && !print_flip) %union() {
    translate([0,0,-60]) color([0.66,0.71,0.75]) linear_extrude(60) difference() {
        square(rail, center=true);
        for(a=[0:90:270]) rotate(a) {
            translate([-slot_w/2, half - lip_t]) square([slot_w, lip_t + 1]);
            translate([-chan_w/2, half - chan_d]) square([chan_w, chan_d - lip_t]);
        }
    }
    color([0.1,0.7,0.9]) for(y=[-half, half])
        translate([0, y, -60]) cylinder(h=60 + cap_h - edge_c, d=0.6, $fn=8);
}
