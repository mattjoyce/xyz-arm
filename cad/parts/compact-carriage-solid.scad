// Cura modifier for compact-carriage.stl: a cylinder round every wheel
// station, the plate's own boss size and thickness, in the plate's
// coordinates. Load with the plate, select both, Merge Models (Ctrl+Alt+G),
// then Per Model Settings on this one: Modify settings for overlaps, Infill
// only, Infill Density 100 %.
use <compact-carriage.scad>
d         = 20;   // compact-carriage.scad boss_r 10
thickness = 8;
spacing   = 60;
for(p=concat(carriage_z_holes(spacing), carriage_x_holes(spacing)))
    translate([p[0], p[1], 0]) cylinder(h=thickness, d=d, center=true, $fn=64);
