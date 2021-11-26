ox = 25; // offset x dimension
px = 12; // mounting plate x dimension

sx = 40; // slot x
sb = 8; // slot blocker
sy = 12; //  slot y
soy = 10; // slot offset y


py = 80; // mounting plate y dimension

hz = 60; // height (z dimension)


module screw_hole(dl, ds, h) {
    // dl, ds: diameter large, small
    // h: diameter transition height
    large = 100;
    cylinder(h=large, d=dl, $fn=20);
    
    mirror([0,0,1]) union() {
        cylinder(h=large, d=ds, $fn=20);
        cylinder(h=h, d1=dl, d2=ds, $fn=20);
    }
}

module screw() {
    rotate([0,90,0]) screw_hole(h=5.5, ds=4.4, dl=8.4);
}

module fillet() {
    translate([ox,soy]) scale([1,5,5]) rotate([0,90,0]) cylinder(h=sx,r=1,$fn=4);
}

mirror([0,1,0]) difference() {
    union() {
        cube([px,py,hz]);
        translate([0,0,0]) cube([ox, soy, hz]);
        translate([0,soy,0]) cube([sx+ox, sy, hz]);
        translate([sx+ox,0,0]) cube([sb, soy+sy, hz]);
    }
    

    fillet();
    translate([0,0,hz]) fillet();
    
    dt = soy+sy; // deck thickness
    translate([px,dt+(py-dt)/2,hz/2]) for(yy=[-15], zz=[-18,18]) {
        translate([0,yy, zz]) screw();
    }
    

}

