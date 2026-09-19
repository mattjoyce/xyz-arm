// Compact six-wheel carriage; original geometry inspired by OTL footprint.
// XY plate, Z thickness. Z rail along Y on rear; X rail along X on front.
use <vslot-wheel.scad>
use <wheel-spacer.scad>
// Last point in each set is the intended eccentric adjuster.
function carriage_z_holes(spacing=60) =
    [[-vwheel_2020_offset(),-spacing/2],[-vwheel_2020_offset(),spacing/2],
     [vwheel_2020_offset(),0]];
function carriage_x_holes(spacing=60) =
    [[-spacing/2,-vwheel_2020_offset()],[spacing/2,-vwheel_2020_offset()],
     [0,vwheel_2020_offset()]];
module compact_carriage(size=84,thickness=8,spacing=60) {
    holes=concat(carriage_z_holes(spacing),carriage_x_holes(spacing));
    difference() {
        linear_extrude(height=thickness,center=true) hull() {
            for(p=holes) translate(p) circle(r=10,$fn=24);
            // Preserve the top line anchor.
            translate([0,size/2-4]) circle(r=4,$fn=24);
        }
        // Four concentric M5 holes; two larger eccentric locating holes.
        for(axis=[0,1],i=[0:2]) {
            p=axis==0 ? carriage_z_holes(spacing)[i] : carriage_x_holes(spacing)[i];
            shift=i==2 ? (axis==0 ? [-spacer_eccentricity(),0] : [0,-spacer_eccentricity()]) : [0,0];
            translate([p[0]+shift[0],p[1]+shift[1],0])
                cylinder(h=thickness+2,d=i==2 ? spacer_plate_hole() : 5.2,center=true,$fn=48);
        }
        cylinder(h=thickness+2,d=12,center=true,$fn=32);
    }
}
color([0.91,0.30,0.12]) compact_carriage();
