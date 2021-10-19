module screw_hole() {
    large = 100;
    cylinder(h=large, d=3.6, $fn=20);
    cylinder(h=3.4, d1=7, d2=3.6, $fn=20);
}

h = 12;

difference() {
    linear_extrude(h) square([9.78*2,30], center=true);
    screw_hole();
    
    translate([0,0,h-2]) cylinder(h=100, d=8, $fn=30);
}