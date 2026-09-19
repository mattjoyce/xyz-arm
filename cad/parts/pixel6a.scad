// pixel6a.scad — reference solid + parameters for the XYZ Arm Mk1 phone cradle.
//
// COORDINATE SYSTEM (matches the rig):
//   origin = centre of the phone's BACK face
//   +X = across the phone (width)
//   +Y = toward the TOP of the phone (the camera-bar end)
//   +Z = up into the body, so the screen is at Z = +body_t
//   The camera bar protrudes into -Z, i.e. DOWNWARD toward the mat.
//
// Values are tagged:
//   [SPEC]    published, trust it
//   [MEASURE] not published anywhere reliable — caliper the actual phone
//             before cutting. Placeholders below are eyeballed from photos
//             and WILL be a millimetre or two out.

/* ---------------- body ---------------- */
body_l      = 152.2;   // [SPEC] length, Y
body_w      =  71.8;   // [SPEC] width, X
body_t      =   8.9;   // [SPEC] thickness, Z (excludes camera bar)
body_mass_g = 178;     // [SPEC]
corner_r    =  11.0;   // [MEASURE] plan-view corner radius
edge_r      =   2.0;   // [MEASURE] rail edge break

/* ---------------- camera bar ----------------
   Full-width raised bar near the top of the back. Because it spans the whole
   width it is a natural registration datum — register the cradle off the BAR,
   not off the back face, which the bar holds off any flat surface anyway. */
bar_from_top   = 14.0; // [MEASURE] top edge of phone -> top edge of bar
bar_h          = 23.0; // [MEASURE] bar extent along Y
bar_z          =  2.2; // [MEASURE] protrusion below the back face
bar_r          =  3.0; // [MEASURE] bar fillet

/* ---------------- main camera ----------------
   12.2 MP, f/1.7, 1/2.55", 1.4 um pixels, 4032 x 3024, OIS.
   Lens centre offsets are [MEASURE] — take them from the bar's own edges. */
cam_x        = -17.0;  // [MEASURE] lens centre, X from phone centreline
cam_y_in_bar =  11.5;  // [MEASURE] lens centre, Y down from bar top edge
cam_lens_d   =  10.0;  // [MEASURE] outer glass diameter

cam_y = body_l/2 - bar_from_top - cam_y_in_bar;   // derived, phone coords

/* ---------------- optics (derived from [SPEC] sensor data) ----------------
   sensor 5.645 x 4.234 mm, f = 4.40 mm  ->  65.4 deg H, 51.4 deg V
   frame width  = 1.283 * height
   frame height = 0.962 * height
   closest focus 98 mm  ->  126 mm wide, 31 um/px                */
fov_h        = 65.4;
fov_v        = 51.4;
focus_min    = 98;

/* ---------------- keep-outs ---------------- */
// Buttons are on the +X side (right, viewed from the screen): power above the
// volume rocker. A cradle that grips both long edges WILL hold them down —
// relieve this window or the phone sleeps, screenshots and changes volume.
btn_side      = +1;    // +X
btn_from_top  = 34.0;  // [MEASURE] top of phone -> top of power button
btn_span      = 46.0;  // [MEASURE] power top -> volume bottom
btn_relief    =  2.5;  // clearance to leave around the window

usb_from_bot  =  0;    // USB-C, bottom edge centre
mag_keepout   = 100;   // mm from the lens — OIS and the VCM focus actuator are
                       // magnet-driven; keep the Olight's tailcap outside this.

/* ---------------- reference solid ---------------- */
module rrect(l, w, t, r) {
    hull() for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * (w/2 - r), sy * (l/2 - r), 0])
            cylinder(h = t, r = r, $fn = 64);
}

module pixel6a(show_cone = false) {
    color("#3a3f45") {
        rrect(body_l, body_w, body_t, corner_r);           // body
        translate([0, body_l/2 - bar_from_top - bar_h, -bar_z])
            rrect(bar_h, body_w, bar_z + 0.01, bar_r);     // camera bar
    }
    color("#111") translate([cam_x, cam_y, -bar_z - 0.2])
        cylinder(h = 0.3, d = cam_lens_d, $fn = 48);       // main lens

    // the volume the cradle must not enter
    if (show_cone)
        translate([cam_x, cam_y, -bar_z])
            color("#d08a2a", 0.25)
                mirror([0, 0, 1])
                    linear_extrude(height = focus_min, scale = [
                        2 * focus_min * tan(fov_h/2) / cam_lens_d,
                        2 * focus_min * tan(fov_v/2) / cam_lens_d])
                        square([cam_lens_d, cam_lens_d], center = true);
}

/* ---------------- cradle constraints, for whoever models it ----------------
   1. Open U. Grip the two long edges only; leave the entire back face clear.
      No shelf under the camera bar.
   2. Relieve the button window on +X (see btn_* above).
   3. Leave a flat contact patch on the back face, below the bar, for a thermal
      pad to the extrusion — it is the heatsink path. Do not cover the bar.
   4. Nothing may enter the cone from the main lens (show_cone = true).
   5. Screen faces +Z, up. It stays readable and tappable in the rig.
   6. Phone long axis runs ALONG the gantry.                                  */

pixel6a(show_cone = true);
