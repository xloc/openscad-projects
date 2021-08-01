module blocker() {
    difference() {
        translate([-8, -8, 0]) cube([50+8, 15+8, 30]);
        cube([50, 15, 30]);
        cylinder(r=4, h=30);
    }
}

translate([0,  0, 0]) blocker();
translate([0, 40, 0]) mirror([0,1,0]) blocker();