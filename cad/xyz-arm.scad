// XYZ Arm Mk1 — low-poly concept assembly, millimetres.
// Based on ../design.html. Placeholder hardware, not fabrication drawings.
use <parts/vslot-2020.scad>
use <parts/vslot-wheel.scad>
use <parts/compact-carriage.scad>
use <parts/wheel-spacer.scad>
use <parts/z-base.scad>
use <parts/turntable-bearing.scad>
/* [Position] */
gantry_height = 280; // [110:420]
gantry_extension = 350; // [220:440]
/* [Design dimensions] */
spine_length = 500;
gantry_length = 500;
wheel_spacing = 60; // Compact plate wheel stations
phone_length = 160;
phone_width = 76;
phone_thickness = 9;
// Provisional smooth guide rods, not a selected hardware size.
guide_diameter = 4; // [3:0.5:6]
/* [Counterweight] */
// Hangs below the desk on the line, so shape is unconstrained: a plain pot.
// 1.02 kg needs ~222 cm3 of steel shot (bulk 4.6 g/cm3) or ~150 cm3 of lead (6.8).
counterweight_diameter = 60; // [40:5:90]
counterweight_height = 80;   // [40:5:160]
counterweight_wall = 2;
/* [Display] */
show_desk = true;
show_mat = true;
show_phone = true;
show_sightline = false;
/* [Hidden] */
$fn = 12;
silver = [0.66,0.71,0.75];
dark = [0.12,0.16,0.19];
accent = [0.91,0.30,0.12];
// Z datum is the DESK SURFACE. Bearing sits on it, base plate on the bearing,
// rail seated in the base's socket floor.
bearing_h = turntable_thickness();
base_h = bearing_h + zbase_rail_seat();
top = base_h + spine_length;
desk_thickness = 18;
line_y_rear = zbase_line_y();
phone_z = gantry_height + 12;
// Camera cluster's inner edge clears the rail tip by 8 mm.
// X plate stays on Z carriage; the entire rail and payload translate.
carriage_thickness = 8;
carriage_size = 84;
gantry_y = -(2*(vwheel_width()/2 + 1 + 6) + carriage_thickness);
wheel_offset = vwheel_2020_offset();
carriage_y = gantry_y/2;
line_anchor_z = gantry_height + carriage_size/2;
gantry_tip = gantry_extension;
gantry_start = gantry_tip - gantry_length;
carriage_x = gantry_tip + 8 + 27/2 + 17 - phone_length/2;
camera_x = carriage_x + phone_length/2 - 17;
camera_y = -phone_width/2 + 16;

