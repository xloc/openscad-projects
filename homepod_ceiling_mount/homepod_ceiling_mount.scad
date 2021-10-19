d = 160; // outer diameter of the part mount onto the ceiling
ds = 77; // mounting hole position in diameter

dsh = 4.5; // screw hole diameter
dsth = 9; // screw through hole diameter

rp = 50; // radius of the screw pre-holes

hb = 12; // additional base plate height

bw = 44; // width of the adapter box;
bd = 91; // longer width of the adapter box
bh = 33; // adapter box height

module screw_hole(l=dsth) {
    large=100;
    $fn=30;
    tw = 3; // transition width
    
    cylinder(d=dsth, h=large);
    translate([-dsth/2,0,0]) cube([dsth,l,large]);
    
    translate([0,l,-large]) cylinder(d=dsth, h=large*2);
    
    rotate([180,0,0]) cylinder(d=dsh, h=large);
    
    hh = dsth/2;
    translate([0,0,-large]) linear_extrude(large)
        polygon([
            [-dsh/2,0],       [-dsh/2,l-hh-tw/2], 
            [-dsth/2,l-hh+tw/2], [-dsth/2,l],
            [dsth/2,l],       [dsth/2,l-hh+tw/2], 
            [dsh/2,l-hh-tw/2],   [dsh/2,0],
        ]);
    
    //translate([-dsth/2,dsth/2,-large]) cube([dsth,l-dsth/2,large]);    
    //translate([-dsh/2,0,-large]) cube([dsh,l,large]);
    
    
}

module ac_hole() {
    w = 15;
    d = 9;
    h = bh+hb;
    translate([-w/2,-d,0]) cube([w, d, h]);
}

module usb_hole() {
    w = 18;
    d = 32;
    translate([-w/2,0,hb+9]) cube([w, d, 100]);
}

module pre_holes() {
    tb = 5; // thickness margin to the bottom plane
    for(deg=[0,90,180,270]){
        rotate([0,0,deg]) rotate([0,0,45]) translate([0,rp,0]) union() {
            translate([0,0,tb]) cylinder(h=hb+bh, d=3, $fn=8);
            translate([0,0,hb+bh]) rotate([180,0,0]) 
                cylinder(d1=6,d2=3,h=4, $fn=16);
        }
    }
}
module body() {
    difference() {
        cylinder(h=bh+hb, d=d, $fn=80);
        
        translate([0,-8,0]) union() {
            translate([0,0,hb]) 
                linear_extrude(bh+1) square([bw, bd], center=true);
            translate([0,-bd/2,0]) ac_hole();
            translate([0,bd/2,0]) usb_hole();
        }
        
        pre_holes();
        translate([-ds/2,0,hb]) screw_hole();
        translate([ds/2,0,hb]) screw_hole();
    }
}

large = 200;

// semicircle half
*difference() {
    body();
    translate([-large,20,-large]) cube([2*large, 2*large, 2*large]);
}

*intersection() {
    body();
    translate([0,0,8]) linear_extrude(6) 
        square([large*2, large*2], center=true);
}

body();