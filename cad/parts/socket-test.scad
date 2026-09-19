// Socket test piece: the fins variant's boss, nothing else. Same 0.375 mm/side
// fit, through pocket with the mouth lead-in, the chamfered top edge and the
// 2 mm ledge at the bottom for the rail to sit on, and both bolt stations on
// one face,
// on the shared keyhole: one window between them, slotted down to the lower
// hole and up to the upper. It is built
// from z-base.scad's own modules, so a pass here is a pass on the base. Print
// flat, the end with the lead-in chamfer at the top.
//
// Fit: the rail should slide through by hand with no lean to speak of.
// Holes: rail through first. Start an M5 x 10 button head two turns into a
// tee nut, feed the nut through the window into the rail slot, slide the
// screw down (or up) the slot until the head drops into its counterbore.
use <z-base.scad>

test_h   = 45;     // height printed: the whole socket, since the shared keyhole spans it
stations = [10, 36];   // both stations, as on the base

top = zbase_height() - zbase_plate_t();   // socket height, once the plate is dropped
translate([0,0,-(top - test_h)]) intersection() {
    translate([0,0,-zbase_plate_t()]) difference() {
        boss_body();
        rail_pocket(through=true, ledge_z=zbase_plate_t());   // ledge at this piece's bottom
        tee_holes(stations);
        tee_counterbores(stations);
    }
    translate([-50,-50,top - test_h]) cube([100,100,test_h]);
}
