// Z-spine base: sits on the turntable bearing, carries the vertical 2020 rail.
// Printed. Millimetres. Print flat, socket upward: no supports, and the layers
// then lie normal to the socket's hoop loads.
//
// WHICH RACE DOES THIS BOLT TO?  -> the INNER one.
//   captures/2026-09-13 zoom on the race boundary shows countersinks on the
//   OUTER ring and plain holes on the inner. A countersink seen from above
//   takes a flat head driven downward, into whatever sits below — so the outer
//   ring is what screws down to the desk, and the inner ring rotates and
//   carries this part. Standard lazy-susan practice.
//
//   This is NOT a two-number swap. The underside relief has to move with it:
//   the plate must bear on its mounting race and clear the other one, so
//   mounting inboard means relieving OUTBOARD. `mount_race` drives the bolt
//   circle, the access circle and the relief annulus together.

use <vslot-2020.scad>
use <turntable-bearing.scad>

/* [Variant] */
// full : the truncated cone to the socket mouth. Stiffest, and about 4 h to print.
// fast : same bearing and rail interfaces, printed in a fraction of the time.
//        The socket stands as an exposed square boss on a short flared foot, and
//        the disc becomes a hub with four arms out to the screws.
// fins : the fast plate and boss, lighter again. The flared foot is replaced by
//        four gusset fins, the socket floor is cut out so the rail passes clean
//        through, and the boss is turned 45 deg so its corners point down the
//        arms: each fin runs from a corner out along an arm, and the tee windows
//        on the faces are left alone. The rail is then located by its tee bolts
//        only, and can drop on through the bearing bore if wanted.
// The default here is what the GUI opens; export the others with -D variant=... .
// All keep every assert below.
variant         = "fins";   // [full, fast, fins]
fast            = (variant == "fast");
fins            = (variant == "fins");
exposed         = fast || fins;   // the boss stands open, not buried in the cone

/* [Bearing interface - verify against the real part] */
bearing_od      = 140;   // measured by hand
bearing_bore    = 87;    // photo estimate
race_boundary   = 113;   // photo estimate of 114, taken 1 mm small to be safe
mount_race      = "inner";  // [inner, outer]
outer_pcd       = 128;   // photo estimate
inner_pcd       = 102;   // photo estimate
// The bearing's own holes are sized for wood screws and loosely placed — on the
// real part an M4 passes freely through some and has to tap its way into others.
// So these screws CLAMP rather than LOCATE, and the float lives in the bearing's
// holes, not here. Screws go UP from below, through the inner ring, and self-tap
// into this plate: a pilot, not a clearance hole. The 2.18 N.m only needs about
// 21 N per screw, trivial for 6 mm of thread in plastic. Washer under each head.
//
// Nothing then sets concentricity, so the base can sit up to ~1 mm off centre.
// That is harmless here: the spine's axis shifts by 1 mm, the camera sweeps a
// slightly eccentric arc, and the mat fiducials solve pose per frame regardless.
mount_hole      = 3.5;   // M4 self-tapping pilot, through the plate
access_hole     = 9.0;   // screwdriver clearance (outer mount only)

mounts_inner    = (mount_race == "inner");
mount_pcd       = mounts_inner ? inner_pcd : outer_pcd;
access_pcd      = mounts_inner ? outer_pcd : inner_pcd;
// Relieve whichever race this part does NOT bolt to.
relief_id       = mounts_inner ? race_boundary + 2 : bearing_bore;
relief_od       = mounts_inner ? bearing_od + 2    : race_boundary - 2;

/* [Plate] */
// Mounted on the inner race, the plate stops short of the outer one instead of
// covering it. That saves print time and deletes both the access holes and the
// underside relief: the outer race's desk screws are simply in the open. The
// gap is on the race boundary, which is still a photo estimate — if the real
// boundary is smaller, the plate's rim rubs the outer race as it turns.
race_gap        = 1.0;   // radial, plate rim to race boundary
mount_edge_min  = 2.5;   // plastic left outboard of each pilot: 2.75 as built
plate_d         = mounts_inner ? race_boundary - 2*race_gap : bearing_od;
plate_t         = 6;
inner_relief    = 1.0;   // outer mount only: recess so the inner race is not borne on

