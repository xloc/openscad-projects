h = 50;

lg = 100;

gt = 4 - 0.4; // gap thickness
edr = 10; // ear delta radius
et = 16; // ear thichness total

sf = 0.5; // blocker remove constant

// remove shelf aligner
ndt = 2; // aligner norch delta thickness
ndr = 1-sf; // aligner norch delta radius
nir = 2; // aligner norch increment radius

cdx = 132; // caldigit x dimension

caz = 3; // caldigit alignment plate z diminsion
py = 50;
pz = 10 + caz;

module platform() {
    
}

module extrude_intersection(dy=et) {
    polygon([
        [-ndr-nir, gt/2+ndt], 
            [-nir, gt/2+ndt], 
                [0, gt/2], 
                    [edr-3, gt/2], 
                        [edr-3, +dy/2], 
                            [edr-3+cdx, +dy/2], 
                            [edr-3+cdx, -dy/2], 
                        [edr-3, -dy/2], 
                    [edr-3, -gt/2], 
                [0, -gt/2], 
            [-nir, -gt/2-ndt], 
        [-ndr-nir, -gt/2-ndt], 
    ]);
}

module body() {
    difference() {
        union() {
            linear_extrude(h) extrude_intersection();
            translate([edr-3,-py/2,0]) cube([cdx, py, pz]);
        }
        
        // remove screw holes
        ds = 3.45;
        for(h=[
            h/2,
            0.2*h, 0.8*h,
        ]){
            translate([edr/2+1-3,gt/2,h]) rotate([90,0,0]) 
                cylinder(h=lg, d=3.7, $fn=20, center=true);
        }
        
    }
    
}

module filleted_body() {
    intersection() {
        
        body();
        #rotate([90,0,0]) linear_extrude(lg*2, center=true) polygon([
            [-lg,caz], 
            [cdx, caz],[cdx, pz],
            [edr-3 + 10, h],
            [-lg, h]
        ]); 
    }
}


module screw_hole(dl, ds, h) {
    large = 100;
    cylinder(h=large, d=dl, $fn=20);
    mirror([0,0,1]) union() {
        cylinder(h=large, d=ds, $fn=20);
        cylinder(h=h, d1=dl, d2=ds, $fn=20);
    }
}


module caldigit_base() {
    pdy = 85.2;
    module strip() {
        translate([0,-pdy/2,0]) cube([2.1,pdy,2.6+1.2]);
    }

    difference() {
        union(){
            translate([-edr+3,0,0]) 
                linear_extrude(caz) extrude_intersection(dy=pdy);
            translate([9,0,caz]) union() {
                translate([0,0,0]) strip();
                translate([109.93+2.3,0,0]) strip();
            }
        }
        translate([9,0,caz-0.4]) for (tsx=[0.3, 0.7]){
            translate([109.93*tsx,0,0]) screw_hole(dl=6, ds=3.5, h=2.5);
        }
    }
}

intersection() {
    caldigit_base();
//    union(){
//        cube([lg*4, 20, lg], center=true);
//        cube([15*2, lg*2, lg], center=true);
//    }
}


