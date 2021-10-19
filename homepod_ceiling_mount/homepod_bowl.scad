dp = 160;
rp = dp/2; // diameter of the plate
tp = 2; // thickness of the plate
af = 4; // fillet thickness

m = 0.2; // margin between the ceiling plate and the bowl

module bowl() {
    translate([0,0,50/2])
    import("/Users/oliver/workspace/openscad/homepod_ceiling_mount/bowl.stl");
}

module full_perimeter_wedge() {
    rotate_extrude($fn=100) polygon([
        [0, 0], [0,tp+af*2], 
        [0,12], [rp-af+m,12],
        [rp-af+m, tp+af*2], [rp+m, tp+af], [rp+m, af], [rp-af+m, 0],
        //[rp-7, 0], [rp-10, 5], [0, 5]
    ]);
}

module wedge_slots() {
    for(deg=[0,120,240]) {
        rotate([0,0,deg]) rotate_extrude(angle=60, $fn=100) 
            polygon([
                [0, 0], [rp+m, 0], 
                [rp+m, 4], [0, 4]
            ]);
    }
}

module wedge_slot_blocker() {
    for(deg=[0,120,240]) {
        rotate([0,0,deg-2]) rotate_extrude(angle=3, $fn=100) 
            polygon([
                [rp-af+m, 0], [rp+m, 0], 
                [rp+m, 10], [rp-af+m, 10]
            ]);
    }
}

hn = 0.8; // neck height
dn = 41.5; // neck diameter
hb = 3; // body height
db = 160; // body height

dd = 44; // non-neck diameter (the space for the bottom of the homepod)
wp = 47; // width of the insertion plate

module homepods_hole() {
    hf = 1; // fillet height
    mirror([0,0,1]) union() {
        cylinder(h=hn, d=dn);
        translate([0,0,hn]) cylinder(h=hf, d1=dn, d2=dd);
        translate([0,0,hn+hf]) cylinder(h=10, d=dd);
    }
}

module slot(l) {
    large = 200;
    ds = 7; // the diameter of the screw head through hole
    translate([+l/2,0,0]) cylinder(d=ds, h=large, center=true);
    translate([-l/2,0,0]) cylinder(d=ds, h=large, center=true);
    cube([l,ds,large], center=true);
}

module sacrifising_layer(th=0.2) {
    //translate([0,0,45.85]) cylinder(d=120, h=th);
    translate([0,0,43.35]) cylinder(d=120, h=th);
}

module half_space() {
    large = 100;
    translate([-large,0,0]) cube([large*2, large, large*2]);
}



module bowl_with_claw() {
    difference() {
        bowl();
        homepods_hole();
        full_perimeter_wedge();
        wedge_slots();
        // half_space();
    }
}

module mask(shrink=0) {
    w = wp - shrink;// the width of the insert plate
    mirror([0,0,1]) linear_extrude(hb+0.01, scale=[1,1.1]) 
        translate([0,-w/2,0]) square([db,w]);
}

module body() {
    wedge_slot_blocker();

    difference() {
        bowl_with_claw();
        
        #translate([-48,0,0]) rotate([0,0,90]) slot(l=7);
        translate([0,0,51]) homepods_hole();
        translate([0,0,51]) mask();
    }

    sacrifising_layer();
}

// the bowl
body();

// For Debug: only upper part
*difference() {
    body();
    cylinder(d=200, h=47.4);
}

module insertion_plate() {
    intersection() {
        difference() {
            bowl_with_claw();
            translate([0,0,51]) homepods_hole();
        }
        translate([0,0,51]) mask(shrink=0.15);
    }
}

// the insertion plate
*insertion_plate();
