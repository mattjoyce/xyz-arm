// Arm end cap: a plain 20 x 20 lid for each end of the gantry 2020 (Matt,
// 2026-09-27). It carries nothing; it covers the cut end and its edges.
//
// The press fit is the spine cap's, by `use`, unchanged: a tee tab into two
// opposite slots, stem at the slot opening, head under the lips
// (spine-cap.scad, tabs()). That fit is proven on this V-slot. The cap is
// square, so it goes on with the tabs in either pair of slots; the side
// slots keep them out of the wheels' tracks.
//
// It stays inside the rail's 20 x 20, so it is not a travel stop: the wheels
// roll straight past it and off the end.
//
// Printed upside down (print_flip = true, which the STL is): the top face on
// the bed, the chamfer a 45 degree overhang, the tabs standing. No support.
// Print two.
use <spine-cap.scad>
rail        = 20;
cap_h       = 3;       // above the rail's end
edge_c      = 1;       // chamfer on the four top edges
corner_r    = 1;       // the four upright corners
print_flip  = false;   // top face down, tabs up
show_context = false;  // rail stub; preview only
$fn = 48;

assert(edge_c < cap_h, "chamfer taller than the cap");
assert(edge_c < rail/2 - corner_r, "chamfer leaves no top face");
echo(str("end cap ", rail, " x ", rail, " x ", cap_h, ", tabs from spine-cap.scad"));

module plan(d=0) { offset(r=corner_r) square(rail - 2*corner_r - 2*d, center=true); }

module arm_end_cap() {
    hull() {
        linear_extrude(cap_h - edge_c) plan();
        translate([0,0,cap_h - 0.01]) linear_extrude(0.01) plan(edge_c);
    }
    tabs();
}

if(print_flip) translate([0,0,cap_h]) rotate([180,0,0]) arm_end_cap();
else arm_end_cap();

if(show_context && !print_flip) %translate([0,0,-40]) color([0.66,0.71,0.75])
    linear_extrude(40) difference() {
        square(rail, center=true);
        for(a=[0:90:270]) rotate(a) {
            translate([-3, rail/2 - 1.8]) square([6, 3]);
            translate([-5.5, rail/2 - 5.5]) square([11, 3.7]);
        }
    }
