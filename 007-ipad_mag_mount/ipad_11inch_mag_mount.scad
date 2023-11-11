th = 3.2;

module corner() {
    translate([-18.79, -18.79]) polygon([
        [18.79, 0.0], [18.79, 1.56], [18.79, 3.13], [18.79, 4.76], 
        [18.75, 6.44], [18.55, 8.13], [18.15, 9.82], [17.54, 11.46], 
        [16.71, 13.0], [15.66, 14.42], [14.42, 15.67], [13.01, 16.71], 
        [11.45, 17.53], [9.79, 18.09], [8.1, 18.46], [6.41, 18.67], 
        [4.76, 18.8], [3.15, 18.86], [1.56, 18.86], [0.0, 18.79],
        [18.79, 18.79]
    ]);
}

module mag() {
    linear_extrude(3.2) square(3.9, center=true);
}

// ipad dimension: 178.52 x 247.64 mm
// smart connector center plate to the closest edge distance: 10 + 3.4/2 = 11.7mm

module lower_part_centered_plate_2d() {
    translate([-178.52/2,-11.7]) difference() {
        square([135, 45]);
        rotate(180) corner();
    }
}

module lower_part_magnets() {
    for (tx=[-25.68, -20.98, -16.28], ty=[6.08, 10.78, 15.48])
        translate([tx,ty]) mag(); // center 3x3
    for(ty=[14.78, 7.58])
        translate([-61.48,ty]) mag(); // left 1x2
    for(tx=[-17.88, -13.18, 13.82, 18.52])
        translate([tx,-1.71]) mag(); // bottom 4x1
    for(ty=[14.73, 10.03, 5.33])
        translate([27.92,ty]) mag(); // right1 1x3
    for(ty=[14.73, 5.33])
        translate([32.27,ty]) mag(); // right2 1x2
    for(ty=[14.73, 5.33])
        translate([57.62,ty]) mag(); // right3 1x2
    for(ty=[14.73, 10.03, 5.33])
        translate([62.02,ty]) mag(); // right4 1x3    
}

module lower_part(){
    difference() {
        linear_extrude(th) lower_part_centered_plate_2d();
        lower_part_magnets();
    }
}

//lower_part();

module upper_part_centered_plate_2d() {
    w = 45;// plate width
    translate([-178.52/2,247.64-11.7-w]) difference() {
        square([135, w]);
        translate([0,w]) mirror([0,1]) rotate(180) corner();
    }
}

module upper_part_magnets() {
    for(ty=[216.46, 209.26])
        translate([-61.47,ty]) mag(); // left1 1x2
    
    for(ty=[217.56, 208.16])
        translate([-30.13,ty]) mag(); // center1 1x2
    for(tx=[-25.68, -20.98, -16.28], ty=[217.56, 212.86, 208.16])
        translate([tx,ty]) mag(); //  center2 3x3
    
    for(ty=[219.51, 209.47])
        translate([27.92,ty]) mag(); // right1 1x2
    for(tx=[32.62, 37.32, 
        //42.02, 46.72, 51.77
    ])
        translate([tx, 220.95]) mag(); // right2 upper 5x1
    for(tx=[31.13, 36.61, 
        //42.08, 47.56, 52.74
    ])
        translate([tx, 205.76]) mag(); // right2 lower 5x1
}

module upper_part() {
    difference() {
        linear_extrude(th) upper_part_centered_plate_2d();
        upper_part_magnets();
    }
}  

//intersection() {
//    lower_part();
//    translate([-15,0,0]) cube([40,50,50], center=true);
//}
lower_part();
translate([0,-150,0]) upper_part();