/* [Rail socket] */
rail            = 20;
// Per side. From the 2026-09-13 fit gauge: 0.45 slid on easily, 0.30 went on hard
// at only 2 mm deep and would bind at 45. Split the difference: the tee bolts
// locate the rail, but a snugger guide leaves less lean to square out by hand.
socket_fit      = 0.375;
socket_h        = 38;    // grip length up the rail: frugal, it is also the stack's travel
socket_wall     = 5.8;
// Fins only: the through pocket ends in a flat ledge at the underside, ledge_w
// in from the pocket wall and ledge_t thick, for the rail's end to sit on.
ledge_w         = 2;
ledge_t         = 2;
// Fins only: chamfer on the boss's top outer edge.
boss_chamfer    = 1.5;

/* [Fixings and routing] */
// No central screw into the rail's tapped end bore: its head counterbore (Ø9.5,
// so reaching y = -4.75) collides with the rear slot channel the balance line
// must pass through (y = -3.9 to -8.2). The rail is held instead by four M5
// bolts into drop-in tee nuts in its side slots, at two heights, which resists
// the tipping moment as a couple rather than as clamp friction on a plastic floor.
tee_head_d      = 9.26;  // the screw head, measured: an M5 button head
tee_head        = tee_head_d + 1.2;   // its counterbore, 0.6 mm a side for the print
tee_head_sink   = 2;     // measured from 1 mm proud of the boss face: 1 mm into it
tee_screw_len   = 10;    // M5 socket head, length under the head. The sink is
                         // sized to this: 1 mm suits a 10, 3 mm would suit an 8.
tee_nut_min     = 2.5;   // thread the screw must reach past the slot lip
// Drop-in tee nuts, 20-series M5, measured 9.85 x 5.9 mm. Three ways in:
//  round   : plain Ø5.5 hole. Nuts are loaded into the slot before the rail
//            goes in and found blind. Full seat for the head. Fine on a short
//            test piece, a fight on a 500 mm rail waving about.
//  window  : the hole is a window the nut passes through, long side up the
//            slot, with the rail clamped. The head loses its full seat and
//            bears on the two strips beside the window.
//  keyhole : a window beside the hole, joined to it by a shank-wide slot.
//            Start the screw in the nut, feed the nut through the window into
//            the rail slot, slide the screw along until the head drops into
//            its counterbore. The nut rides captive on the screw, and the head
//            seats on a ring open only on the slot side. "drop" puts the
//            window above each hole, "lift" below; "shared" puts ONE window
//            midway between two stations, slotted down to the lower hole and
//            up to the upper, so the pair fits a 45 socket.
// Auto: windows where the rail is captive (full, fast), keyhole on fins.
tee_entry       = "auto";   // [auto, window, round, keyhole]
keyhole_dir     = "shared"; // [drop, lift, shared]
tee_bolt        = 5.5;   // round hole: M5 clearance
tee_nut_l       = 9.85;  // along the slot, measured
tee_nut_w       = 5.9;   // across the slot, measured; the rail's throat is 6.25
tee_win_clr     = 0.4;   // per side, printed clearance around the nut
tee_win_r       = 0.5;   // window corner radius, under the nut's own corners
tee_seat_min    = 0.75;  // head bearing strip beside the window, each side
// Fins clamps from one face only, pulling the rail onto the opposite wall: a
// datum, rather than two sides fighting over the clearance.
tee_sides       = fins ? [1] : [-1, 1];   // local +X face, or both
tee_access      = 12;    // full only: bore through the cone flank, which the nut must pass
tee_win_h       = tee_nut_l + 2*tee_win_clr;
tee_win_w       = tee_nut_w + 2*tee_win_clr;
tee_entry_r     = tee_entry == "auto" ? (fins ? "keyhole" : "window") : tee_entry;
tee_window      = tee_entry_r == "window";
tee_keyhole     = tee_entry_r == "keyhole";
keyhole_lift    = keyhole_dir == "lift";
keyhole_shared  = keyhole_dir == "shared";
// Keyhole: the window sits just clear of the counterbore, so the head's seat
// is cut only by the slot.
keyhole_rise    = tee_head/2 + tee_win_h/2;      // hole centre to window centre
keyhole_top     = keyhole_rise + tee_win_h/2;    // hole centre to window top
tee_cut_h       = tee_window ? tee_win_h : tee_bolt;   // hole extent up the wall, symmetric part
// Full: both pairs inside the cone, reached through bores in its flank.
// Fast: raised clear of the short foot, so the heads sit on the open boss face.
// Fins: two pairs spread as far as the shared window between them allows,
//       with a few mm of wall left above the upper counterbore.
tee_heights     = fins ? [8, 30] : fast ? [20, 38] : [14, 34];   // above the plate top; fins as low and close as the keyhole allows
// Declared after tee_heights on purpose: a forward reference here would be undef.
keyhole_mid     = (min(tee_heights) + max(tee_heights)) / 2;   // shared window centre
line_hole       = 4;     // balance line, straight down the rail's rear slot
line_y          = 6.05;  // REAR slot (+Y): the run that descends to the counterweight.
                         // Channel spans |y| = 3.9 .. 8.2; sign only picks the slot.

