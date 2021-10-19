hn = 0.8; // neck height
dn = 41.5; // neck diameter
hb = 3; // body height
db = 160; // body height

dd = 44; // non-neck diameter (the space for the bottom of the homepod)

ds = 4.6; // diameter of the screw
dls = 50; // diameter of the screw holes

module screw_hole() {
     translate([0,dls,0]) union() {
         cylinder(h=hb, d=ds, $fn=20);
         hf = 2; // fillet height
         cylinder(h=hf, d1=ds+hf*2, d2=ds, $fn=20);
     }
}

module half_space() {
    translate([0,-50,0]) cube([100,100,100]);
}

wp = 47; // width of the insertion plate

module mask(shrink=0) {
    w = wp - shrink;// the width of the insert plate
    linear_extrude(hb+0.01, scale=[1,1.1]) translate([0,-w/2,0]) square([db,w]);
}



module body() {
    difference() {
        $fn=50;
        cylinder(h=hb, d2=db, d1=db-5, $fn=80);
        cylinder(h=hn, d=dn);
        translate([0,0,hn]) cylinder(h=hb-hn, d=dd);
        
        for(deg=[0,90,180,270]){
            rotate([0,0,deg+45]) screw_hole();
        }
        
        // half_space();
    }
}

module plate_wire_hole() {
    large = 100;
    dd = 6;
    cylinder(d=dd,h=large, center=true, $fn=20);
    translate([0,large/2,0]) cube([dd, large, large], center=true);
    
}


// main body
difference() {
    body();
    mask();
}

// plate
*intersection() {
    body();
    difference() {
        mask(0.1);
        translate([30,wp/2-3,0]) plate_wire_hole();
        
    }
}