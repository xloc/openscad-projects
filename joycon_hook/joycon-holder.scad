// x-axis: 5, 3, 32, 3
// y-axis: 50, 10, 5
// z-axis: 35

module hanger(round_r) {
    r = round_r;
    $fn = 20;
    minkowski()
    {
        linear_extrude(height=35-r) polygon([
            [r,r], [43-r,r], [43-r,10-r],
            [40+r,10-r], [40+r,5-r], [8-r,5-r], [8-r,10-r], [5-r,10-r],
            [5-r,50-r], [r,50-r]]);
        
        cylinder(r=r,h=1);
    }
}

module fillet() {
    translate([8,5]) scale([1,2,6]) rotate([0,90,0]) cylinder(h=32,r=1,$fn=4);
}

difference() {
    hanger(round_r=1);
    
    translate([0,0,0]) fillet();
    translate([0,0,35]) fillet();
    
}