// Load stack, v8 (2026-09-24): with `use_washers` (the default) the master is
// a floor, a front wall and four corner posts holding a stack of 50 x 50
// square steel washers (`washer_frame`; false gives a closed box), and there
// are no cells and no lid. Sides and back are open, so a washer comes off by
// hand. The washers are Bunnings' Macsim 50 x 50 x 5 galvanised
// square washer, 79.68 g each; 13 make the 1.02 kg budget and the box takes
// 14 so the balance can be trimmed 80 g at a time. Steel washers carry about
// 2.5 times the mass per mm of height of the lead-in-epoxy block (406 g in
// 85 mm), and the four corner posts locate every washer. The box is wider
// than the rail, so it stands `nut_proud` + `nut_clr` off the rail's rear
// face: the carriage's spine wheel nuts stand about 2 mm proud of that face
// (Matt) and the stack passes them. The sliders' stems grow to suit. With
// `use_washers = false`, v7 below is unchanged.
//
// Load stack, v7: a master load on the end of the balance line, add-on cells
// on top of it, a lid on top of those, hanging directly behind the spine and
// riding its rear T-slot on two flanged sliders. No guide lines: Matt tried
// them on the rig, 2026-09-19, and no tension competes with the mass.
//
// The master is a thin sleeve round Matt's lead-in-resin block, 25 x 60 x 85
// (insert), or two side by side (insert_n = 2); use_insert = false gives a
// shot box. Every piece is an OPEN box closed by the piece above, which has
// a chamfered foot that drops into the cavity below.
//
// The rail guides the master. Its body stands 1 mm off the rail's rear face,
// and a T slider is attached straight to the front wall at the top and at the
// bottom, 5 mm tall each: a stem through the slot's 6 mm opening and a head
// in the channel behind the lips, slit down the middle so the load line runs
// straight through. Both slide in from the rail's top end, before the spine
// cap goes on. The top one overhangs the wall by 6.3 mm, so its underside is
// tapered at 45 degrees (Matt, 2026-09-20): from the wall out to the tip in y,
// and from the stem's sides out to the head's edges in x, added together, so
// every point of the underside has material within 45 degrees below it and it
// prints with no support. The taper hangs under the 5 mm that captures; it
// bears nothing. The line runs down inside the channel,
// through both slits, out under the master, along a channel in the floor's
// underside to an M2 and is clamped under its head. The master's floor is
// thick enough to hold the screw, which is the only height this costs.
//
// Default view is the pieces in a column with gaps, bottom to top: master,
// cells, lid.
part = "column";   // [column, master, cell, lid, print, stack, test, slide]
// test: one T slider on a short slab, with the line hole and the M2 clamp.
test_d     = 12;
test_w     = 20;
// slide: a T slider slide_h tall on a handle, nothing else, for the sliding
// fit up and down the channel. Prints standing, so the section is true.
slide_h    = 20;
slide_handle = 6;    // behind the front face

rail       = 20;
use_washers = true;
washer     = [50, 50, 5];    // across, deep, thick: 86 g is 4.9 of steel, so 5 is near
washer_g   = 86;             // each, weighed by Matt, 2026-09-26: Macsim M16
washer_n   = 12;             // all Bunnings had; with the bolt, 1.16 kg
washer_clr = 0.75;           // a side: hot-dip galvanising runs over size
washer_top = 1.5;            // headroom over a full stack
washer_wall = 2.4;           // six 0.4 mm perimeters: the corner posts stand alone
washer_frame = true;         // open sides and back: a front wall and four corner posts
corner_leg = 12;             // each post's legs, along each side from the inside corner
rear_posts = false;          // the corner posts away from the spine: the stem holds the washers
washer_stem = false;         // a printed stem up the middle; the bolt does it now
bolt_stem  = true;           // an M16 hex bolt, head down in a pocket in the floor, as the stem
bolt_af    = 24.11;          // head across flats, measured
bolt_head  = 10.5;
bolt_l     = 65;             // under the head
bolt_g     = 129;
bolt_fit   = 0.2;            // a side round the head, and over it
bolt_skin  = 2;              // floor under the head
stem_d     = 16.5;           // M16 washers' hole is nominally 17.5 to 18: measure
stem_chamfer = 1.5;          // lead-in at the top
nut_proud  = 2;              // carriage spine wheel nuts past the rail's rear face
nut_clr    = 2;                // clear of the nuts (Matt, 2026-09-26)
// Slot numbers as printed and proven: the master's sliders fit and slide on
// the V-slot, 2026-09-20 (Matt: a little white grease). spine-cap.scad has the
// same numbers. The datasheet's V-slot is 6.25 at the throat, 6.1 to the
// floor; the fit rides on the stem and has clearance everywhere else, so the
// difference is not material. Do not retune.
slot_w     = 6.0;    // opening at the face
lip_t      = 1.8;    // face to the underside of the lip
chan_w     = 11;     // channel width just behind the lips
chan_str   = 1.6;    // how far below the lips the channel stays full width, before it angles in at 45
chan_d     = 5.5;    // face to the floor
spine_clr  = use_washers ? nut_proud + nut_clr : 1.0;    // front face to the rail's rear face

