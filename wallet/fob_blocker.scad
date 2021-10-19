module fob(th) {
    ss = 1.03;
    difference() {
        scale([ss,ss,th]) mirror([0,0,1]) import("./fob.stl");
        cylinder(d1=26, d2=24.5,h=th);
    }
}

translate([10,-20,0]) fob(1.2);