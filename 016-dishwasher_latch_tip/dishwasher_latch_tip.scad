w = 7.62 + 0.2;
h = 2.50 + 0.2;
d = 17.86 + 0.2;
lg = 100;

btw = 2; // border thichness width direction
bth = 3; // border thichness height direction


module scube(x, xs, y, z, center=false) {
    if(center){
        linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    } else {
        translate([x/2,y/2,0])
            linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    }   
}

module screw_hole(dl, ds) {
    large = 100;
    cylinder(h=large, d=ds, $fn=6);
    mirror([0,0,1]) cylinder(h=large, d=dl, $fn=20);
}

difference() {
    intersection() {
        minkowski() {
            rotate([90,0,0]) sphere(r=1, $fn=20);
            difference() {
                translate([-btw-w/2,-bth-h/2,0]) cube([w+2*btw, h+2*bth, d+8]);
                translate([0,0,d+8]) mirror([0,0,1])
                    scube(x=w,xs=5, y=lg, z=4, center=true);
            }
        }
        linear_extrude(lg) square([lg,lg], center=true);
    }
	translate([-w/2,-h/2,0]) cube([w,h,d]);

    
    ds = 2.8;
    translate([0,h/2+2.5,d-0.2-2.6-ds/2]) rotate([90,0,0]) 
        screw_hole(dl=5.5, ds=ds);
}	