use_insert = true;
insert     = [25, 60, 85];   // the block: across, deep, tall
insert_n   = 1;              // blocks side by side across
insert_clr = 0.3;            // total, on each of the three
shot_w     = 40;             // the shot-filled master's section instead
shot_d     = 60;
shot_h     = 80;

slider_h   = 5;      // the top slider: capture only, not a guide
slider_h_bot = 5;    // the bottom slider
top_taper  = true;   // 45 degree underside on the top slider instead of support
cell_h     = 18;
cells      = use_washers ? 0 : 2;      // in the column and stack views
lid_t      = 4;
wall       = use_washers ? washer_wall : 1.2;    // three 0.4 mm perimeters for shot
floor_t    = 1.2;    // cells
master_floor = use_washers && bolt_stem ? bolt_skin + bolt_head + bolt_fit : 6;    // the master: holds the M2, and the bolt's head
foot_h     = 1.2;    // into the cavity below; its 45 degree flare is the wall
foot_clr   = 0.15;   // a side
corner     = 2;

// The T slider.
stem_w     = slot_w - 0.5;   // through the opening, 0.25 a side
head_w     = chan_w - 0.6;   // in the channel, 0.3 a side
head_clr   = 0.2;            // under the lips, and off the floor
slider_slit = 1.0;           // down the middle of each slider, for the line
tie_y      = rail/2 + spine_clr + 3.5;     // the M2, from the rail centre, up into the master's floor
tie_x      = 3;      // off centre, clear of the slit
m2_hole    = 1.7;    // M2 forms its own thread in PLA
m2_depth   = 5.5;    // a 5 mm screw
channel_w  = 1.5;    // the line across the trap's face, hole to screw
channel_d  = 0.8;
gap        = 12;     // between pieces in the column
$fn = 48;

shot_steel = 4.6; shot_lead = 6.8;
front_y  = rail/2 + spine_clr;
stem_in  = rail/2 - lip_t - head_clr;         // stem reaches to just under the lips
knee_in  = rail/2 - lip_t - chan_str + head_clr;   // where the channel starts angling in
head_in  = rail/2 - chan_d + head_clr;        // head reaches to just off the floor
head_bot = head_w - 2*(knee_in - head_in);    // width at the bottom after the 45 degree taper
line_y   = stem_in;                           // hole centred on the junction
// The taper's height: the underside is z = (front_y - y) + max(0, |x| - stem_w/2),
// highest at the head's outer knees and at its floor corners.
taper_h  = top_taper ? max(front_y - knee_in + (head_w - stem_w)/2, front_y - head_in + (head_bot - stem_w)/2) : 0;
stack_w  = use_washers ? washer[0] + 2*washer_clr + 2*wall : use_insert ? insert_n*insert[0] + insert_clr + 2*wall : shot_w;
box_d    = use_washers ? washer[1] + 2*washer_clr + 2*wall : use_insert ? insert[1] + insert_clr + 2*wall : shot_d;
stack_d  = box_d;
master_h = use_washers ? master_floor + washer_n*washer[2] + washer_top : use_insert ? master_floor + insert[2] + insert_clr + foot_h : shot_h;
box_y    = front_y + box_d/2;
cav_w    = stack_w - 2*wall;
cav_d    = box_d - 2*wall;
master_cav = cav_w*cav_d*(master_h - master_floor - foot_h)/1000;
cell_cav   = cav_w*cav_d*(cell_h - floor_t - foot_h)/1000;
stack_h    = master_h + cells*cell_h + (use_washers ? 0 : lid_t);
if(use_washers) echo(str("washer box ", stack_w, " x ", stack_d, " x ", master_h, ", front face ", spine_clr,
         " off the rail; ", washer_n, " washers ", washer_n*washer[2], " tall, ", washer_n*washer_g/1000, " kg",
         bolt_stem ? str(", with the bolt ", (washer_n*washer_g + bolt_g)/1000, " kg; bolt ", bolt_l - washer_n*washer[2] + bolt_fit,
                         " above the top washer") : ""));
if(use_washers && bolt_stem) assert(bolt_l > washer_n*washer[2], "bolt shorter than the washer stack");
if(!use_washers) echo(str("master ", stack_w, " x ", stack_d, " x ", master_h, use_insert ? str(", round ", insert_n, " block(s)") :
         str(", ", master_cav, " cm3: ", master_cav*shot_steel, " g steel shot, ", master_cav*shot_lead, " g lead shot")));
