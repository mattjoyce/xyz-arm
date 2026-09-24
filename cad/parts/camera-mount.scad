// Camera mount for the gantry rail: a light block that offers a hole to tap
// 1/4-20, the camera thread (Matt, 2026-09-20). It replaces the Manfrotto
// clamp's block, which with the clamp is most of what the arm carries at the
// long end of its lever.
//
// style = "slide" (default, Matt's idea): no screws and no Allen key. A T
// on top of the block is the rail's own channel profile, the one the load
// stack's sliders proved on this V-slot (load-stack.scad, numbers copied, not
// re-derived). It slides into the rail's UNDERSIDE slot from the rail's end
// and the block hangs under the rail with the 1/4 hole on the centreline. The
// camera's weight seats the T's shoulders on the slot's lips, and that
// friction is all that keeps it in place along a level rail, which is
// enough: it takes a 17 degree slope to slide PLA on aluminium. Hanging, it
// sits head_clr lower than drawn, so an off-centre load can rock it about a
// degree until the block's top corner meets the rail; that is a set, not a
// wobble. The hole is blind, because the stem above it is no wider than
// the hole.
//
// style = "bolt" is a right angle piece: a side plate against the rail's outer
// side face, held by one M5 into a drop-in tee nut in that face's slot, and a
// shelf under the rail with the 1/4 hole on the rail's centreline, so the load
// hangs straight under the rail and nothing twists. The shelf bears on the
// rail's underside, which squares the bracket. One bolt would let it pivot,
// so the shelf carries a low key that sits in the underside slot (Matt,
// 2026-09-21): shallower than the lips, so it only locates, and split either
// side of the 1/4 hole. The top and bottom slots are the wheels', so the
// bracket lives outboard of the carriage and is the rail's travel stop at
// that end.
//
// The hole is drawn at the 1/4-20 tap drill, 5.1, plus what a printed hole
// closes up by. It is tapped across the layers, not along them, so the
// thread's load runs in the perimeters. A ball head has a female base: join
// it with a 1/4-20 stud or a cut-off bolt.
//
// Printed standing on its L profile (print_flip = true, which the STL is):
// every hole is then a small horizontal one, no support, and the layers run
// the length of the shelf, which is the way it bends.
style       = "slide"; // [slide, bolt]
rail        = 20;
len         = 30;      // along the rail
// slide: the block under the rail
block_w     = 20;
block_h     = 12;
tap_depth   = 11;      // blind: leaves a floor under the stem
block_c     = 2;       // chamfer on the block's lower edges
// slide: the slot, as load-stack.scad has it frozen from what printed
slot_w      = 6.0;
lip_t       = 1.8;
chan_w      = 11;
chan_str    = 1.6;
chan_d      = 5.5;
stem_w      = slot_w - 0.5;
head_w      = chan_w - 0.6;
head_clr    = 0.2;
// bolt: the L
plate_t     = 5;       // side plate
shelf_t     = 8;       // under the rail: the thread's depth
m5_clear    = 5.3;
key_w       = stem_w;  // the key in the underside slot: the slider's stem, 0.25 a side
key_h       = 1.5;     // short of lip_t, it never reaches the channel
key_c       = 0.5;     // lead-in on its top edges
key_gap     = 8;       // left open around the 1/4 hole
tap_drill   = 5.1;     // 1/4-20 UNC
hole_shrink = 0.2;     // a printed hole comes out about this much small
edge_r      = 2;       // outside corners of the L, rounded; the inside one, where the rail sits, stays sharp
print_flip  = false;
show_context = false;
$fn = 48;

tap_d = tap_drill + hole_shrink;
knee_z   = lip_t + chan_str - head_clr;      // above the rail's underside, into the slot
head_z   = chan_d - head_clr;
head_bot = head_w - 2*(head_z - knee_z);
assert(style != "slide" || tap_depth < block_h, "tap hole breaks into the stem");
if(style == "slide") echo(str("slide: block ", block_w, " x ", block_h, " x ", len, ", T stem ", stem_w, " head ", head_w,
         " to ", knee_z, " then 45 in to ", head_bot, " at ", head_z, "; 1/4-20 hole ", tap_d, " x ", tap_depth, " deep, blind"));
if(style == "bolt") echo(str("1/4-20: hole drawn ", tap_d, " for a ", tap_drill, " tap drill, ", shelf_t, " of thread; one M5 x 10 leaves ",
         10 - plate_t, " for the tee nut; key ", key_w, " x ", key_h, " in the underside slot; ", len, " x ", rail + plate_t, " x ", rail + shelf_t));

// Frame: rail along X, its outer side face at y = 0 (rail spans y 0..20),
// its underside at z = 0 (rail spans z 0..20).
module profile() {
    offset(r=edge_r) offset(delta=-edge_r) union() {
        translate([-plate_t, -shelf_t]) square([plate_t, shelf_t + rail]);     // side plate
        translate([-plate_t, -shelf_t]) square([plate_t + rail, shelf_t]);     // shelf
    }
}
module key_profile() {   // YZ, on the shelf, centred on the slot
    polygon([[-key_w/2, -0.01], [key_w/2, -0.01], [key_w/2, key_h - key_c], [key_w/2 - key_c, key_h],
             [-key_w/2 + key_c, key_h], [-key_w/2, key_h - key_c]]);
}
module camera_mount() {
    difference() {
        union() {
            translate([len/2, 0, 0]) rotate([90,0,-90]) mirror([1,0,0]) linear_extrude(len) profile();
            for(x=[-len/2, key_gap/2]) translate([x, rail/2, 0]) rotate([90,0,90]) linear_extrude(len/2 - key_gap/2) key_profile();
        }
        translate([0, 1, rail/2]) rotate([90,0,0]) cylinder(h=plate_t + 2, d=m5_clear, $fn=32);
        translate([0, rail/2, -shelf_t - 1]) cylinder(h=shelf_t + 2, d=tap_d, $fn=32);
        // lead-in for the tap, underneath
        translate([0, rail/2, -shelf_t - 0.01]) cylinder(h=1, d1=tap_d + 2, d2=tap_d, $fn=32);
    }
}

// Slide. Frame: rail along X, centred on y = 0, its underside at z = 0.
module slide_profile() {   // YZ
    polygon([[-block_w/2 + block_c, -block_h], [block_w/2 - block_c, -block_h], [block_w/2, -block_h + block_c],
             [block_w/2, 0], [stem_w/2, 0], [stem_w/2, lip_t + head_clr], [head_w/2, lip_t + head_clr],
             [head_w/2, knee_z], [head_bot/2, head_z], [-head_bot/2, head_z], [-head_w/2, knee_z],
             [-head_w/2, lip_t + head_clr], [-stem_w/2, lip_t + head_clr], [-stem_w/2, 0], [-block_w/2, 0],
             [-block_w/2, -block_h + block_c]]);
}
module camera_slide() {
    difference() {
        translate([-len/2, 0, 0]) rotate([90,0,90]) linear_extrude(len) slide_profile();
        translate([0, 0, -block_h - 1]) cylinder(h=tap_depth + 1, d=tap_d, $fn=32);
        translate([0, 0, -block_h - 0.01]) cylinder(h=1, d1=tap_d + 2, d2=tap_d, $fn=32);
    }
}
module mount() { if(style == "slide") camera_slide(); else camera_mount(); }

if(print_flip) translate([0, 0, len/2]) rotate([0,-90,0]) mount();
else mount();

if(show_context && !print_flip)
    %color([0.66,0.71,0.75]) translate([-60, style == "slide" ? -rail/2 : 0, 0]) cube([120, rail, rail]);
