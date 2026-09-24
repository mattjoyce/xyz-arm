// Gantry plate, v3: a printed three-wheel plate for the horizontal rail,
// bolted with M4 to the back of the bought four-wheel metal plate that rides
// the spine (Matt, 2026-09-23). The printed 3 + 3 plate (compact-carriage.scad)
// could not hold the arm's moment on the spine and its centre bolt skewed in
// 3 mm of counterbored plate. The metal plate's four wheels now take the
// spine; this part only carries the gantry.
//
// Hardware is the kit's: M5 x 25 low-profile screws, 6 mm spacers (plain or
// eccentric), thin washers, nylocs. No M5 x 30. The metal plate is 3 mm, so
// its own wheels use the 25s as sold. Here each gantry screw goes in from the
// wheel side, head on the wheel's outer face, and threads into a nyloc
// trapped in a hex pocket in the plate's back. 25 - wheel - washer - spacer
// leaves 7.77: `layer` (3) of plate, then 4.77 into the 5 mm nut. The nut is
// held square over its full height by the pocket, so the screw is located
// over 8 mm, not 3, and the plate round the station stays full thickness.
// Nylon side of the nut faces the metal plate.
//
// The eccentric station: the collar's hole is 2.4 deep, 0.1 short of the
// collar, so the collar bears on the 0.6 mm left under the nut and the clamp
// runs nut, plastic, steel. The hex pocket there is opened by the orbit
// (8 + 2 x 0.395 + 0.2 = 9.0 across flats): the nut can shift with the
// screw but its 4.62 corners cannot turn in a 4.5 pocket.
//
// Back face details, all open to the metal plate:
//  - pockets for the four spine wheel screw heads (low-profile, 3 mm);
//  - two pegs into the metal plate's centre cross, one round, one narrow in
//    y only, so they square the gantry to the spine whatever the true hole
//    spacing is;
//  - M4 clearance slots under the metal plate's holes on the y = 0 row.
//    The M4s go in from the spine side, head on the metal plate between its
//    wheels, through both plates, into nuts in hex pockets sunk in the FRONT
//    face. The nut has to sit on the far side of the printed plate from the
//    head, or the joint clamps only the aluminium. The front face there is
//    under the gantry rail (2.1 mm gap), so the nuts go in before the rail
//    and stay captive; the heads stay reachable from the spine side. Slots
//    run 1.5 each way in x because the metal plate's holes were read off a
//    photo, about 2 % out. M4 x 12: 3 of metal, then 9 of plate.
//
// The gantry stations sit at x = +-34: nearer in, their nut pockets meet the
// spine wheels' head pockets at x = +-20.32.
//
// Local frame: XY is the plate, back face at z = 0 on the metal plate, front
// face at z = thickness. The spine runs along Y at x = 0 behind the metal
// plate; the gantry along X at y = 0 in front.
//
// Prints front face down: the back's pockets and the pegs open upward, the
// M4 nut pockets onto the bed.
use <vslot-wheel.scad>
use <wheel-spacer.scad>
use <vslot-2020.scad>
part       = "plate";   // [plate, template, context]
print_flip = false;     // front face down, for export
thickness  = 9;
x_pitch    = 68;        // gantry fixed pair, centre to centre
boss_r     = 10;
screw_l    = 25;
spacer_l   = 6;
shim_t     = 1;
layer      = 3;         // plate between the spacer and the nut
nut_af     = 8;         // M5 nyloc
nut_h      = 5;
nut_fit    = 0.1;       // per side, fixed stations
bolt_hole  = 5.1;
ecc_fit    = 0.1;       // per side round the 7.11 collar hole
collar_d   = 2.4;       // collar hole depth; the collar is 2.5
ecc_slack  = -0.1;      // as compact-carriage.scad, iteration 46
lobe_r     = 5;
lobe_y     = 38;        // above the metal plate's top edge (32.75)
line_hole  = 2;
// The metal plate, measured off the deskcam on 2026-09-20, about 2 %.
metal_size = 65.5;
metal_t    = 3;
z_off      = vwheel_2020_offset();   // its wheel columns, 40.64 apart nominal
z_row      = 20;                     // its four wheels at y = +-20
z_head_d   = 13;        // Ø9.5 head, its eccentric orbit and the photo's error
z_head_h   = 3.6;
m4_holes   = [[-20.32, 0], [20.32, 0], [-30, 0], [30, 0]];  // column holes, edge slots
m4_nut_af  = 7;
m4_nut_h   = 3.2;
m4_slop    = 1.5;       // slot length each way in x
m4_hole    = 4.5;
m4_pocket  = 3.6;       // nut pocket depth from the front face
m4_len     = 12;
peg_d      = 4.8;       // into Ø5 holes
peg_h      = 2.4;       // the metal plate is 3; the spine rail is 2.1 beyond it
peg_round  = [0, 10];
peg_flat   = [0, -10];  // narrow in y: locates x only
peg_flat_w = 2.5;
template_t = 2;
$fn = 48;

wheel_off  = vwheel_2020_offset();
rail_face  = vwheel_width()/2 + shim_t + spacer_l;
e          = spacer_eccentricity();
nut_thread = screw_l - vwheel_width() - shim_t - spacer_l - layer;
ecc_nut_af = nut_af + 2*e + 0.2;
ecc_hole   = spacer_plate_hole() + 2*ecc_fit;
orbit_hole = 5 + 2*e + 0.2;
x_stations = [[-x_pitch/2, -wheel_off], [x_pitch/2, -wheel_off], [0, wheel_off]];  // last is the eccentric
z_heads    = [for(sx=[-1,1], sy=[-1,1]) [sx*z_off, sy*z_row]];
echo(str("rails ", 2*rail_face + metal_t + thickness, " apart centre to centre; ", nut_thread,
         " of thread in each gantry nyloc; M4 x ", m4_len, " fills ", m4_engage, " of its nut; eccentric from ", ecc_slack, " clear to ",
         2*e - ecc_slack, " inside tangency"));
