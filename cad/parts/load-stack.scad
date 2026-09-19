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
// bottom, 20 and 10 mm tall: a stem through the slot's 6 mm opening and a head
// in the channel behind the lips, slit down the middle so the load line runs
// straight through. Both slide in from the rail's top end, before the spine
// cap goes on. The top one overhangs the wall by 5.3 mm; slice with support
// under it. The line runs down inside the channel,
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
// Plain T-slot 2020: spine-cap.scad has the same numbers. Measure the rail.
slot_w     = 6.0;    // opening at the face
lip_t      = 1.8;    // face to the underside of the lip
chan_w     = 11;     // channel width just behind the lips
chan_str   = 1.6;    // how far below the lips the channel stays full width, before it angles in at 45
chan_d     = 5.5;    // face to the floor
spine_clr  = 1.0;    // front face to the rail's rear face

use_insert = true;
insert     = [25, 60, 85];   // the block: across, deep, tall
insert_n   = 1;              // blocks side by side across
insert_clr = 0.3;            // total, on each of the three
shot_w     = 40;             // the shot-filled master's section instead
shot_d     = 60;
shot_h     = 80;

slider_h   = 20;     // the top slider
slider_h_bot = 10;   // the bottom slider
cell_h     = 18;
cells      = 2;      // in the column and stack views
lid_t      = 4;
wall       = 1.2;    // three 0.4 mm perimeters
floor_t    = 1.2;    // cells
master_floor = 6;    // the master: holds the M2
foot_h     = 1.2;    // into the cavity below; its 45 degree flare is the wall
foot_clr   = 0.15;   // a side
corner     = 2;

// The T slider.
stem_w     = slot_w - 0.5;   // through the opening, 0.25 a side
head_w     = chan_w - 0.6;   // in the channel, 0.3 a side
head_clr   = 0.2;            // under the lips, and off the floor
slider_slit = 1.0;           // down the middle of each slider, for the line
tie_y      = 14;     // the M2, from the rail centre, up into the master's floor
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
stack_w  = use_insert ? insert_n*insert[0] + insert_clr + 2*wall : shot_w;
box_d    = use_insert ? insert[1] + insert_clr + 2*wall : shot_d;
stack_d  = box_d;
master_h = use_insert ? master_floor + insert[2] + insert_clr + foot_h : shot_h;
box_y    = front_y + box_d/2;
cav_w    = stack_w - 2*wall;
cav_d    = box_d - 2*wall;
master_cav = cav_w*cav_d*(master_h - master_floor - foot_h)/1000;
cell_cav   = cav_w*cav_d*(cell_h - floor_t - foot_h)/1000;
stack_h    = master_h + cells*cell_h + lid_t;
echo(str("master ", stack_w, " x ", stack_d, " x ", master_h, use_insert ? str(", round ", insert_n, " block(s)") :
         str(", ", master_cav, " cm3: ", master_cav*shot_steel, " g steel shot, ", master_cav*shot_lead, " g lead shot")));
echo(str("cell ", cell_cav, " cm3: ", cell_cav*shot_steel, " g steel shot"));
echo(str("stack ", stack_h, " mm tall with ", cells, " cells; budget about 130"));
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
module slider(h) {
    difference() {
        linear_extrude(h) polygon([
            [-stem_w/2, front_y + 0.01], [-stem_w/2, stem_in], [-head_w/2, stem_in], [-head_w/2, knee_in],
            [-head_bot/2, head_in], [head_bot/2, head_in], [head_w/2, knee_in], [head_w/2, stem_in],
            [stem_w/2, stem_in], [stem_w/2, front_y + 0.01]
        ]);
        translate([-slider_slit/2, head_in - 1, -1]) cube([slider_slit, front_y - head_in + 2, h + 2]);
    }
}
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
            translate([0,0,master_h - slider_h]) slider(slider_h);
        }
        cavity(master_h, master_floor);
        termination();

    }
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

module spine_stub(h) {
    %color([0.66,0.71,0.75]) translate([0,0,-40]) linear_extrude(h + 80) difference() {
        square(rail, center=true);
        for(a=[0:90:270]) rotate(a) {
            translate([-slot_w/2, rail/2 - lip_t]) square([slot_w, lip_t + 1]);
            translate([-chan_w/2, rail/2 - chan_d]) square([chan_w, chan_d - lip_t]);
        }
    }
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
    for(i=[0:cells-1]) translate([0,0,master_h + gap + foot_h + i*(cell_h + gap + foot_h)]) cell();
    translate([0,0,master_h + gap + foot_h + cells*(cell_h + gap + foot_h)]) lid();
}
else if(part == "print") {
    translate([-(stack_w + gap), 0, 0]) master();
    translate([0,0,foot_h]) cell();
    translate([stack_w + gap, 0, foot_h]) lid();
}
else if(part == "stack") {
    master();
    for(i=[0:cells-1]) translate([0,0,master_h + i*cell_h]) cell();
    translate([0,0,master_h + cells*cell_h]) lid();
    spine_stub(stack_h);
}
