r = 0.02; // ratio


module room() {
    w = 3350; // 11'
    d = 2590; // 8'6"

    difference() {
        linear_extrude(2) square([w*r+2, d*r+2], center=true);
        translate([0,0,1]) linear_extrude(1) square([w*r, d*r], center=true);
    }
}

module bed() {
    w = 1970;
    d = 1030;
    d_ladder = 1410;
    w_ladder = 550;
    
    linear_extrude(1) union() {
        square([w*r, d*r]);
        translate([0,0]) square([w_ladder*r, d_ladder*r]);
    }
}

module desk() {
    w = 1600;
    d = 800;
    
    linear_extrude(1) square([w*r, d*r], center=true);
}

module grid_shelf() {
    w = 770;
    d = 390;
    h = 1470;
    
    linear_extrude(d*r) difference() {
        square([h*r, w*r], center=true);
        square([h*r-2, w*r-2], center=true);
    }
}

module shelf() {
    w = 800;
    d = 280;
    
    linear_extrude(1) square([w*r, d*r], center=true);
}

//room();
bed();
//desk();
//grid_shelf();
//shelf();