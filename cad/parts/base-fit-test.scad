// One 2 mm gauge plate. Tests both base interfaces in a single short print.
//
//   centre : three 2020 apertures on a wide clearance bracket
//   rim    : both candidate bearing bolt circles, 128 and 102 PCD
//
// Marked with tally holes rather than text: round holes print at travel speed
// where small glyph perimeters do not. Tallies sit BELOW their aperture, which
// also keys the orientation — read them above and the plate is upside down,
// and the clearance order would otherwise reverse.
//
// TWO THINGS THIS CANNOT TELL YOU.
//  1. A 2 mm aperture reads the XY clearance almost purely. The real socket is
//     45 mm deep, where wall lean and friction both bite, so whatever slides
//     nicely here will feel tighter at full depth. Expect to add a little.
//  2. The number belongs to this printer, nozzle, material, layer height and XY
//     compensation — not to the geometry. Keep them identical for the final
//     part or the result does not carry over.

rail          = 20;
clearances    = [0.15, 0.30, 0.45];   // per side; tally count = index, 1..3
plate_t       = 2;
aperture_gap  = 4;
corner_relief = 1.6;   // FDM cannot cut a sharp internal corner; without this
                       // the bulge sits on the corners and the flats never seat

/* [Bearing] */
plate_d       = 145;
outer_pcd     = 128;   // photo estimate — this plate exists to test it
inner_pcd     = 102;   // photo estimate
pcd_hole      = 5.2;   // close fit on M5

/* [Tally] */
tally_d       = 2.6;
tally_pitch   = 5;
tally_y       = -17;

/* [Lightening] */
// Four hull cutouts instead of a field of small holes: fewer features, far more
// air (36% of the disc against 12%), and each one is a single convex shape whose
// clearance can be checked exactly rather than eyeballed.
//
// Every cutout is verified by studies/check-cutouts.py, which measures the real
// distance from each cutout to the aperture zone, to all eight bolt holes and to
// the rim. Worst case as built: zone 4.50 (need 4.0), bolt 7.00 (need 6.6), rim
// 7.55 (need 3.5). Change a number here and re-run that script before printing —
// the top corners in particular were caught fouling a diagonal bolt by an edge
// rather than by a vertex, which is not visible by eye.
lighten       = true;
cut_r_tb      = 6;     // corner radius, top and bottom cutouts
cut_r_lr      = 5;     // corner radius, left and right
cut_top  = [[-22,29],[22,29],[24,45],[16,51],[-16,51],[-24,45]];
cut_left = [[-45.5,-28],[-45.5,28],[-51.9,30],[-51.9,-30]];

n      = len(clearances);
pitch  = rail + 2*max(clearances) + aperture_gap;
xs     = [for(i=[0:n-1]) (i - (n-1)/2) * pitch];


module hull_cut(pts, r) {
    translate([0,0,-0.1]) linear_extrude(plate_t+0.2)
        hull() for(p=pts) translate(p) circle(r=r, $fn=48);
}

module aperture(c, x) {
    side = rail + 2*c;
    translate([x,0,-0.1]) linear_extrude(plate_t+0.2) {
        square(side, center=true);
        for(sx=[-1,1], sy=[-1,1])
            translate([sx*side/2, sy*side/2]) circle(d=corner_relief, $fn=24);
    }
}

module gauge() {
    difference() {
        cylinder(h=plate_t, d=plate_d, $fn=180);
        for(i=[0:n-1]) aperture(clearances[i], xs[i]);
        // tally: i+1 holes under aperture i, smallest clearance = one hole
        for(i=[0:n-1]) for(k=[0:i])
            translate([xs[i] + (k - i/2)*tally_pitch, tally_y, -0.1])
                cylinder(h=plate_t+0.2, d=tally_d, $fn=20);
        for(a=[0:90:270])  rotate([0,0,a]) translate([outer_pcd/2,0,-0.1])
            cylinder(h=plate_t+0.2, d=pcd_hole, $fn=32);
        for(a=[45:90:315]) rotate([0,0,a]) translate([inner_pcd/2,0,-0.1])
            cylinder(h=plate_t+0.2, d=pcd_hole, $fn=32);
        if(lighten) {
            hull_cut(cut_top,  cut_r_tb);
            hull_cut([for(p=cut_top)  [ p[0],-p[1]]], cut_r_tb);
            hull_cut(cut_left, cut_r_lr);
            hull_cut([for(p=cut_left) [-p[0], p[1]]], cut_r_lr);
        }
    }
}

assert(outer_pcd/2 + pcd_hole/2 + 3.5 < plate_d/2,
       "outer bolt circle runs off the plate");

gauge();