/* [Cone] */
// A truncated cone from plate to the top of the socket replaces the eight ribs.
// Its flat top is flush with the socket mouth and a little wider than the boss's
// corner diagonal, so the square boss is swallowed whole and the rail rises out
// of a plain round face. It narrows upward, so it prints without supports. The
// foot stays inside the mount screws, whose tips come up through the plate.
cone_d          = 88;    // foot, on the plate top
cone_top_margin = 5;     // flat top diameter over the boss's corner diagonal

/* [Edges] */
// Every edge of the revolved body is broken. Rims are chamfered, where a print
// holds a 45 deg edge cleanly. The cone's foot is filleted, because that inside
// corner is where the tipping moment concentrates. Its top edge is rounded.
rim_chamfer_top = 1.0;
rim_chamfer_bot = 0.5;   // also clears elephant's foot on the bed face
foot_fillet     = 4;
top_round       = 2;
mouth_chamfer   = 1.0;   // lead-in on the rail socket
pilot_chamfer   = 0.5;   // lead-in for the self-tappers, on the underside
fillet_fn       = 12;    // segments per fillet arc

/* [Fast variant] */
fast_hub_d      = 70;    // central disc under the boss
fast_arm_w      = 12;    // arm width where it leaves the hub
fast_lug_r      = 4.5;   // round lug around each screw; reaches the plate rim
fast_web_round  = 3;     // fillet where arms meet the hub
fast_foot_h     = 12;    // flared foot from hub to boss corners
fast_foot_d     = 64;    // foot diameter on the plate top

/* [Fins variant] */
fin_t           = 2.4;   // fin thickness: six 0.4 mm perimeters
fin_h           = 30;    // height up the boss corner
fin_reach       = 44;    // out along the arm from the axis, short of the lug
boss_turn       = 45;    // boss rotation about Z, so corners point down the arms
// The load stack's two guide lines are one loop: down from the spine cap's
// rear anchors, round a short square U on the boss's rear face, back up. One
// thing to tension, at the cap's M2 clamps. The rear face is the utility face:
// the tee bolts are on it too (tee_on_rear). The groove is a T in section, a
// narrow mouth over a wider channel, so a thin line presses in and cannot come
// back out under tension. Positions match spine-cap.scad and load-stack.scad.
tee_on_rear     = true;  // fins: tee bolts on the boss's local +Y face, with the U
guide_x         = 7.5;   // either side of the rail centre: legs clear the bolt heads by 1.4
guide_y         = 15;    // behind the rail centre: inside the boss wall, so grooved
guide_leg_to_window = true;   // the bar crosses at the nut window: the line spans it in air
guide_mouth_w   = 1.2;   // at the face
guide_mouth_d   = 1.0;
guide_chan_w    = 1.8;   // behind the mouth: the hook
guide_chan_d    = 1.2;

