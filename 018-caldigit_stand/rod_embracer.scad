d = 35.3;
h = 50;

lg = 100;
gt = 4; // gap thickness
edr = 10; // ear delta radius
et = 16; // ear thichness total


module screw_hole(dl, ds, hb, db) {
    large = 100;
    cylinder(h=large, d=ds, $fn=6);
    translate([0,0,-hb]) union() {
        cylinder(h=hb, d=db, $fn=20);
        mirror([0,0,1]) cylinder(h=large, d=dl, $fn=20);
    }
}


difference() {
    $fn = 50;
    union() {
        cylinder(d=d+3, h=h);
        translate([0,-et/2,0]) cube([d/2+edr,et,h]);
    }
    // remove pipe
    cylinder(d=d, h=h);
    
    // remove ear gap
    translate([0,-gt/2,0]) cube([lg,gt,h]);
    
    // remove shelf aligner
    ndt = 2; // aligner norch delta thickness
    ndr = 1; // aligner norch delta radius
    nir = 2; // aligner norch increment radius
    #linear_extrude(h) polygon([
        [0, gt/2+ndt], 
            [d/2+ndr, gt/2+ndt], 
                [d/2+ndr+nir, gt/2], 
                [d/2+ndr+nir, -gt/2], 
            [d/2+ndr, -gt/2-ndt], 
        [0, -gt/2-ndt], 
    ]);
    
    // remove screw holes
    ds = 3.45;
    for(h=[
        h/2,
        0.2*h, 0.8*h,
    ]){
        translate([d/2+edr/2+1,gt/2,h]) rotate([90,0,0]) 
            screw_hole(dl=7, ds=ds, hb=2, db=3.7);
    }
    
}