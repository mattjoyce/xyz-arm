// Strip collar: a thin band round the gantry 2020 that holds Matt's steel
// strip, 2 x 15.5, flat against one face of the rail and running along it
// (Matt, 2026-09-27). The strip is what the magnetic Olight sticks to.
//
// The band is the rail's section plus a bump over one face, and the bump is
// the strip's pocket. With floor_t = 0 the pocket is open to the rail: the
// strip lies on the aluminium, on the two flats either side of the V mouth
// (3.2 mm each), and pushing it in pulls the band tight round the rail. So
// one push fit holds both, and with the strip out the band slides along the
// rail to where it is wanted. floor_t > 0 puts a wall between strip and rail
// and makes the two fits separate.
//
// The band is square, so the strip goes on whichever face the collar is
// turned to. It stands proud of the rail all round, so it lives outboard of
// the carriage and stops the rail's travel at that end.
//
// Fits are what this printer has shown: 0.15 a side was very tight on the
// eccentric collars and 0.30 a side went on hard in the base gauge. The band
// is thin and gives, so it takes the tight end of both.
//
// Printed standing on its section, as drawn: every wall is vertical. The bore
// and the pocket are chamfered at both ends, which is the strip's lead-in and
// clears elephant's foot on the bed end.
use <vslot-2020.scad>
rail        = 20;
len         = 10;      // along the rail
wall        = 1.6;
fit         = 0.30;    // a side, band on the rail, across the strip's width
strip_w     = 15.5;
strip_t     = 2.0;
strip_fit   = 0.15;    // a side, the push fit
floor_t     = 0;       // 0: strip against the rail. Otherwise a wall this thick between them
relief_r    = 0.4;     // at the bore's corners, where a printed corner bulges
lead_in     = 0.5;     // chamfer on the bore and pocket, both ends
show_context = false;  // rail stub and strip; preview only
$fn = 48;

half     = rail/2;
bore     = rail + 2*fit;
pocket_w = strip_w + 2*strip_fit;
open     = floor_t == 0;
// The pocket in y. Open, the stack is rail plus strip with strip_fit a side
// over the two, measured from the band's far wall. Closed, it is the strip
// alone above its floor.
pocket_y0 = open ? half : bore/2 + floor_t;
pocket_y1 = open ? -bore/2 + rail + strip_t + 2*strip_fit
                 : pocket_y0 + strip_t + 2*strip_fit;
shoulder = (bore - pocket_w)/2;
volume   = len*((bore + 2*wall)*(bore + 2*wall) - bore*bore
           + (pocket_w + 2*wall)*(pocket_y1 - bore/2) - pocket_w*(pocket_y1 - max(pocket_y0, bore/2)))/1000;

assert(pocket_w < bore, "strip wider than the rail's face");
assert(pocket_y1 > bore/2 + 0.5, "no pocket left above the bore");
assert(wall - relief_r*0.42 >= 1.0, "corner relief leaves too little wall");
assert(wall - lead_in >= 1.0, "lead-in leaves too little wall at the ends");
assert(2*lead_in < len, "lead-ins meet");
echo(str("collar ", bore + 2*wall, " x ", pocket_y1 + wall + bore/2 + wall, " x ", len,
         ", pocket ", pocket_w, " x ", pocket_y1 - pocket_y0, open ? " open to the rail" : " closed",
         ", shoulders ", shoulder, ", about ", volume, " cm3"));

module bore_2d(d=0)   { square(bore + 2*d, center=true); }
module pocket_2d(d=0) {
    translate([-pocket_w/2 - d, pocket_y0 - (open ? 0 : d)])
        square([pocket_w + 2*d, pocket_y1 - pocket_y0 + (open ? d : 2*d)]);
}
module outline_2d() {
    offset(r=wall) union() {
        bore_2d();
        translate([-pocket_w/2, 0]) square([pocket_w, pocket_y1]);
    }
}
module reliefs_2d() {
    for(x=[-1,1], y=[-1,1]) translate([x*bore/2, y*bore/2]) circle(r=relief_r, $fn=24);
}
// Chamfer on a convex opening at the end z, opening outward.
module lead(z, up) {
    s = up ? 1 : -1;
    translate([0,0,z]) hull() {
        translate([0,0,-s*lead_in]) linear_extrude(0.01, center=true) children();
        translate([0,0, s*0.5]) linear_extrude(0.01, center=true) offset(delta=lead_in + 0.5) children();
    }
}

module strip_collar() {
    difference() {
        linear_extrude(len) outline_2d();
        translate([0,0,-1]) linear_extrude(len + 2) { bore_2d(); pocket_2d(); reliefs_2d(); }
        for(e=[[0, false], [len, true]]) {
            lead(e[0], e[1]) bore_2d();
            lead(e[0], e[1]) pocket_2d();
        }
    }
}

strip_collar();

if(show_context) %union() {
    translate([0,0,-25]) color([0.66,0.71,0.75]) vslot_2020(60);
    y = open ? half : pocket_y0 + strip_fit;
    translate([-strip_w/2, y, -15]) color([0.45,0.47,0.5]) cube([strip_w, strip_t, 80]);
}
