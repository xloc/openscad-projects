module scube(x, xs, y, z, center=false) {
    if(center){
        linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    } else {
        translate([x/2,y/2,0])
            linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    }   
}

module key_slot(w, ws, h, th, m=0, lr=1, bp=18.5) {
    // lr is blocker left or right = 1 or -1
    // bp blocker position. should = slider.h
    *mirror([0,0,1]) translate([0,h/2,0]) 
        scube(xs=w, x=ws, y=h, z=th, center=true);
    
    
    mirror([0,0,1]) intersection() {
        difference() {
            translate([0,h/2,0]) 
                scube(xs=w-2*m, x=ws-2*m, y=h, z=th-m, center=true);
            
            #translate([lr*(w/2-0.3),h-bp,0]) 
                mirror([lr==1?0:1,0,0]) mirror([0,1,0]) cube([10,5,th]);
        }
        r = 4+m;
        minkowski() {
            translate([-w/2+r,-h+r,0]) cube([w-2*r,h*2-2*r,th-0.01]);
            cylinder(h=0.01, r=r, $fn=20);
        }
            
    }
    
}


th=4+0.3; // cards thickness
cw = 54+0.2; // card width
ch = 85.6+0.2; // card height

bw = 3; // border width

fr = 3; // fillet radius

sw = 12; // slot width
sh = 25; // slot height
st = 4; // slot thickness

lg=100;

module body_2d() {
    polygon([
        [0,0],
        [cw,0],
        [cw,ch-fr],
        [sw,ch-fr],
        [sw,ch-fr-sh],
        [0, ch-fr-sh],
    ]);
}

module body(th){
    $fn=20;
    union() {
        minkowski() {
            
            translate([0,fr,0]) linear_extrude(th-0.01) body_2d();
            cylinder(r=fr, h=0.01);
        }
        //translate([-lg/2,-lg,0]) cube([lg,lg,lg]);
        
        translate([sw-fr*2,ch-fr-sh+fr*3,0]) difference() {
            translate([0,-fr,0]) linear_extrude(th) square(fr);
            cylinder(h=th, r=fr);
        }
    }
}

fth = 5.5;
pth = fth+0.6; // plate thickness

module fob(th) {
    ss = 1.000;
    scale([ss,ss,fth]) import("./fob.stl");
}





s = 1.5; // key rail x shift

module key_rail_blocker_mask() {
    #translate([-10/2+s,0,-st]) cube([10,4.6,st]);
    
    ev = 28.3; // blocker end value = wm/2+0.8+s + wm/2 = -wd/2-0.8+s - wd/2
    h = 4.4;
    m = 0.1;
    $fn=6;
    translate([+ev-4,h/2+m,0]) mirror([0,0,1]) 
        cylinder(d=1.5, h=lg, center=true);
    translate([-ev+4,h/2+m,0]) mirror([0,0,1]) 
        cylinder(d=1.5, h=lg, center=true);
}

difference() {
    translate([-(cw)/2,0,-pth]) body(pth);
    translate([13+0.8+s,0,0])    
        key_slot(w=26, ws=23, h=50, th=st, lr=-1); // mailbox
    translate([-14.5-0.8+s,0,0]) 
        key_slot(w=29, ws=26, h=58, th=st, lr=+1); // door
    
    translate([13,70.5,0]) rotate([0,0,0]) fob(fth);
    
    key_rail_blocker_mask();

}