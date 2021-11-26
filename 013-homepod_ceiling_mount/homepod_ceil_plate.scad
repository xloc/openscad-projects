dp = 160;
rp = dp/2; // diameter of the plate
tp = 2; // thickness of the plate

af = 4; // fillet thickness

module screw_slot(l) {
    large = 100;
    ds = 10; // the diameter of the screw head through hole
    translate([+l/2,0,0]) cylinder(d=ds, h=large, center=true);
    translate([-l/2,0,0]) cylinder(d=ds, h=large, center=true);
    cube([l,ds,large], center=true);
}

module ring_wedge(ro, rth, h) {
    ri = ro-rth;
    wd = 1;
    
    rotate_extrude($fn=100) polygon([
        [ri, 0], [ro, 0],
        [ro-(rth-wd)/2, h], [ri+(rth-wd)/2, h]
    ]);
}

* mirror([0,0,1]) for(r=[71, 50, 25]) {
    ring_wedge(ro=r, rth=10,h=6);
}

module full_perimeter_wedge() {
    difference() {
        rotate_extrude($fn=100) polygon([
            [0, 0], [0,tp+af*2], 
            [rp-af, tp+af*2], [rp, tp+af], [rp, af], [rp-af, 0],
            [rp-7, 0], [rp-10, 5], [0, 5]
        ]);
        translate([90/2,0,0]) screw_slot(l=9);
        translate([-90/2,0,0]) rotate([0,0,90]) screw_slot(l=9);
        
        translate([0,48,0]) cylinder(h=100, d=14, center=true);
    }
}

intersection() {
    full_perimeter_wedge();
    
    // wedge mask
    union() {
        large = 100;
        rotate_extrude($fn=100) 
            polygon([
                [0, -large], [rp-af-0.4, -large], 
                [rp-af-0.4, +large], [0, +large]
            ]);
        for(deg=[0,120,240]) {
            rotate([0,0,deg+65]) rotate_extrude(angle=55, $fn=100) 
                polygon([
                    [0,  -large], [rp, -large], 
                    [rp, large,], [0,  large]
                ]);
        }
    }
}
    
