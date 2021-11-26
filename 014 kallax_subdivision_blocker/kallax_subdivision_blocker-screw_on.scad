module screw_hole() {
    large = 100;
    cylinder(h=large, d=3.6, $fn=20);
    cylinder(h=3.2, d1=6.6, d2=3.6, $fn=20);
}


mirror([0,0,1]) difference() {
    linear_extrude(6) square([12,30], center=true);
    screw_hole();
}