/* [Display] */
show_context    = false; // add bearing + rail stub for a fit check
section_view    = false;

socket_in = rail + 2*socket_fit;
boss      = socket_in + 2*socket_wall;
// Declared here, not with the other cone settings: they depend on `boss`, and
// OpenSCAD resolves a forward reference to undef without complaint.
boss_diag  = (boss-4)*sqrt(2) + 4;          // corner to corner, r=2 corners
cone_top_d = boss_diag + cone_top_margin;
cone_h     = socket_h;                      // flush with the socket mouth

// Arc joining two straight edges that meet at `c`. u1 points from the corner back
// along the incoming edge, u2 along the outgoing one. Works for inside and
// outside corners alike, since the centre always lies on the bisector.
function _unit(v) = v / norm(v);
function _ang(v)  = atan2(v[1], v[0]);
function fillet_pts(c, u1, u2, r, n=fillet_fn) =
    let(a1  = _unit(u1), a2 = _unit(u2),
        phi = acos(a1*a2),
        d   = r / tan(phi/2),
        ctr = c + _unit(a1+a2) * (r / sin(phi/2)),
        p1  = c + a1*d, p2 = c + a2*d,
        s1  = _ang(p1-ctr), s2 = _ang(p2-ctr),
        sw  = let(x = s2 - s1) x > 180 ? x - 360 : (x < -180 ? x + 360 : x))
    [for(i=[0:n]) ctr + r*[cos(s1 + sw*i/n), sin(s1 + sw*i/n)]];

// Half-profile of plate and cone together, revolved about Z.
function body_profile() =
    let(R  = plate_d/2, T = plate_t, H = plate_t + cone_h,
        Rf = cone_d/2, Rt = cone_top_d/2,
        foot = [Rf, T], top = [Rt, H])
    concat(
        [[0, 0], [R - rim_chamfer_bot, 0], [R, rim_chamfer_bot],
         [R, T - rim_chamfer_top], [R - rim_chamfer_top, T]],
        fillet_pts(foot, [1, 0], top - foot, foot_fillet),
        fillet_pts(top, foot - top, [-1, 0], top_round),
        [[0, H]]);

// Clearances that must hold for the part to be buildable at all.
assert(mount_pcd + mount_hole < plate_d, "mount circle runs off the plate");
assert(relief_id < relief_od, "relief annulus is inside out");
assert(mounts_inner
       ? (mount_pcd + mount_hole < race_boundary && mount_pcd - mount_hole > bearing_bore)
       : (mount_pcd - mount_hole > race_boundary),
       "bolt circle does not land on the race it is meant to bolt to");
assert(mounts_inner || access_pcd + access_hole < plate_d, "access holes run off the plate");
assert(plate_d/2 - (mount_pcd/2 + mount_hole/2) >= mount_edge_min,
       "too little plastic outboard of the mount pilots");
// The line must stay inside the rail's rear slot channel, not foul its walls.
slot_floor    = 10 - 1.80 - 4.30;   // 3.90 from the drawing
slot_shoulder = 10 - 1.80;          // 8.20
assert(abs(line_y) - line_hole/2 >= slot_floor, "line hole cuts into the rail's slot floor");
assert(abs(line_y) + line_hole/2 <= slot_shoulder, "line hole runs past the slot shoulder");
assert(max(tee_heights) + max(tee_head, tee_cut_h)/2 < socket_h, "tee bolt runs off the top of the socket");
assert(!tee_keyhole || exposed, "keyhole needs an open boss face");
assert(!tee_keyhole || max(tee_heights) + (keyhole_lift || keyhole_shared ? tee_head/2 : keyhole_top) < socket_h - mouth_chamfer,
       "keyhole runs into the socket mouth");
