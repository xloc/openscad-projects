

module original_cod() {
    h1 = 5; // cylinder height 1
        
    h2 = 6;
    h3 = 2;

    d2 = 50;
    dm = 0;
    d3 = 50.0 - h2/0.707;

    union() {
        cylinder(h=h2, d1=50+dm, d2=d3, $fn=100);
        translate([0,0,h2]) cylinder(h=h3, d1=d3+dm, d2=d3+dm, $fn=100);
    }
}

module cap() {
    intersection() {
        original_cod();
        cylinder(d=100, h=2.8);
    }

}


module rod() {
    intersection() {
        union() {
            original_cod();
        }
        translate([0,0,3]) cylinder(d=100, h=100);
    }
}

// cap();
// rod();

module joint(hd = 3, dh=20, d=15) {
    lg = 100;
    
    translate([0,0,dh]) rotate([-90,0,0]) difference() {
        union() {
            cylinder(d=d, h=lg, center=true);
            translate([-d/2, 0, -lg/2]) cube([d, dh, lg]);
        }
        cylinder(d=hd, h=lg, center=true);
    }
}

joint();

