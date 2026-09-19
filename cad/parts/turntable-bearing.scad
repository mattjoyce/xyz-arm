// Salvaged lazy-susan bearing, from captures/2026-09-12-turntable.
// OD confirmed by hand in captures/README.md. Other values are estimates.
/* [Measured] */
outer_diameter = 140;
/* [Photo estimates - verify before fabrication] */
bore_diameter = 87;
race_diameter = 114;
race_gap = 0.6;
outer_hole_pcd = 128;
inner_hole_pcd = 102;
hole_diameter = 5;
countersink_diameter = 10;
countersink_depth = 2.5;
/* [Measured thickness] */
thickness = 8.5; // Confirmed by user.
/* [Display] */
inner_rotation = 45; // Relative hole pattern angle, independently rotating ring.
section_view = false;

function turntable_thickness() = thickness;
function turntable_od()        = outer_diameter;
function turntable_bore()      = bore_diameter;

module turntable_bearing(od=140,id=87,height=8.5,race=114,gap=0.6,
                        outer_pcd=128,inner_pcd=102,hole=5,
                        sink_d=10,sink_depth=2.5,angle=45,section=false) {
    assert(id>0 && id<race-gap && race+gap<od);
    assert(height>sink_depth && sink_depth>=0);
    assert(inner_pcd-hole>id && inner_pcd+hole<race-gap);
    assert(outer_pcd-sink_d>race+gap && outer_pcd+sink_d<od);
    difference() {
        union() {
            color([0.64,0.67,0.69]) difference() {
                cylinder(h=height,d=od,$fn=128);
                translate([0,0,-0.1]) cylinder(h=height+0.2,d=race+gap,$fn=128);
                for(a=[0:90:270]) rotate([0,0,a]) translate([outer_pcd/2,0,0]) {
                    translate([0,0,-0.1]) cylinder(h=height+0.2,d=hole,$fn=32);
                    translate([0,0,height-sink_depth])
                        cylinder(h=sink_depth+0.01,d1=hole,d2=sink_d,$fn=48);
                }
            }
            color([0.53,0.56,0.58]) rotate([0,0,angle]) difference() {
                cylinder(h=height,d=race-gap,$fn=128);
                translate([0,0,-0.1]) cylinder(h=height+0.2,d=id,$fn=128);
                for(a=[0:90:270]) rotate([0,0,a]) translate([inner_pcd/2,0,-0.1])
                    cylinder(h=height+0.2,d=hole,$fn=32);
            }
        }
        if(section) translate([-od,-od,-1]) cube([2*od,od,height+2]);
    }
}

// Two separated rings depict visible geometry only. Hidden raceways,
// balls and retaining features are unknown and intentionally unmodelled.
turntable_bearing(outer_diameter,bore_diameter,thickness,race_diameter,race_gap,
                  outer_hole_pcd,inner_hole_pcd,hole_diameter,
                  countersink_diameter,countersink_depth,inner_rotation,section_view);
