// Gantry plate, v2: the carriage that joins the spine to the gantry. One
// 8 mm printed plate; three clear V wheels on its spine face ride the
// vertical rail, three on its gantry face carry the horizontal one, each set
// two fixed 60 mm apart and one opposing at the centre. The centre station
// takes an eccentric spacer: some of the sets' spacers turned out to be
// eccentrics with a 7 mm collar (Matt, 2026-09-20, after the first plate was
// printed without). `eccentric = false` gives that first plate back, where
// preload is `preload`, the centre station drawn that much closer to the rail
// than tangency, and the plate's own give.
//
// An eccentric's collar turns in the plate and the screw orbits it at
// `spacer_eccentricity()`, so the collar's hole cannot step down to a bolt
// hole on the same centre: the screw would bind after 0.15 mm. The hole runs
// at collar size through the 3 mm under the head, as on a bought plate, the
// head bears on its rim, and the counterbore is opened for the head's orbit.
// The collar's centre is set so the wheel swings from `ecc_slack` clear of
// the rail to the rest of the travel inside tangency.
//
// What was bought, seen on the bench 2026-09-20: two sets of four clear
// wheels (23.9 x 10.23 with 625 bearings), each with a low-profile M5 x 25,
// a 6 mm spacer, a thin washer and a nyloc. The screw is sized for a 3 mm
// plate: plate, spacer, washer and wheel come to 20 and leave 5 for the nut.
// So every station here is counterbored 5 deep from the far face and the
// head sits on 3 mm of plate, which is the same stack as a Mini V plate.
//
// That counterbore also settles the clash at the two centre stations. The
// wheel's half width, the washer and the spacer put each rail's centre
// 12.115 out from its plate face, so the OTHER rail's face sits 2.1 mm off
// the far face, right over the centre station's head. Sunk 5 deep, a 3 mm
// head is 2 mm below the face. The four outer stations are 30 mm off the
// other rail's centreline anyway. Nuts go on the wheel side.
//
// The balance line's front run hangs down the spine's front face from the
// cap (spine-cap.scad) at x = 0 and ties to the plate's top lobe through a
// 2 mm hole, front to back: thread it through and knot it (Matt,
// 2026-09-20). The hole is at the lobe's centre, 5 mm in from the top edge
// and on the plate's mid-plane, so the line hangs 6 mm in front of the
// rail's face, which over 400 mm is nothing. The line is adjusted at the
// other end, under the load stack.
//
// Prints flat on either face; the counterbores on the underside are Ø10.5
// ceilings 5 mm up, which bridge.
//
// Local frame, as the assembly uses it: XY is the plate, +Z is the gantry
// face, -Z the spine face. The spine runs along Y at x = 0 on the -Z face,
// the gantry along X at y = 0 on the +Z face.
use <vslot-wheel.scad>
use <wheel-spacer.scad>
use <vslot-2020.scad>
part      = "plate";    // [plate, context]
size      = 84;
thickness = 8;
spacing   = 60;         // fixed wheels, centre to centre
boss_r    = 10;         // outline round each station
preload   = 0.1;        // centre station drawn this much inside tangency
eccentric = true;       // eccentric spacer at each centre station
screw_l   = 25;
spacer_l  = 6;          // between the wheel and the plate
shim_t    = 1;          // the set's washer, between wheel and spacer
bolt_hole = 5.1;        // M5, close: the four fixed wheels are the datum, and in a 5.3 hole each
                        // could be pushed 0.15 off the rail by the preload. Ream with a 5 mm drill.
ecc_fit   = 0.1;        // per side, printed, round the 7.11 collar hole
ecc_slack = -0.1;       // wheel this far clear of the rail at the eccentric's loose end. Negative:
                        // on the second print (0.2) the eccentrics only gripped at the very end of
                        // their travel, 0.59 inside drawn tangency (Matt, 2026-09-20), so drawn
                        // tangency is about 0.5 short of real contact. -0.1 with the closer fixed
                        // holes should put the grip near the middle of the travel.
cbore_d   = 10.5;       // low-profile head about 9.5
cbore_h   = 5;
head_h    = 3;          // low-profile socket
centre_d  = 12;         // through hole where the rails cross
lobe_r    = 5;          // the top lobe, round the line hole
line_hole = 2;          // through the lobe, front to back
lighten   = true;       // windows between the stations
rim_w     = 6;          // what stays round the outline
web_w     = 5;          // spokes, hub to station
win_r     = 3;          // window corner radius
$fn = 48;

wheel_off = vwheel_2020_offset();                  // 20.32 from the rail centre
rail_face = vwheel_width()/2 + shim_t + spacer_l;  // rail centre, from the plate face
gap       = rail_face - 10;                        // the other rail's face, from the plate face
proud     = head_h - cbore_h;
nut_thread = screw_l - (thickness - cbore_h) - spacer_l - shim_t - vwheel_width();
ecc_hole  = spacer_plate_hole() + 2*ecc_fit;
ecc_cbore = cbore_d + 2*spacer_eccentricity();     // the head orbits with the screw
echo(str("rails ", 2*rail_face + thickness, " apart; other rail ", gap, " off the plate face; heads ", -proud,
         " below it; ", nut_thread, " of thread for the nut; centre wheels ",
         eccentric ? str(ecc_slack, " clear to ", 2*spacer_eccentricity() - ecc_slack, " inside tangency")
                   : str(preload, " inside tangency")));
