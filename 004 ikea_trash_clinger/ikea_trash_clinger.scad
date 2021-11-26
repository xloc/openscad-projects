module clinger_no_blocker() {
    difference() {
        // 36 = 4 6 
        translate([0,-20,-5]) cube([36, 40, 5]);
        translate([13,0,-3.4]) 
            linear_extrude(height=3.4, scale=[4/6.4,1]) 
                square([6.4, 40], center=true);
    }
}

module clinger_with_blocker() {
    difference() {
        // 36 = 4 6 
        translate([0,-20,-5]) cube([36, 40, 5]);
        translate([13,2,-3.4]) 
            linear_extrude(height=3.4, scale=[4/6.4,1]) 
                square([6.4, 40], center=true);
    }
}

clinger_with_blocker();