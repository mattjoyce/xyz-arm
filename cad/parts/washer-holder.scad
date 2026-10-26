// Washer holder: a place on the V base for the spare 50 x 50 washers (Matt,
// 2026-09-27). A 50 x 50 x 2 plate on top of one of the base's 2020 rails,
// centred over it, with a post for the washers' M16 hole and a leg down the
// rail's side face, M5 x 10 into a drop-in tee nut. The leg runs down from
// under the plate, 10 off its centre, where the rail's side face is. It is
// v-base.scad's angle bracket with a wider pad: the same 5 mm leg, the same
// rib in the top slot's opening to square it. The spares are ballast too,
// wherever on the base they sit.
//
// The plate overhangs the rail 15 a side and is only 2 thick. The washers are
// 5 mm of steel and sit on the rail through it, so the overhang carries
// nothing.
//
// It cannot print in one piece without support: the post goes up from the
// plate and the leg goes down. So two parts (part = bracket | post):
//   bracket - plate, rib and leg. Printed upside down, plate's top on the
//             bed, leg and rib standing. No support.
//   post    - printed as it stands.
// One M3 x 16 cap head up through the plate into a pilot in the post. Its
// head hangs under the plate in the rail's top slot, 5.5 in the 6.0 opening,
// and the rib is cut away round it. The post only locates the washers, so
// the screw carries nothing either. Fit the post before the bracket goes on
// the rail.
//
// part = "whole" is the one piece, no M3. It prints standing on its end, the
// post level, and wants support under the post.
part        = "pair";  // [pair, bracket, post, whole]
rail        = 20;
plate       = [50, 50, 2];   // along the rail, across it, thick
corner_r    = 2;
spares      = 6;       // washers the post holds
washer      = [50, 50, 5];   // load-stack.scad's
post_d      = 16;      // the washers' hole is 17.5 to 18; the stack's M16 bolt is the same 16
post_over   = 3;       // post above a full stack
post_c      = 1.5;     // chamfer at its top
leg_t       = 5;
leg_short   = 2;       // leg stops this far above the desk
m5_clear    = 5.3;
rib_w       = 5.6;     // into the slot's 6.0 opening
rib_h       = 1.6;     // under a 1.8 lip
m3_clear    = 3.4;
m3_pilot    = 2.7;     // self-tapping, as the pulley cap's axle
m3_len      = 16;
m3_head     = 5.5;
rib_gap     = 8;       // rib cut away round the M3's head
print_flip  = false;   // bracket: upside down. whole: standing on its end
show_context = false;  // rail stub, washers and the M5; preview only
$fn = 64;

split   = part != "whole";
post_h  = spares*washer[2] + post_over;
m3_grip = m3_len - plate[2];

assert(m3_head < 6.0, "M3 head wider than the slot's opening");
assert(m3_grip + 2 < post_h, "M3 through the post's top");
assert(post_d/2 + corner_r < plate[1]/2, "post off the plate");
echo(str("holder: plate ", plate, " on the rail, leg ", leg_t, " x ", rail - leg_short, " down, M5 x 10 leaves ", 10 - leg_t,
         " for the tee nut; post ", post_d, " x ", post_h, " for ", spares, " washers, ", spares*86/1000, " kg",
         split ? str("; M3 x ", m3_len, " taps ", m3_grip, " of the post") : "; one piece"));

// Rail along X, its top face at z = 0, the leg on its side face at y = -rail/2.
module plate_2d() { offset(r=corner_r) square([plate[0] - 2*corner_r, plate[1] - 2*corner_r], center=true); }
module under_profile() {   // YZ: rib and leg, hanging from z = 0
    translate([-rib_w/2, -rib_h]) square([rib_w, rib_h + 0.01]);
    translate([-rail/2 - leg_t, -rail + leg_short]) square([leg_t, rail - leg_short + 0.01]);
}
module bracket() {
    difference() {
        union() {
            linear_extrude(plate[2]) plate_2d();
            intersection() {
                translate([-plate[0]/2, 0, 0]) rotate([90,0,90]) linear_extrude(plate[0]) under_profile();
                // the leg's and rib's ends follow the plate's corners
                translate([0, 0, -rail]) linear_extrude(rail + 1) plate_2d();
            }
        }
        translate([0, -rail/2 + 1, -rail/2]) rotate([90,0,0]) cylinder(h=leg_t + 2, d=m5_clear, $fn=32);
        if(split) {
            translate([0, 0, -rib_h - 1]) cylinder(h=rib_h + plate[2] + 2, d=m3_clear, $fn=24);
            translate([-rib_gap/2, -rib_w/2 - 1, -rib_h - 1]) cube([rib_gap, rib_w + 2, rib_h + 1]);
        }
    }
}
module post() {   // standing on z = 0
    difference() {
        union() {
            cylinder(h=post_h - post_c + 0.01, d=post_d);
            translate([0, 0, post_h - post_c]) cylinder(h=post_c, d1=post_d, d2=post_d - 2*post_c);
        }
        if(split) translate([0, 0, -1]) cylinder(h=m3_grip + 3, d=m3_pilot, $fn=24);
    }
}
module whole() { bracket(); translate([0, 0, plate[2] - 0.01]) post(); }

if(part == "bracket") { if(print_flip) translate([0, 0, plate[2]]) rotate([180,0,0]) bracket(); else bracket(); }
if(part == "post")    post();
if(part == "whole")   { if(print_flip) translate([0, 0, plate[0]/2]) rotate([0,-90,0]) whole(); else whole(); }
if(part == "pair")    { bracket(); translate([0, 0, plate[2]]) post(); }

if(show_context && !print_flip) %union() {
    color([0.66,0.71,0.75]) translate([-60, -rail/2, -rail]) difference() {
        cube([120, rail, rail]);
        for(s=[[rail/2, rail], [0, rail/2], [rail, rail/2], [rail/2, 0]])
            translate([-1, s[0], s[1]]) rotate([0,90,0]) linear_extrude(122) square(6, center=true);
    }
    if(part != "post") color([0.55,0.57,0.6]) for(i=[0:spares-1]) translate([0, 0, plate[2] + i*washer[2]]) difference() {
        translate([-washer[0]/2, -washer[1]/2, 0]) cube([washer[0], washer[1], washer[2] - 0.2]);
        translate([0,0,-1]) cylinder(h=washer[2] + 2, d=18);
    }
    color([0.2,0.2,0.2]) translate([0, -rail/2 - leg_t, -rail/2]) rotate([90,0,0]) cylinder(h=2.75, d=9.26, $fn=24);
}
