d = 35.3;
h = 15;

lg = 100;
gt = 6; // gap thickness
edr = 10; // ear delta radius
et = 18; // ear thichness total


module screw_hole(dl, ds) {
    large = 100;
    cylinder(h=large, d=ds, $fn=6);
    mirror([0,0,1]) cylinder(h=large, d=dl, $fn=20);
}


difference() {
    $fn = 50;
    union() {
        cylinder(d=d+3, h=h);
        fr = 1.5; // fillet radius
        translate([0,-et/2+fr,0])minkowski() {
            cube([d/2+edr-fr,et-2*fr,h-1]);
            cylinder(d=fr*2, h=1);
        }
    }
    // remove pipe
    cylinder(d=d, h=h);
    
    // remove ear gap
    translate([0,-gt/2,0]) cube([lg,gt,h]);
    
    // remove shelf aligner
    ndt = 1.5; // aligner norch delta thickness
    ndr = 1; // aligner norch delta radius
    nir = 1.5; // aligner norch increment radius
    #linear_extrude(h) polygon([
        [0, gt/2+ndt], 
            [d/2+ndr, gt/2+ndt], 
                [d/2+ndr+nir, gt/2], 
                [d/2+ndr+nir, -gt/2], 
            [d/2+ndr, -gt/2-ndt], 
        [0, -gt/2-ndt], 
    ]);
    
    // remove screw holes
    for(h=[
        h/2,
        //8,h-8
    ]){
        translate([d/2+edr/2-0.6,gt/2+2,h]) rotate([90,0,0]) 
            screw_hole(dl=7, ds=3.45);
    }
    
}