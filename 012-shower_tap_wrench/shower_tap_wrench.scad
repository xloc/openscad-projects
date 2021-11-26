he = 9; // height of the end of the tap
ho = 20; // height of the octogram cylinder
do = 58.4; // diameter of the octogram inscribed circle 54/cos(360/16)
aa = 360/16; // rotation for alignment
wb = 30; // width of the bar
lb = 90; // length of the bar to the center
rb = 8; // fillet radius of the bar
echo(do);

difference() {
    union() { 
        minkowski(){
            $fn=20;
            cylinder(h=1e-14, r=8);
            rotate([0,0,aa]) cylinder(h=he+ho, d=55, $fn=8);
        }
        minkowski() {
            $fn=20;
            cylinder(h=1e-14, r=rb);
            translate([-wb/2+rb,0,0]) cube([wb-2*rb,lb,he+ho]);
        }
    }
    union() {
        rotate([0,0,aa]) cylinder(h=ho, d=do, $fn=8);
        translate([0,0,ho]) cylinder(h=he, d=40.9);
    }
}