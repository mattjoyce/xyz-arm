// V base: two 300 mm 2020 rails flat on the desk, joined at a right angle by
// Matt's 90 degree brackets, opening toward the work (Matt, 2026-09-20). It
// replaces the weighted base, which failed on the bench: 2 mm of printed
// plastic in bending, above the iron and below it (README iteration 43). The
// rule here is that everything between the bearing's outer race and the desk
// is stiff and in compression. The rails are the structure; what is printed
// is small and only ever squeezed or pulled.
//
// Matt's scheme: blocks like the camera mount, a T slider with a hole, slid
// along the rails' TOP slots until they sit under the outer race's holes, and
// the race's M4s go down into them.
//
// Where the bearing goes. The race's four holes are a 90.5 mm square (128
// PCD). On an L of two rails, three of them can lie on slot lines: two on
// one rail and one on the other, with the square's corner hole nearest the
// L's corner. That puts the spine 78 mm out from the corner along the
// diagonal, inside the V. The fourth hole, the one toward the work, is over
// bare desk, and it is the one that matters: tipping forward presses the
// front of the race DOWN. So it gets a FOOT, a printed pillar from the desk
// to the race, in plain compression. The three blocks then only hold the
// race down; the rear one sees about 28 N of pull at full reach.
//
// The blocks stand the race `spacer` above the rails. It cannot sit on them:
// the inner race turns, and the heads of the base's bolts hang under it.
//
// BLOCK: a 20 x 20 pad, `spacer` thick, on top of the rail, with the T
// under it in the slot. The T is load-stack.scad's slider section, numbers
// copied as frozen from what printed. Ø3.5 pilot right through for an M4 to
// tap: it takes 3.5 out of a 5.5 stem, but only over the hole's own length,
// and the stem is whole either side of it. Printed standing on the profile:
// no overhang, and the pull on the T runs in the layers, not across them.
//
// ANGLE (block_style = "angle", the default; Matt, 2026-09-21): the blocks
// are better as right angles on tee nuts, since they will not be moved. The
// same 20 x 20 pad on top of the rail, and a leg down the rail's OUTER side
// face with one M5 x 10 into a drop-in tee nut. So each bracket is fixed to
// its rail and nothing relies on a printed T under printed lips: the rear
// bracket's 28 N of lift goes pad, corner, leg, M5, nut. A low rib under the
// pad drops into the slot's opening, which squares the bracket to the rail
// and gives the M4 another 1.6 of plastic. It goes on from above, no sliding
// in from the rail's end. "slide" keeps the T block.
//
// FOOT: a round pillar, rail + spacer tall, with the same pilot. Printed as
// it stands.
part        = "layout";  // [layout, block, foot]
rail        = 20;
rail_len    = 300;
outer_pcd   = 128;       // proved on the 2026-09-13 fit gauge
bearing_od  = 140;
spacer      = 5;         // race above the rails: an M4 cap head under the inner race is 4
block_style = "angle";   // [angle, slide]
block_len   = 20;
leg_t       = 5;         // angle: leg down the rail's side
leg_short   = 2;         // angle: leg stops this far above the desk
m5_clear    = 5.3;
rib_w       = 5.6;       // angle: rib into the slot's 6.0 opening
rib_h       = 1.6;       // under a 1.8 lip
pilot       = 3.5;       // M4 self-tapping
foot_d      = 24;
foot_pilot_depth = 14;
// The slot. These rails are plain T-slot, not the V-slot the sliders were
// proved on (Matt, 2026-09-20). Generic T-slot 2020 varies most in its lips
// (1.5 to 2.3 thick) and its depth (5.35 on some), so this T is slacker than
// load-stack.scad's where slack costs nothing: lip_clr under the lips and
// floor_clr off the floor. The block is not clamped to its rail, it sits on
// it, and two blocks on one rail plus one on the other fix the race in plan;
// the slack under the lips is only how far the rear block lifts before it
// holds, 0.4 mm over 128.
slot_w      = 6.0;
lip_t       = 1.8;
chan_w      = 11;
chan_str    = 1.6;
chan_d      = 5.5;
stem_w      = slot_w - 0.5;
head_w      = chan_w - 0.6;
lip_clr     = 0.4;
floor_clr   = 0.5;
print_flip  = false;     // block only: standing on its profile
$fn = 64;