assert(!tee_keyhole || min(tee_heights) - (keyhole_lift ? keyhole_top : tee_head/2) >= 1,
       "keyhole runs into the plate");
assert(!tee_keyhole || keyhole_shared || len(tee_heights) < 2
       || min([for(i=[1:len(tee_heights)-1]) tee_heights[i] - tee_heights[i-1]]) > keyhole_top + tee_head/2,
       "keyhole window runs into the next station's counterbore");
assert(!(tee_keyhole && keyhole_shared) || len(tee_heights) == 2, "shared keyhole needs exactly two stations");
assert(!(tee_keyhole && keyhole_shared) || max(tee_heights) - min(tee_heights) >= tee_win_h + tee_head,
       "shared keyhole window runs into a counterbore");
assert(!tee_window || (tee_head_d - tee_win_w)/2 >= tee_seat_min, "tee window leaves the head no seat");
assert(!tee_window || (tee_win_w > tee_nut_w && tee_win_h > tee_nut_l), "tee window smaller than the nut");
assert(exposed || !tee_window || tee_access >= tee_win_h + 1, "full: nut cannot pass the cone flank bore");
assert(exposed || tee_access >= tee_head + 1, "full: head cannot pass the cone flank bore");
// Screw stack from under the head: plastic left under the counterbore, the fit
// gap, then the slot lip. What is left of the screw goes into the tee nut, and
// must not reach the channel floor behind it (4.30 deep at the slot centre).
tee_under_head = socket_wall - (tee_head_sink - 1);
tee_past_lip   = tee_screw_len - (tee_under_head + socket_fit + 1.80);
assert(tee_past_lip >= tee_nut_min, "tee screw too short to engage the nut");
assert(tee_past_lip <= 4.30 - 0.8, "tee screw bottoms in the slot channel before it clamps");
assert(cone_d/2 + 2 <= mount_pcd/2 - mount_hole/2, "cone foot covers the mount screw tips");
assert(mounts_inner || cone_d/2 + 2 <= access_pcd/2 - access_hole/2, "cone foot blocks the access holes");
assert(cone_top_d > boss_diag, "boss corners break through the cone's flat top");
assert(cone_top_d < cone_d, "cone is not truncated");
assert(cone_d/2 + foot_fillet < plate_d/2 - rim_chamfer_top, "foot fillet runs into the rim chamfer");
assert(!exposed || mount_pcd/2 + fast_lug_r <= plate_d/2, "fast: screw lugs run past the plate rim");
assert(!fast || fast_foot_d <= fast_hub_d, "fast: foot overhangs the hub");
assert(!fast || fast_foot_d/2 > boss_diag/2, "fast: foot is inside the boss corners");
// The foot covers the boss faces up to fast_foot_h; tee heads must start above it.
assert(!fast || min(tee_heights) - max(tee_head, tee_cut_h)/2 >= fast_foot_h + 1, "fast: foot buries the lower tee heads");
assert(!fins || fin_reach <= mount_pcd/2 - fast_lug_r, "fins: fin runs onto the screw lug");
assert(!fins || fin_h < socket_h, "fins: fin taller than the socket");
assert(!fins || fin_t <= fast_arm_w - 2*rim_chamfer_top, "fins: fin wider than the arm's flat top");
assert(!fins || ledge_w > (socket_in - rail)/2 + 0.5, "fins: ledge too narrow to catch the rail");
assert(!fins || abs(line_y) + line_hole/2 <= socket_in/2 - ledge_w, "fins: ledge closes the balance line's way out");
assert(!fins || boss_chamfer + mouth_chamfer + 0.6 < socket_wall, "fins: top chamfers meet across the wall");

// Accessors, so the assembly need not restate this part's internals.
function zbase_plate_d()   = plate_d;
function zbase_plate_t()   = plate_t;
// Rail bottom above the plate underside: the socket floor, or the ledge.
function zbase_rail_seat() = fins ? ledge_t : plate_t + 2;
function zbase_height()    = plate_t + socket_h;
function zbase_line_y()    = line_y;
function zbase_line_hole() = line_hole;

