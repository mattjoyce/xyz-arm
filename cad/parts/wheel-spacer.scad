// Nominal 6 mm spacer family, axis Z, wheel face at Z=0.
// Supplier: https://www.makerstore.com.au/product/shim-eccentric-8-6/
// 8 mm AF, 10 mm flange, 5 mm bore, 7.11 mm plate hole, ~0.79 travel.
// Measured on Matt's, 2026-09-20: 8.54 overall, 6 above the shoulder, 2.5
// collar below it, collar 7 mm OD, flange 10 mm OD. Flange thickness is still
// provisional.
function spacer_eccentricity() = 0.79/2;
function spacer_plate_hole() = 7.11;
module wheel_spacer(eccentric=false,angle=0) {
    e=spacer_eccentricity();
    // Origin stays on the axle; the locating pilot is offset from it.
    rotate([0,0,angle]) difference() {
        if(eccentric) translate([-e,0,0]) union() {
            cylinder(h=5,d=8/cos(30),$fn=6);
            translate([0,0,5]) cylinder(h=1,d=10,$fn=48);
            translate([0,0,6]) cylinder(h=2.5,d=7.08,$fn=48);
        }
        else cylinder(h=6,d=8,$fn=48);
        translate([0,0,-0.1]) cylinder(h=8,d=5,$fn=48);
    }
}
color([0.65,0.69,0.72]) wheel_spacer(true);