module box_at(p,s,c) { color(c) translate(p) cube(s,center=true); }
// Extended by eps at both ends along its own axis: the balance line is drawn as
// a chain of these, and segments that merely butt end-to-end share an exact
// coplanar face, which is the classic way to make a union non-manifold.
module rod(a,b,r,c,eps=0.02) {
    v=b-a; len=norm(v); u=v/len;
    color(c) translate(a-u*eps)
        rotate([0,acos(v[2]/len),atan2(v[1],v[0])])
            cylinder(h=len+2*eps,r=r);
}
// Bought and context geometry carries the % background modifier: drawn for
// reference, excluded from render and export, so what survives an F6 is exactly
// the set of printed parts. It also disposes of the wheels' nominal tangency to
// the rail, where two solids touch along a line and the union is neither
// disjoint nor overlapping -- which is why every module rendered clean alone
// but the assembly did not.
// Shared dimensioned OpenBuilds profile for both axes.
module extrusion(length) {
    %color(silver) vslot_2020(length);
}
// Wheel axles parallel to Y, centred on the rail slot plane.
module mounted_wheel(x,y,z,plate_side=-1,eccentric=false) {
  %union() {
    translate([x,y,z]) rotate([90,0,0]) vslot_wheel();
    // Shim is concentric with axle. Pilot seats in the carriage plate.
    color(silver) translate([x,y+plate_side*(vwheel_width()/2+0.5),z])
        rotate([90,0,0]) difference() {
            cylinder(h=1,d=10,center=true,$fn=32);
            cylinder(h=1.1,d=5,center=true,$fn=32);
        }
    color(eccentric ? [0.8,0.66,0.25] : silver)
        translate([x,y+plate_side*(vwheel_width()/2+1),z])
            rotate([-90*plate_side,0,0])
                wheel_spacer(eccentric,plate_side==1 ? -90 : 0);
    rod([x,y-plate_side*7,z],[x,y+plate_side*(vwheel_width()/2+7+carriage_thickness),z],2.5,silver);
  }
}
module wheel(x,z) { mounted_wheel(x,0,z,-1,x>0); }
module frame() {
    // Turntable on the desk, printed base bolted to it, rail seated in its socket.
    %turntable_bearing();
    color(accent) translate([0,0,bearing_h]) z_base();
    translate([0,0,base_h]) extrusion(spine_length);
    // Two small transverse smooth rods turn the line across the top.
    // Front is -Y. The line runs inside the front slot at X=0, Y=-8.
    // Open centre between side cheeks keeps both slot exits unobstructed.
    guide_r = guide_diameter/2;
    guide_z = top + 1 + guide_r;
    front_guide_y = -8 + guide_r;
    rear_guide_y = 8 - guide_r;
    for(x=[-8,8])
        box_at([x,0,top+2],[4,20,8],accent);
    for(y=[front_guide_y,rear_guide_y])
        %rod([-10,y,guide_z],[10,y,guide_z],guide_r,silver);
    anchor_z = line_anchor_z;
    // Weight mirrors the carriage: as the gantry rises, it descends below the desk.
    weight_top = -20 - (gantry_height - 110);
    // Pot of shot, hanging free in the knee space. Lid doubles as bias adjuster.
    color(dark) translate([0,line_y_rear,weight_top-counterweight_height])
        difference() {
            cylinder(h=counterweight_height,d=counterweight_diameter,$fn=48);
            translate([0,0,counterweight_wall])
                cylinder(h=counterweight_height,
                         d=counterweight_diameter-2*counterweight_wall,$fn=48);
        }
    box_at([0,line_y_rear,weight_top+1.9],[8,8,4],accent); // overlaps the pot lid by 0.1
    %rod([0,-8,anchor_z],[0,-8,guide_z],0.55,accent);
    // Rear run: straight down the rear slot, through the base and the desk.
    %rod([0,line_y_rear,weight_top],[0,line_y_rear,guide_z],0.55,accent);
    // Quarter turns onto a short horizontal run: total rise only 5 mm
    // at the default 4 mm rod diameter (excluding display line thickness).
    for(a=[0:15:75]) {
        %rod([0,front_guide_y-guide_r*cos(a),guide_z+guide_r*sin(a)],
            [0,front_guide_y-guide_r*cos(a+15),guide_z+guide_r*sin(a+15)],0.55,accent);
        %rod([0,rear_guide_y+guide_r*cos(a),guide_z+guide_r*sin(a)],
            [0,rear_guide_y+guide_r*cos(a+15),guide_z+guide_r*sin(a+15)],0.55,accent);
    }
    %rod([0,front_guide_y,guide_z+guide_r],
        [0,rear_guide_y,guide_z+guide_r],0.55,accent);

}
module moving_arm() {
    color(accent) translate([0,carriage_y,gantry_height]) rotate([90,0,0])
        compact_carriage(carriage_size,carriage_thickness,wheel_spacing);
    z_holes=carriage_z_holes(wheel_spacing);
    x_holes=carriage_x_holes(wheel_spacing);
    for(i=[0:2])
        mounted_wheel(z_holes[i][0],0,gantry_height+z_holes[i][1],-1,i==2);
    for(i=[0:2])
        mounted_wheel(x_holes[i][0],gantry_y,gantry_height+x_holes[i][1],1,i==2);
    // Top central lug anchors the front-slot balance line.
    box_at([0,(carriage_y-8)/2,line_anchor_z-2],
           [4,abs(carriage_y+8)+4,4],accent);
    tip_payload();
}
module tip_payload() {
    translate([0,gantry_y,0]) {
    translate([gantry_start,0,gantry_height]) rotate([0,90,0]) extrusion(gantry_length);
    // Cradle: long-edge rails, open underneath the offset camera cluster.
    box_at([carriage_x,0,gantry_height+10.8],[65,20,1.6],[0.3,0.6,0.65]);
    for(x=[carriage_x-40,carriage_x+40])
        box_at([x,0,gantry_height+9],[8,phone_width+10,4],accent);
    for(y=[-1,1])
        box_at([carriage_x,y*(phone_width/2+2),phone_z+4],[phone_length,4,13],accent);
    if(show_phone) %union() {
        box_at([carriage_x,0,phone_z+phone_thickness/2],[phone_length,phone_width,phone_thickness],dark);
        box_at([carriage_x,0,phone_z+phone_thickness+0.3],[phone_length-8,phone_width-8,0.6],[0.12,0.32,0.40]);
        box_at([camera_x,camera_y,phone_z-2],[27,27,4],dark);
        color([0.15,0.48,0.65]) translate([camera_x,camera_y,phone_z-5]) cylinder(h=1,d=12);
    }
    // Olight fixed beneath the phone, beside the rail and behind the camera.
    // Provisional Baton envelope: 24 mm diameter x 65 mm long, lens down.
    light_x = carriage_x-25;
    light_y = phone_width/2-14;
    // Disc and bracket overlapped on exactly the same two bounding planes.
    box_at([light_x,phone_width/2,phone_z-2],[12,8,4],accent);
    color(silver) translate([light_x,light_y,phone_z-4.05]) cylinder(h=4.1,d=28);
    %color(dark) translate([light_x,light_y,phone_z-69]) cylinder(h=65,d=24);
    %color([1,0.85,0.43]) translate([light_x,light_y,phone_z-71]) cylinder(h=2,d=21);

    }
}
frame();
moving_arm();
if(show_desk) %union() {
    // Hole sized for the line's arc: at 6 mm off-axis a +/-45 deg sweep moves it
    // about 4.6 mm, so 25 mm is generous. Drill it, or use an existing grommet.
    color([0.45,0.36,0.26,0.55]) difference() {
        translate([-140,-200,-desk_thickness]) cube([620,400,desk_thickness]);
        translate([0,line_y_rear,-desk_thickness-1]) cylinder(h=desk_thickness+2,d=25,$fn=48);
    }
}
if(show_mat) %union() {
    box_at([340,0,1.5],[297,210,3],[0.22,0.32,0.34]);
    for(x=[210:25:470]) box_at([x,0,3.05],[0.5,200,0.2],[0.45,0.57,0.56]);
    for(y=[-100:25:100]) box_at([340,y,3.05],[287,0.5,0.2],[0.45,0.57,0.56]);
}
if(show_sightline)
    rod([camera_x,camera_y+gantry_y,0],[camera_x,camera_y+gantry_y,phone_z-5],0.7,[0.1,0.7,0.9]);