module z_base() {
    if(fins) z_base_fins(); else if(fast) z_base_fast(); else z_base_full();
}

// Pocket outline, grown by d a side.
module pocket_2d(d=0) { offset(r=0.6,$fn=24) square(socket_in-1.2+2*d, center=true); }

// Rail pocket with its lead-in, shared by the variants. `through` drops the
// floor: the pocket then runs out the underside through the ledge, whose
// underside is at ledge_z.
module rail_pocket(through=false, ledge_z=0) {
    if(through) {
        translate([0,0,ledge_z-1]) linear_extrude(ledge_t+1.01) pocket_2d(-ledge_w);
        translate([0,0,ledge_z+ledge_t]) linear_extrude(plate_t+socket_h+2) pocket_2d();
    } else
        translate([0,0,plate_t+2]) linear_extrude(socket_h+1) pocket_2d();
    translate([0,0,plate_t+socket_h-mouth_chamfer])
        hull() {
            linear_extrude(0.01) offset(r=0.6,$fn=24) square(socket_in-1.2, center=true);
            translate([0,0,mouth_chamfer+0.01]) linear_extrude(0.5)
                offset(r=0.6+mouth_chamfer,$fn=24) square(socket_in-1.2, center=true);
        }
}

module mount_pilots() {
    for(a=[0:90:270]) rotate([0,0,a]) translate([mount_pcd/2,0,-0.1]) {
        cylinder(h=plate_t+0.2, d=mount_hole, $fn=32);
        cylinder(h=pilot_chamfer+0.1, d1=mount_hole+2*(pilot_chamfer+0.1), d2=mount_hole, $fn=32);
    }
}

// Nut window outline in the wall plane: first axis up the slot, second across.
module tee_window_2d() {
    offset(r=tee_win_r, $fn=16)
        square([tee_win_h-2*tee_win_r, tee_win_w-2*tee_win_r], center=true);
}

// Bolt hole through one socket wall at each tee bolt station, from just inside
// the pocket to just outside the boss face. After rotate([0,90,0]) the 2D
// x axis runs DOWN the wall, so "above the hole" is negative x here.
module tee_holes(heights=tee_heights) {
    for(sx=tee_sides, z=heights)
        translate([sx*(socket_in/2 + socket_wall/2), 0, plate_t+z])
            rotate([0,90,0]) linear_extrude(socket_wall+2, center=true)
                if(tee_window) tee_window_2d();
                else if(tee_keyhole)
                    // window offset up the wall from this hole; local x runs down
                    let(up = keyhole_shared ? keyhole_mid - z : keyhole_lift ? -keyhole_rise : keyhole_rise) {
                        circle(d=tee_bolt, $fn=32);
                        translate([min(0, -up), -tee_bolt/2]) square([abs(up), tee_bolt]);
                        translate([-up, 0]) tee_window_2d();
                    }
                else circle(d=tee_bolt, $fn=32);
}

module line_hole_cut() {
    translate([0,0,-0.1]) translate([0,line_y,0])
        cylinder(h=plate_t+socket_h+1, d=line_hole, $fn=48);
}

// Hub, four arms and screw lugs. Arms sit on the screw angles.
module fast_plate_2d() {
    offset(r=fast_web_round,$fn=24) offset(delta=-fast_web_round) {
        circle(d=fast_hub_d, $fn=120);
        for(a=[0:90:270]) rotate(a) hull() {
            translate([fast_hub_d/2 - fast_arm_w, 0]) circle(d=fast_arm_w, $fn=32);
            translate([mount_pcd/2, 0]) circle(r=fast_lug_r, $fn=40);
        }
    }
}

