di = 4.5; // inner (screw hole) diameter (with margin)
dh = 9; // screw head diameter (with margin)
do = 18; // outer diameter

h1 = 2.5; // solid part height
h2 = 1; // screw head slot height

large = 100;

mirror([0,0,1]) difference() {
    cylinder(d=do, h=h1+h2, $fn=6);
    cylinder(d=di, h=large, center=true, $fn=20);
    translate([-di/2,0,-large]) cube([di, large, 2*large]);
    cylinder(d=dh, h=h2);
}