side     = outer_pcd/sqrt(2);                 // the hole square's side
knee_z   = lip_t + chan_str - 0.2;            // down into the slot
head_z   = chan_d - floor_clr;
head_bot = head_w - 2*(head_z - knee_z);
// Plan, rails' outer corner at the origin: rail A along +X (y 0..20), rail B
// along +Y (x 0..20), butted against A's side. Slot lines y = 10 and x = 10.
holes  = [[rail/2, rail/2], [rail/2 + side, rail/2], [rail/2, rail/2 + side], [rail/2 + side, rail/2 + side]];
centre = [rail/2 + side/2, rail/2 + side/2];
tipA   = [rail_len, rail/2];
tipB   = [rail/2, rail + rail_len];
// spine to the line between the rails' tips: the forward footprint
fwd    = abs((tipB[0]-tipA[0])*(tipA[1]-centre[1]) - (tipA[0]-centre[0])*(tipB[1]-tipA[1])) / norm(tipB - tipA);
echo(str("blocks on rail A at x = ", holes[0][0], " and ", holes[1][0], ", on rail B at y = ", holes[2][1],
         "; foot under the fourth hole at ", holes[3], "; spine ", norm(centre), " out from the corner"));
echo(str("blocks: ", block_style, block_style == "angle" ? str(", M4 taps ", spacer + rib_h, " of plastic, M5 x 10 leaves ", 10 - leg_t, " for the tee nut") : ""));
echo(str("forward footprint ", fwd, " mm: rig alone (2.6 kg) resists ", 2.6*9.81*fwd/1000, " N.m against about 2.1; race stands ",
         rail + spacer, " above the desk"));

module t_profile() {   // YZ, T hanging below z = 0
    polygon([[-rail/2, spacer], [rail/2, spacer], [rail/2, 0], [stem_w/2, 0], [stem_w/2, -lip_t - lip_clr],
             [head_w/2, -lip_t - lip_clr], [head_w/2, -knee_z], [head_bot/2, -head_z], [-head_bot/2, -head_z],
             [-head_w/2, -knee_z], [-head_w/2, -lip_t - lip_clr], [-stem_w/2, -lip_t - lip_clr], [-stem_w/2, 0], [-rail/2, 0]]);
}
// Angle bracket. Rail along X, top face at z = 0, outer side face at y = -rail/2.
module angle_profile() {   // YZ
    polygon([[-rail/2 - leg_t, spacer], [rail/2, spacer], [rail/2, 0], [rib_w/2, 0], [rib_w/2, -rib_h], [-rib_w/2, -rib_h],
             [-rib_w/2, 0], [-rail/2, 0], [-rail/2, -rail + leg_short], [-rail/2 - leg_t, -rail + leg_short]]);
}
module angle() {
    difference() {
        translate([-block_len/2, 0, 0]) rotate([90,0,90]) linear_extrude(block_len) angle_profile();
        translate([0, 0, -rib_h - 1]) cylinder(h=rib_h + spacer + 2, d=pilot, $fn=24);
        translate([0, -rail/2 + 1, -rail/2]) rotate([90,0,0]) cylinder(h=leg_t + 2, d=m5_clear, $fn=32);
    }
}
module block() { if(block_style == "angle") angle(); else slide_block(); }
// Slide block. Rail along X, its top face at z = 0.
module slide_block() {
    difference() {
        translate([-block_len/2, 0, 0]) rotate([90,0,90]) linear_extrude(block_len) t_profile();
        translate([0, 0, -head_z - 1]) cylinder(h=head_z + spacer + 2, d=pilot, $fn=24);
    }
}
module foot() {
    difference() {
        cylinder(h=rail + spacer, d=foot_d);
        translate([0, 0, rail + spacer - foot_pilot_depth]) cylinder(h=foot_pilot_depth + 1, d=pilot, $fn=24);
    }
}

if(part == "block") { if(print_flip) translate([0, 0, block_len/2]) rotate([0,-90,0]) block(); else block(); }
if(part == "foot")  foot();
if(part == "layout") {
    %color([0.66,0.71,0.75]) { cube([rail_len, rail, rail]); translate([0, rail, 0]) cube([rail, rail_len, rail]); }
    for(i=[0:1]) translate([holes[i][0], holes[i][1], rail]) block();
    translate([holes[2][0], holes[2][1], rail]) rotate([0,0,-90]) block();   // leg on rail B's outer face, x = 0
    translate([holes[3][0], holes[3][1], 0]) foot();
    %color([0.8,0.8,0.82]) translate([centre[0], centre[1], rail + spacer]) difference() {
        cylinder(h=8.5, d=bearing_od);
        translate([0,0,-1]) cylinder(h=11, d=113.6);
        for(h=holes) translate([h[0] - centre[0], h[1] - centre[1], -1]) cylinder(h=11, d=5, $fn=16);
    }
}