module z_base_fast() {
    difference() {
        union() {
            // plate: chamfered top edge by stacking a slightly inset top layer
            linear_extrude(plate_t - rim_chamfer_top) fast_plate_2d();
            translate([0,0,plate_t - rim_chamfer_top - 0.01])
                roof_chamfer(rim_chamfer_top) fast_plate_2d();
            boss_body();
            // short flared foot, filleted into the plate
            translate([0,0,plate_t-0.01])
                rotate_extrude($fn=120) polygon(concat(
                    [[0,0]],
                    fillet_pts([fast_foot_d/2,0], [1,0],
                               [boss_diag/2 - fast_foot_d/2, fast_foot_h], foot_fillet),
                    [[boss_diag/2, fast_foot_h], [0, fast_foot_h]]));
        }
        rail_pocket();
        // nut windows through the open boss face, heads counterbored as in full
        tee_holes();
        tee_counterbores();
        line_hole_cut();
        mount_pilots();
        if(section_view) translate([-plate_d,0,-1])
            cube([2*plate_d, plate_d, plate_t+socket_h+2]);
    }
}

// Exposed square boss, shared by fast and fins; fins chamfers its top edge.
module boss_2d(d=0) { offset(r=2,$fn=24) square(boss-4+2*d, center=true); }
module boss_body() {
    c = fins ? boss_chamfer : 0;
    translate([0,0,plate_t-0.01]) {
        linear_extrude(socket_h+0.01-c) boss_2d();
        translate([0,0,socket_h-c]) hull() {
            linear_extrude(0.01) boss_2d();
            translate([0,0,c]) linear_extrude(0.01) boss_2d(-c);
        }
    }
}

// Square U groove for the guide line loop, on the boss's local +Y (rear) face:
// two legs down from the top, past the upper bolt head, to a bar at the nut
// window's height, so the line spans the open window. The socket is then only
// as tall as the upper bolt needs. T in section: mouth, then channel.
guide_bar_z = plate_t + keyhole_mid;
guide_top   = plate_t + socket_h + 1;
assert(guide_mouth_d + guide_chan_d <= socket_wall - 1.5, "guide groove through the boss wall");
assert(guide_x - guide_chan_w/2 - tee_head/2 >= 1, "guide legs into the tee counterbores");
assert(plate_t + socket_h - (plate_t + max(tee_heights) + tee_head/2) >= 2, "socket too short over the upper bolt head");
module guide_u_2d(w) {   // XZ, absolute z
    for(sx=[-1,1]) translate([sx*guide_x - w/2, guide_bar_z]) square([w, guide_top - guide_bar_z]);
    translate([-guide_x, guide_bar_z - w/2]) square([2*guide_x, w]);
}
module guide_groove() {
    translate([0, boss/2 + 1, 0]) rotate([90,0,0]) {
        linear_extrude(1 + guide_mouth_d) guide_u_2d(guide_mouth_w);
        translate([0,0,1 + guide_mouth_d - 0.01]) linear_extrude(guide_chan_d + 0.01) guide_u_2d(guide_chan_w);
    }
}

// Head counterbores into the open boss face, shared by fast and fins.
module tee_counterbores(heights=tee_heights) {
    for(sx=tee_sides, z=heights)
        translate([sx*(boss/2+1), 0, plate_t+z]) rotate([0,-sx*90,0])
            translate([0,0,-2]) cylinder(h=2+tee_head_sink, d=tee_head, $fn=32);
}

// One gusset fin in the XZ plane: rooted inside the boss, fin_h up its corner,
// tapering to the plate top at fin_reach. Its slope retreats towards the boss
// as it rises, so it prints without support.
module fin() {
    rotate([90,0,0]) linear_extrude(fin_t, center=true)
        polygon([[boss/2 - 2, plate_t - 0.01], [fin_reach, plate_t - 0.01],
                 [boss/2 - 2, plate_t + fin_h]]);
}