if(!use_washers) echo(str("cell ", cell_cav, " cm3: ", cell_cav*shot_steel, " g steel shot"));
echo(str("stack ", stack_h, " mm tall with ", cells, " cells; budget about 130"));
echo(str("top slider: ", slider_h, " capturing over a ", taper_h, " taper, ", slider_h + taper_h, " tall"));
echo(str("slider: stem ", stem_w, " wide to ", stem_in, " from centre; head ", head_w, " wide to ", knee_in,
         ", then 45 in to ", head_bot, " wide at ", head_in, "; line at ", line_y, ", ", rail/2 - line_y, " inside the face"));
assert(head_bot >= 3, "slider head tapers to nothing: raise head_in or chan_str");
assert(tie_y - m2_hole/2 >= front_y, "M2 in front of the master");
assert(master_floor >= m2_depth + 0.5, "master floor too thin for the M2");
assert(foot_h <= wall, "foot flare steeper than 45 degrees");
assert(cell_h >= floor_t + foot_h + 4, "cell too thin to hold anything");

module rbox(w, d, h, r) { linear_extrude(h) offset(r=r, $fn=24) square([w - 2*r, d - 2*r], center=true); }
module cavity(h, f=floor_t) { translate([0, box_y, f]) rbox(cav_w, cav_d, h, max(corner - wall, 0.5)); }
module foot() {
    translate([0, box_y, 0]) hull() {
        translate([0,0,-foot_h]) rbox(cav_w - 2*foot_clr, cav_d - 2*foot_clr, 0.01, max(corner - wall, 0.5));
        rbox(stack_w, box_d, 0.01, corner);
    }
}
// The T slider, height h: stem from the front face in to under the lips, a
// head full width for the channel's straight part, then 45 degrees in to the
// bottom, which is the shape of a 2020 channel.
// With taper = true the bottom taper_h of it is cut to the 45 degree
// underside, z = (front_y - y) + max(0, |x| - stem_w/2): a wedge rising from the
// wall in y, plus a wedge rising from the stem's sides in x, so a wing is held
// by the stem beside it and the stem by the wall behind it. Three half-spaces.
module slider(h, taper=false) {
    difference() {
        intersection() {
            linear_extrude(h) polygon([
                [-stem_w/2, front_y + 0.01], [-stem_w/2, stem_in], [-head_w/2, stem_in], [-head_w/2, knee_in],
                [-head_bot/2, head_in], [head_bot/2, head_in], [head_w/2, knee_in], [head_w/2, stem_in],
                [stem_w/2, stem_in], [stem_w/2, front_y + 0.01]
            ]);
            if(taper) intersection() {
                halfspace(0, -1, front_y);
                halfspace(1, -1, front_y - stem_w/2);
                halfspace(-1, -1, front_y - stem_w/2);
            }
        }
        translate([-slider_slit/2, head_in - 1, -1]) cube([slider_slit, front_y - head_in + 2, h + 2]);
    }
}
// The solid z >= cx*x + cy*y + c0: a big cube sheared so its floor is that plane.
module halfspace(cx, cy, c0) { multmatrix([[1,0,0,0],[0,1,0,0],[cx,cy,1,c0],[0,0,0,1]]) translate([-50,-50,0]) cube(100); }
// Line termination on the underside: the line comes out of the bottom
// slider's slit at line_y, turns along a channel to the M2 and is clamped
// under its head. Drawn for z = 0 as the face, going +z into the material.
module termination() {
    hull() {
        translate([-channel_w/2, line_y, -0.01]) cube([channel_w, 0.01, channel_d]);
        translate([tie_x, tie_y, -0.01]) cylinder(h=channel_d, d=channel_w, $fn=12);
    }
    translate([tie_x, tie_y, -0.01]) cylinder(h=m2_depth + 0.01, d=m2_hole, $fn=16);
}
module master() {
    difference() {
        union() {
            translate([0, box_y, 0]) rbox(stack_w, box_d, master_h, corner);
            slider(slider_h_bot);
            translate([0,0,master_h - slider_h - taper_h]) slider(slider_h + taper_h, top_taper);
        }
        cavity(master_h, master_floor);
        termination();
        if(use_washers && washer_frame) frame_windows();
        if(use_washers && bolt_stem) bolt_pocket();
    }
    if(use_washers && washer_stem) stem();
}
// The bolt's head, sunk flush in the floor from above, flats to the sides.
// The washers sit on the floor round it and the shank is the stem.
module bolt_pocket() {
    translate([0, box_y, bolt_skin]) rotate([0, 0, 30]) cylinder(h=master_h, d=(bolt_af + 2*bolt_fit)/cos(30), $fn=6);
}
// The stem: up the middle from the floor to the top of the posts, through
// the washers' holes, chamfered at the top so a washer finds it.
module stem() {
    translate([0, box_y, master_floor - 0.01]) {
        cylinder(h=master_h - master_floor - stem_chamfer + 0.01, d=stem_d);
        translate([0, 0, master_h - master_floor - stem_chamfer]) cylinder(h=stem_chamfer + 0.01, d1=stem_d, d2=stem_d - 2*stem_chamfer);
    }
}
// The washer frame: everything above the floor is cut away except the front
// wall, which carries the sliders, with its two corner legs, and with
// `rear_posts` an L post in each rear corner. The sides
// and back are open to the top, so any washer can be gripped and lifted off.
module frame_windows() {
    y0 = box_y - cav_d/2 + corner_leg;
    y1 = rear_posts ? box_y + cav_d/2 - corner_leg : box_y + box_d;
    translate([-stack_w, y0, master_floor]) cube([2*stack_w, y1 - y0, master_h]);
    if(rear_posts) translate([-(cav_w/2 - corner_leg), box_y, master_floor]) cube([cav_w - 2*corner_leg, box_d, master_h]);
}
module cell() {
    difference() {
        union() { translate([0, box_y, 0]) rbox(stack_w, box_d, cell_h, corner); foot(); }
        cavity(cell_h);
    }
}
module lid() { union() { translate([0, box_y, 0]) rbox(stack_w, box_d, lid_t, corner); foot(); } }
module slide_test() {
    difference() {
        union() {
            translate([0, front_y + slide_handle/2, 0]) rbox(test_w, slide_handle, slide_h, corner);
            slider(slide_h);
        }
    }
}
module slider_test() {   // the bottom slider on a slab as thick as the master's floor
    difference() {
        union() {
            translate([0, front_y + test_d/2, 0]) rbox(test_w, test_d, master_floor, corner);
            slider(slider_h);
        }
        termination();
    }
}

