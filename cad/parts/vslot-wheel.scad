// Solid V wheel reference: ../../datasheets/solid-v-wheel-drawing.jpg.
// Supplier: https://www.makerstore.com.au/product/wheel-solidv-kit/
// Axis Z, centred at origin. Nominal assembly, not manufacturing CAD.
show_bearings = true;

function vwheel_width() = 10.23; // kit spec; drawing rounds this to 10.20
function vwheel_od() = 23.90;
function vwheel_land() = 5.90;
// Derived tangent fit against the 9.16 mm mouth and 45-degree rail faces.
function vwheel_2020_offset() = 10-9.16/2 + vwheel_od()/2 + vwheel_land()/2;

module vslot_wheel(bearings=true, facets=64) {
    w=vwheel_width();
    r=vwheel_od()/2;
    land=vwheel_land();
    edge_r=r-(w-land)/2; // 45-degree mating chamfers
    color([0.12,0.14,0.16]) rotate_extrude($fn=facets,convexity=6)
        polygon([[8,-w/2],[edge_r,-w/2],[r,-land/2],
                 [r,land/2],[edge_r,w/2],[8,w/2],
                 [8,0.115],[7,0.115],[7,-0.115],[8,-0.115]]);
    // Two nominal 625 bearings: 5 mm bore, 16 mm OD, 5 mm wide.
    // Internal rolling elements omitted; centre shim holds inner races apart.
    if(bearings) {
        for(z=[-w/2,0.115]) translate([0,0,z]) {
            color([0.65,0.69,0.72]) difference() {
                cylinder(h=5,d=16,$fn=facets);
                translate([0,0,-0.01]) cylinder(h=5.02,d=5,$fn=facets);
            }
            for(face=[0,4.95]) color([0.18,0.20,0.22])
                translate([0,0,face]) difference() {
                    cylinder(h=0.05,d=13.5,$fn=facets);
                    translate([0,0,-0.01]) cylinder(h=0.07,d=7.5,$fn=facets);
                }
        }
        color([0.65,0.69,0.72]) difference() {
            cylinder(h=0.23,d=10,center=true,$fn=facets);
            cylinder(h=0.25,d=5,center=true,$fn=facets);
        }
    }
}

vslot_wheel(show_bearings);
