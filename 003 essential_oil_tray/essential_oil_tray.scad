d = 25.5; // diameter of bottle; 25.2 is too tight
m = 5; // space between bottles
s = 0; // surrounding spacing
r = 6; // additional round radius

h = 16; // height of the tray
hh = 2; // the plastic height under the bottle

a = d*2 + m*(2-1) + s*2;
b = d*2 + m*(2-1) + s*2;

module slot(x, y) {
    large = 80;
    translate([(x+0.5)*d+x*m, (y+0.5)*d+y*m,0]) union() {
        translate([0,0, hh]) cylinder(d=d, h=large);
        translate([0,0, h-3]) cylinder(d1=d, d2=d+0.3, h=3);
        translate([0,0, h-1]) cylinder(d1=d+0.3, d2=d+0.3+2, h=1);
    }
}

difference() {
    translate([-s,-s,-0.2]) minkowski() {
        $fn=20;
        cube([a, b, h]);
        cylinder(r=r, h=0.1);
    }
    
    slot(0,0);
    slot(0,1);
    slot(1,0);
    slot(1,1);
    
}
        