use <vslot-2020.scad>
module spine_stub(h) {
    %color([0.66,0.71,0.75]) translate([0,0,-40]) linear_extrude(h + 80) vslot_2020_profile();
    %color([0.1,0.7,0.9]) translate([0, line_y, -5]) cylinder(h=h + 60, d=0.6, $fn=8);
}

if(part == "master") master();
else if(part == "cell") translate([0,0,foot_h]) cell();
else if(part == "lid") translate([0,0,foot_h]) lid();
else if(part == "slide") {
    echo(str("slide: stem ", stem_w, " in a ", slot_w, " opening; head ", head_w, " in an ", chan_w, " channel for ",
             stem_in - knee_in, " under the lips, then 45 in to ", head_bot, " at ", stem_in - head_in, " deep; ",
             head_clr, " off the lips and the floor"));
    slide_test();
}
else if(part == "test") {
    echo(str("test: stem ", stem_w, " in a ", slot_w, " opening, head ", head_w, " in a ", chan_w, " channel, ",
             stem_in - head_in, " thick under ", lip_t, " lips; M2 hole ", m2_hole));
    slider_test();
}
else if(part == "column") {
    master();
    if(cells > 0) for(i=[0:cells-1]) translate([0,0,master_h + gap + foot_h + i*(cell_h + gap + foot_h)]) cell();
    if(!use_washers) translate([0,0,master_h + gap + foot_h + cells*(cell_h + gap + foot_h)]) lid();
}
else if(part == "print") {
    translate([-(stack_w + gap), 0, 0]) master();
    if(!use_washers) { translate([0,0,foot_h]) cell(); translate([stack_w + gap, 0, foot_h]) lid(); }
}
else if(part == "stack") {
    master();
    if(cells > 0) for(i=[0:cells-1]) translate([0,0,master_h + i*cell_h]) cell();
    if(use_washers && bolt_stem) %color([0.45,0.47,0.5]) translate([0, box_y, bolt_skin]) {
        rotate([0, 0, 30]) cylinder(h=bolt_head, d=bolt_af/cos(30), $fn=6);
        cylinder(h=bolt_head + bolt_l, d=16);
    }
    if(use_washers) for(i=[0:washer_n-1]) %color([0.55,0.57,0.6]) translate([0, box_y, master_floor + i*washer[2]])
        difference() { translate([-washer[0]/2, -washer[1]/2, 0]) cube([washer[0], washer[1], washer[2] - 0.2]); translate([0,0,-1]) cylinder(h=washer[2] + 2, d=18); }
    else translate([0,0,master_h + cells*cell_h]) lid();
    spine_stub(stack_h);
}
