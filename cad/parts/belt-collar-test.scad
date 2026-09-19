// Belt clamp collar test: the two collars that anchor the GT2 belt to the
// spine for the Z brake, and nothing else. The belt lies on the floor of one
// slot channel, teeth outward, wholly under the rail's surface. Each end is
// held by the tip of an M5 x 10 button head, the base's tee bolt, driven
// straight into the collar wall (it forms its own thread in a 4.3 mm hole)
// and in through the slot throat, pressing the belt onto the channel floor.
// The head is sunk 2 mm so the 10 mm screw reaches, 1.1 mm into the belt,
// and it cannot bottom on the aluminium floor.
//
// Two pieces, side by side:
//   ring  - open sleeve, the base end. On the real base this is the socket
//           wall itself; here it is 20 mm of it with the clamp station.
//   cap   - closed-top sleeve, the top end. Belt tension pulls it down onto
//           the rail's end face, so it needs no other fixing for the test.
// Same square pocket as z-base.scad (boss_2d, pocket_2d), so the fit is the
// settled 0.375 mm a side. Print both flat: the cap on its closed end, the
// ring either way up (0.5 mm chamfer on the bed end clears elephant's foot).
//
// Test: ring and cap on the two ends of a rail offcut, belt down the +Y
// channel between them, clamp screws driven until they stop on the belt.
// Pull. The question is whether a screw tip on rubber holds 10 N without
// creeping, or whether the belt end wants a pin through it.
use <z-base.scad>
use <vslot-2020.scad>

rail        = 20;
socket_fit  = 0.375;   // per side, from the gauge; z-base.scad has the same
collar_h    = 20;      // open ring height
cap_t       = 3;       // closed top on the cap
lead_in     = 1.0;     // pocket mouth chamfer at the top
foot_chamfer= 0.5;     // bed-end chamfer on the pocket
station_z   = 10;      // clamp screw, up from the open end
gap         = 12;      // between the two pieces on the bed
with_cap    = false;   // second piece: the closed cap, or another ring (quicker)

belt_w      = 6;       // GT2 6 mm
belt_t      = 1.38;    // backing plus tooth, nominal

// The base's tee bolt: M5 x 10 button head, Ø9.26 head.
screw_len   = 10;
head_d      = 9.26 + 1.2;   // counterbore, 0.6 a side for the print
clamp_form  = 4.3;     // thread-forming hole for M5 in PETG (minor Ø4.02)
clamp_sink  = 2;       // head into the wall, so the 10 mm screw reaches the belt

show_context = false;  // rail stub, belt and screw; preview only
$fn = 48;

// Profile numbers from vslot-2020.scad.
slot_floor   = 10 - 1.80 - 4.30;   // 3.9 from centre
slot_throat  = 6.25;
socket_in    = rail + 2*socket_fit;
wall         = 5.8;
outer_half   = socket_in/2 + wall;
belt_top     = slot_floor + belt_t;

clamp_tip    = outer_half - clamp_sink - screw_len;   // from the rail centre
clamp_bite   = belt_top - clamp_tip;

assert(clamp_form < slot_throat, "clamp hole wider than the slot throat");
assert(clamp_tip > slot_floor, "clamp screw can bottom on the channel floor");
assert(clamp_bite >= 0.8, "clamp screw does not reach into the belt");
assert(wall - clamp_sink >= 3, "too little wall left to form the clamp thread");
assert(station_z + head_d/2 <= collar_h, "counterbore runs off the collar");
echo(str("clamp tip at ", clamp_tip, " from centre, ", clamp_bite, " mm into the belt"));

// The clamp station through the +Y wall at height z: thread-forming bore from
// inside the pocket out, counterbore from `sink` into the wall to outside.
module station(z, bore, sink) {
    translate([0,0,z]) rotate([-90,0,0]) {
        translate([0,0,socket_in/2 - 0.5]) cylinder(h=wall+2, d=bore, $fn=32);
        translate([0,0,outer_half - sink]) cylinder(h=sink+2, d=head_d, $fn=32);
    }
}
// Chamfer on the pocket mouth at z (the top at z=h, or the bed at z=0).
module mouth_chamfer(z, c, up=true) {
    s = up ? 1 : -1;
    translate([0,0,z]) hull() {
        translate([0,0,-s*c]) linear_extrude(0.01, center=true) pocket_2d();
        translate([0,0, s*0.5]) linear_extrude(0.01, center=true) pocket_2d(c+0.5);
    }
}

module collar(h, closed=false) {
    z = closed ? cap_t + station_z : station_z;
    difference() {
        linear_extrude(h) boss_2d();
        if(closed) translate([0,0,cap_t]) linear_extrude(h) pocket_2d();
        else translate([0,0,-1]) linear_extrude(h+2) pocket_2d();
        mouth_chamfer(h, lead_in);
        if(!closed) mouth_chamfer(0, foot_chamfer, up=false);
        station(z, clamp_form, clamp_sink);
    }
}

module ring() { collar(collar_h); }
module cap()  { collar(collar_h + cap_t, closed=true); }

translate([-(outer_half + gap/2), 0, 0]) ring();
translate([ (outer_half + gap/2), 0, 0]) if(with_cap) cap(); else ring();

if(show_context) %union() {
    at = [-(outer_half + gap/2), 0, 0];
    translate(at) {
        translate([0,0,-30]) color([0.66,0.71,0.75]) vslot_2020(70);
        // Belt on the +Y channel floor, and the clamp screw down onto it.
        translate([-belt_w/2, slot_floor, -30]) color([0.15,0.15,0.15]) cube([belt_w, belt_t, 70]);
        translate([0, clamp_tip, station_z]) rotate([-90,0,0])
            color([0.65,0.69,0.72]) cylinder(h=screw_len, d=5, $fn=24);
    }
}
