kt = 2.2; // key thickness

bw = 26.2+6;  // body width
bh = 52+10;   // body height
bt = kt+0.8*2; // body thickness

lg = 5;


sw = 29; // slider width
sw2 = 26.5; // shrinked slider width
sh = 18.5; // slider height

module scube(x, xs, y, z, center=false) {
    if(center){
        linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    } else {
        translate([x/2,y/2,0])
            linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    }   
}

module key_groove() {
    scale([1,1,lg]) rotate([0,0,-90]) mirror([0,0,1]) mirror([1,0,0]) 
            import("./key_slider.stl");
}


module slider(h) {
    m = 0.2;
     
    difference() {
        translate([-(sw-m)/2,0,0]) 
            scube(xs=sw2-m, x=sw-m, y=sh, z=kt+0.8-m);
        translate([0,0,kt]) key_groove();
    }
}

difference() {
    translate([0,bh/2,bt/2-0.8]) cube([bw, bh, bt], center=true);
    translate([0,(bh-2)/2,0]) linear_extrude(kt+0.8, scale=[sw2/sw,1]) 
        square([sw,bh-2], center=true);
    
    
}

!mirror([0,0,1]) slider();

