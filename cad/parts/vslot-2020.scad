// OpenBuilds V-Slot 20x20, millimetres.
// Source: ../../datasheets/openbuilds-vslot-20x20.pdf, page 1.
// Open directly for a short inspection sample; `use` for library modules.
sample_length = 60;
section_only = false;

module vslot_2020_profile(corner_radius=0.5, centre_notch=0.2) {
    // Dimensioned features from drawing.
    half_size = 10;
    mouth_half = 9.16/2;
    throat_half = 6.25/2;
    channel_half = 11/2;
    shoulder_y = half_size - 1.80;
    floor_y = shoulder_y - 4.30;
    // 90-degree V: each face has a 45-degree slope.
    throat_y = half_size - (mouth_half-throat_half);
    // Adjacent diagonal cavity walls straddle y=x. Their normal
    // separation is the specified 1.50 mm web thickness.
    diagonal_offset = 1.50/sqrt(2);
    channel_knee_y = channel_half + diagonal_offset;
    floor_half = floor_y - diagonal_offset;

    // Corner radius and tiny floor-centre notch are visually estimated:
    // the PDF depicts them but does not dimension them.
    difference() {
        offset(r=corner_radius,$fn=24)
            square([20-2*corner_radius,20-2*corner_radius],center=true);
        circle(d=4.20,$fn=64);
        for(a=[0:90:270]) rotate(a)
            polygon([
                [-mouth_half,11], [mouth_half,11],
                [mouth_half,half_size], [throat_half,throat_y],
                [throat_half,shoulder_y], [channel_half,shoulder_y],
                [channel_half,channel_knee_y], [floor_half,floor_y],
                [centre_notch,floor_y], [0,floor_y-centre_notch],
                [-centre_notch,floor_y], [-floor_half,floor_y],
                [-channel_half,channel_knee_y], [-channel_half,shoulder_y],
                [-throat_half,shoulder_y], [-throat_half,throat_y],
                [-mouth_half,half_size]
            ]);
    }
}

module vslot_2020(length=500) {
    assert(length>0,"Rail length must be positive");
    linear_extrude(height=length,convexity=10) vslot_2020_profile();
}

if(section_only) vslot_2020_profile();
else color([0.66,0.71,0.75]) vslot_2020(sample_length);