module z_base_fins() {
    difference() {
        union() {
            linear_extrude(plate_t - rim_chamfer_top) fast_plate_2d();
            translate([0,0,plate_t - rim_chamfer_top - 0.01])
                roof_chamfer(rim_chamfer_top) fast_plate_2d();
            rotate(boss_turn) boss_body();
            for(a=[0:90:270]) rotate(a) fin();
        }
        rotate(boss_turn) {
            rail_pocket(through=true);
            rotate(tee_on_rear ? 90 : 0) { tee_holes(); tee_counterbores(); }
            guide_groove();
        }
        mount_pilots();
        if(section_view) translate([-plate_d,0,-1])
            cube([2*plate_d, plate_d, plate_t+socket_h+2]);
    }
}

// A 45 deg chamfer band of height h on top of a 2D outline, in steps finer than
// a layer. Not a hull: the fast plate's outline is concave between the arms.
module roof_chamfer(h, steps=5) {
    for(i=[0:steps-1])
        translate([0,0,i*h/steps]) linear_extrude(h/steps + 0.01)
            offset(delta=-(i+0.5)*h/steps) children();
}

module z_base_full() {
    difference() {
        // Plate and truncated cone as one revolved profile. The square boss the
        // cone used to sit on is wholly inside it now, so it is not modelled.
        rotate_extrude($fn=160) polygon(body_profile());

        // rail pocket, with a lead-in chamfer at the mouth
        translate([0,0,plate_t+2])
            linear_extrude(socket_h+1)
                offset(r=0.6,$fn=24) square(socket_in-1.2, center=true);
        translate([0,0,plate_t+socket_h-mouth_chamfer])
            hull() {
                linear_extrude(0.01) offset(r=0.6,$fn=24) square(socket_in-1.2, center=true);
                translate([0,0,mouth_chamfer+0.01]) linear_extrude(0.5)
                    offset(r=0.6+mouth_chamfer,$fn=24) square(socket_in-1.2, center=true);
            }

        // rail hold-down: M5 x 8 into drop-in tee nuts, both side slots, two heights.
        // The cone buries both pairs, so each station is reached by a bore out
        // through the flank, wide enough to pass the nut on its way to the window
        // and then the screw and a hex key. It stops tee_head_sink into the wall,
        // so its floor is the head's seat.
        tee_holes();
        for(sx=[-1,1], z=tee_heights)
            translate([sx*(boss/2+1), 0, plate_t+z]) rotate([0,-sx*90,0])
                translate([0,0,-cone_d/2]) cylinder(h=cone_d/2+tee_head_sink, d=tee_access, $fn=48);

        // balance line, straight through
        translate([0,line_y,-0.1])
            cylinder(h=plate_t+socket_h+1, d=line_hole, $fn=48);

        // self-tapping pilots for screws up through the mounting race
        for(a=[0:90:270]) rotate([0,0,a]) translate([mount_pcd/2,0,-0.1]) {
            cylinder(h=plate_t+0.2, d=mount_hole, $fn=32);
            cylinder(h=pilot_chamfer+0.1, d1=mount_hole+2*(pilot_chamfer+0.1), d2=mount_hole, $fn=32);
        }

        // Outer mount only: the plate then covers the inner race, so reach its
        // screws through access holes and relieve the underside off it. An
        // inner-mounted plate stops short of the outer race and needs neither.
        if(!mounts_inner) {
            for(a=[45:90:315]) rotate([0,0,a]) translate([access_pcd/2,0,-0.1])
                cylinder(h=plate_t+0.2, d=access_hole, $fn=32);
            translate([0,0,-0.01]) difference() {
                cylinder(h=inner_relief, d=relief_od, $fn=180);
                translate([0,0,-0.1]) cylinder(h=inner_relief+0.2, d=relief_id, $fn=160);
            }
        }

        if(section_view) translate([-plate_d,0,-1])
            cube([2*plate_d, plate_d, plate_t+socket_h+2]);
    }
}

z_base();

if(show_context) {
    // Inner ring turned so its holes sit under the pilots; it rotates freely.
    translate([0,0,-8.5]) turntable_bearing(angle=0);
    color([0.7,0.75,0.8,0.45]) translate([0,0,plate_t+2])
        linear_extrude(120) vslot_2020_profile();
}
