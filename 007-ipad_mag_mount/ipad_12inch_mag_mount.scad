th = 3.0;
lg = 500;
plg = 150;

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
    linear_extrude(3.0) square(3.9, center=true);
}

module slot(dx, dy) {
    sd = 3; // shrink dimension
    
//    translate([dx/2, dy/2])
//    linear_extrude(th, scale=[(dx-sd*2)/dx, (dy-sd*2)/dy])
//        square([dx, dy], center=true);
    
    linear_extrude(th, scale=[dx/(dx-sd*2), dy/(dy-sd*2)])
        square([dx-sd*2, dy-sd*2], center=true);
    
}

// ipad 11inch dimension: 178.52 x 247.64 mm
// ipad 12.9inch dimension: 215.00 x 280.66 mm
// smart connector dimensions are the same
// smart connector center plate to the closest edge distance: 10 + 3.4/2 = 11.7mm

module lower_part_centered_plate_2d() {
    mirror([1,0,0]) translate([-215.00/2,-11.7]) difference() {
        square([143, plg]);
        rotate(180) corner();
    }
}

module upper_part_centered_plate_2d() {
    w = plg;// plate width
    mirror([1,0,0]) translate([-215.00/2,280.66-11.7-w]) difference() {
        square([143, w]);
        translate([0,w]) mirror([0,1]) difference() {
            c = 33; // cut square side length
            r = 6;
            square(c);
            translate([c-13.41,c-13.41]) polygon([[13.41, 0.0], [13.41, 1.11], [13.41, 2.24], [13.41, 3.4], [13.42, 4.61], [13.39, 5.87], [13.24, 7.16], [12.92, 8.44], [12.39, 9.65], [11.65, 10.73], [10.73, 11.65], [9.65, 12.39], [8.44, 12.92], [7.16, 13.24], [5.87, 13.39], [4.61, 13.42], [3.4, 13.41], [2.24, 13.41], [1.11, 13.41], [0.0, 13.41], [13.41,13.41]]);
            
            //mirror([0,1]) rotate(180) corner();
        }
    }
}

module lower_part_magnets() {
    for(ty=[20.72, 16.02, 11.32])
        translate([102.65,ty]) mag(); // right-most 1x3  
    
    for (tx=[69.79, 74.45, 79.15, 83.65, 88.55, 93.25, 97.95], ty=[20.72, 16.02, 11.32, 6.62])
        translate([tx,ty]) mag(); // right 4x7
    
    // import numpy as np; np.linspace(36.89, 65.09, 7)
    for (tx=[36.89, 41.59, 46.29, 50.99, 55.69, 60.39, 65.09])
        translate([tx, 20.72]) mag(); // right 7x1
    
    for(ty=[20.72, 16.02, 11.32, 6.62])
        translate([32.19,ty]) mag(); // right-most 1x4 
    
    for (tx=[-30.84, -26.21, -21.51, -21.51+4.7], ty=[21.21, 16.51, 11.81, 7.11])
        translate([tx,ty]) mag(); // left 4x4
}

module lower_part(){
    difference() {
        linear_extrude(th) lower_part_centered_plate_2d();
        #lower_part_magnets();
        
        center_part();
    }
}

//lower_part();

module upper_part_magnets() {
    for (tx=[-30.91, -26.21, -21.51, -21.57+4.7], ty=[235.83, 240.53, 245.23, 249.93])
        translate([tx,ty]) mag(); // 4x4
    
    for(ty=[237.18, 241.88, 246.58, 251.28])
        translate([32.19,ty]) mag(); // 1x4 
    
    // import numpy as np; np.linspace(37.47, 65.87, 7)
    for (tx=[37.47, 42.20, 46.94, 51.67, 56.4, 61.14, 65.87])
        translate([tx, 237.18]) mag(); // right 7x1
    
    for(ty=[237.18, 241.88, 246.58, 251.28])
        translate([70.57,ty]) mag(); // 1x4 
}

module center_part(mx=0, my=0) {
    translate([0,0,0]) translate([0,280.66/2-11.7,0]) difference() {
        union() {
            translate([0,0,0]) slot(30-2*mx, 150-2*my);
            translate([70,0,0]) slot(30-2*mx, 150-2*my);
            intersection() {
                slot(lg, 80-2*my);
                linear_extrude(th) mirror([1,0,0]) translate([-215.00/2, -200]) square([143, 400]);
            }
        }
        cylinder(d=55, h=th, $fn=100);
    }
}

module upper_part() {
    difference() {
        linear_extrude(th) upper_part_centered_plate_2d();
        #upper_part_magnets();
        
        center_part();
    }
}  

lower_part();
//translate([0,-150,0]) 

//upper_part();

// intersection() {
    
// center_part(0.2, 0.2);
// // translate([0,70,0]) cube([50, 50, 50], center=true);
// }