assert(proud < gap - 0.5, "centre station head fouls the other rail: deepen cbore_h or use a lower head");
assert(nut_thread >= 4, "screw too short for the nyloc: deepen cbore_h or thin the plate");
assert(thickness - cbore_h >= 2.5, "too little plate under the head");

// Last point in each set is the eccentric adjuster.
function carriage_z_holes(spacing=60) =
    [[-vwheel_2020_offset(),-spacing/2],[-vwheel_2020_offset(),spacing/2],
     [vwheel_2020_offset(),0]];
function carriage_x_holes(spacing=60) =
    [[-spacing/2,-vwheel_2020_offset()],[spacing/2,-vwheel_2020_offset()],
     [0,vwheel_2020_offset()]];

// One station's holes. side: -1 the wheel is on the -Z face, +1 on +Z.
// The centre station (adjust) moves toward the rail by preload, or, with an
// eccentric, puts the collar's centre where the wheel's swing starts
// ecc_slack clear of the rail.
module station(p, side, adjust) {
    ecc = adjust && eccentric;
    e = adjust ? (eccentric ? spacer_eccentricity() - ecc_slack : preload) : 0;
    shift = adjust ? (side < 0 ? [-e, 0] : [0, -e]) : [0, 0];
    translate([p[0] + shift[0], p[1] + shift[1], 0]) {
        cylinder(h=thickness + 2, d=ecc ? ecc_hole : bolt_hole, center=true);
        // head sunk in the far face
        translate([0, 0, side < 0 ? thickness/2 - cbore_h : -thickness/2 - 1]) cylinder(h=cbore_h + 1, d=ecc ? ecc_cbore : cbore_d);
    }
}
// The line hole, through the top lobe.
module tie() { translate([0, size/2 - lobe_r, 0]) cylinder(h=thickness + 2, d=line_hole, center=true, $fn=16); }
module outline_2d(size, spacing) {
    hull() {
        for(p=concat(carriage_z_holes(spacing), carriage_x_holes(spacing))) translate(p) circle(r=boss_r, $fn=24);
        translate([0, size/2 - lobe_r]) circle(r=lobe_r, $fn=24);
    }
}
// What stays when the plate is lightened: the rim, a boss round every
// station, a hub round the centre hole, and a spoke from the hub to the
// three spine stations and the centre gantry station. The two outer gantry
// stations sit on the rim beside the spine's fixed pair and need no spoke.
// The windows are whatever is left, corners rounded.
module web_2d(size, spacing) {
    z = carriage_z_holes(spacing); x = carriage_x_holes(spacing);
    difference() { outline_2d(size, spacing); offset(r=-rim_w) outline_2d(size, spacing); }
    for(p=concat(z, x)) translate(p) circle(r=boss_r);
    circle(d=centre_d + 2*web_w);
    for(p=concat(z, [x[2]])) hull() { circle(d=web_w); translate(p) circle(d=web_w); }
}
module windows_2d(size, spacing) {
    offset(r=win_r) offset(r=-win_r) difference() { outline_2d(size, spacing); web_2d(size, spacing); }
}
module compact_carriage(size=84, thickness=8, spacing=60) {
    z = carriage_z_holes(spacing);
    x = carriage_x_holes(spacing);
    difference() {
        linear_extrude(height=thickness, center=true) outline_2d(size, spacing);
        tie();
        for(i=[0:2]) station(z[i], -1, i == 2);
        for(i=[0:2]) station(x[i], +1, i == 2);
        cylinder(h=thickness + 2, d=centre_d, center=true, $fn=32);
        if(lighten) linear_extrude(height=thickness + 2, center=true) windows_2d(size, spacing);
    }
}

if(part == "plate") color([0.91,0.30,0.12]) compact_carriage(size, thickness, spacing);
if(part == "context") {
    color([0.91,0.30,0.12]) compact_carriage(size, thickness, spacing);
    %color([0.66,0.71,0.75]) translate([0, 0, -thickness/2 - rail_face]) rotate([-90,0,0]) translate([0,0,-60]) linear_extrude(120) vslot_2020_profile();
    %color([0.66,0.71,0.75]) translate([0, 0,  thickness/2 + rail_face]) rotate([0,90,0]) translate([0,0,-60]) linear_extrude(120) vslot_2020_profile();
    for(p=carriage_z_holes(spacing)) %translate([p[0], p[1], -thickness/2 - shim_t - spacer_l - vwheel_width()/2]) vslot_wheel(false);
    for(p=carriage_x_holes(spacing)) %translate([p[0], p[1],  thickness/2 + shim_t + spacer_l + vwheel_width()/2]) vslot_wheel(false);
}