assert(nut_thread >= 4.5, "screw too short: thin `layer`");
assert(layer + nut_h <= thickness, "nut stands proud of the back face");
assert(peg_h < metal_t, "pegs would reach the spine rail");
m4_engage = m4_len - metal_t - (thickness - m4_pocket);
assert(m4_engage >= m4_nut_h - 0.2, "M4 too short to fill its nut");
assert(m4_len - metal_t <= thickness + 2, "M4 end reaches the gantry rail");

module hex(af, h) { cylinder(h=h, d=af/cos(30), $fn=6); }

// A gantry station. The fixed ones have a close hole through the layer;
// the eccentric has the collar's hole, then room for the screw's orbit. Its
// centre is drawn toward the rail so the wheel swings from ecc_slack clear
// to 2e - ecc_slack inside tangency.
module station(p, ecc) {
    shift = ecc ? -(e - ecc_slack) : 0;
    translate([p[0], p[1] + sign(p[1])*shift, 0]) {
        if(ecc) {
            translate([0, 0, thickness - collar_d]) cylinder(h=collar_d + 1, d=ecc_hole);
            translate([0, 0, -1]) cylinder(h=thickness + 2, d=orbit_hole);
            translate([0, 0, -1]) hex(ecc_nut_af, thickness - layer + 1);
        } else {
            translate([0, 0, -1]) cylinder(h=thickness + 2, d=bolt_hole);
            translate([0, 0, -1]) hex(nut_af + 2*nut_fit, thickness - layer + 1);
        }
    }
}
module m4_fixing(p) {
    translate([p[0], p[1], 0]) {
        hull() for(dx=[-m4_slop, m4_slop]) translate([dx, 0, -1]) cylinder(h=thickness + 2, d=m4_hole);
        // in the front face, flats facing +-y: the nut slides in x but cannot turn
        hull() for(dx=[-m4_slop, m4_slop]) translate([dx, 0, thickness - m4_pocket]) rotate([0, 0, 30]) hex(m4_nut_af + 0.3, m4_pocket + 1);
    }
}
module outline_2d() {
    hull() {
        offset(r=3) offset(delta=-3) square(metal_size, center=true);
        for(p=x_stations) translate(p) circle(r=boss_r);
        translate([0, lobe_y]) circle(r=lobe_r);
    }
}
module plate_body() {
    difference() {
        linear_extrude(thickness) outline_2d();
        for(i=[0:2]) station(x_stations[i], i == 2);
        for(p=z_heads) translate([p[0], p[1], -1]) cylinder(h=z_head_h + 1, d=z_head_d);
        for(p=m4_holes) m4_fixing(p);
        translate([0, lobe_y, -1]) cylinder(h=thickness + 2, d=line_hole, $fn=16);
    }
    translate([peg_round[0], peg_round[1], -peg_h]) cylinder(h=peg_h + 0.01, d=peg_d);
    translate([peg_flat[0], peg_flat[1], -peg_h]) intersection() {
        cylinder(h=peg_h + 0.01, d=peg_d);
        translate([-peg_d/2, -peg_flat_w/2, 0]) cube([peg_d, peg_flat_w, peg_h + 0.01]);
    }
}
// A 2 mm slice of the back face with the pegs, to try on the metal plate
// before printing the whole plate.
module template() { intersection() { plate_body(); translate([-100, -100, -peg_h - 1]) cube([200, 200, peg_h + 1 + template_t]); } }

// The metal plate as read off the photo, for the context view only.
module metal_plate() {
    difference() {
        translate([0, 0, -metal_t]) linear_extrude(metal_t) offset(r=3) offset(delta=-3) square(metal_size, center=true);
        for(y=[-20, 0, 20]) translate([-z_off, y, -5]) cylinder(h=10, d=7);
        for(y=[-20:10:20]) translate([z_off, y, -5]) cylinder(h=10, d=5);
        for(p=[[0,0],[10,0],[-10,0],[0,10],[0,-10]]) translate([p[0], p[1], -5]) cylinder(h=10, d=5);
        for(x=[-30, 30], y=[-10, 0, 10]) translate([x, y, -5]) hull() for(dx=[-1.5, 1.5]) translate([dx, 0, 0]) cylinder(h=10, d=5);
    }
}

module plate() { if(part == "template") template(); else plate_body(); }
if(part != "context") {
    if(print_flip) translate([0, 0, thickness]) rotate([180, 0, 0]) plate();
    else color([0.91,0.30,0.12]) plate();
}
if(part == "context") {
    color([0.91,0.30,0.12]) plate_body();
    color([0.80,0.82,0.85]) metal_plate();
    %color([0.66,0.71,0.75]) translate([0, 0, -metal_t - rail_face]) rotate([-90,0,0]) translate([0,0,-70]) linear_extrude(140) vslot_2020_profile();
    %color([0.66,0.71,0.75]) translate([0, 0, thickness + rail_face]) rotate([0,90,0]) translate([0,0,-80]) linear_extrude(160) vslot_2020_profile();
    for(p=z_heads) %translate([p[0], p[1], -metal_t - shim_t - spacer_l - vwheel_width()/2]) vslot_wheel(false);
    for(p=x_stations) %translate([p[0], p[1], thickness + shim_t + spacer_l + vwheel_width()/2]) vslot_wheel(false);
}
