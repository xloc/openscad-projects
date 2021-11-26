s = 1.5; // key rail x shift

module scube(x, xs, y, z, center=false) {
    if(center){
        linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    } else {
        translate([x/2,y/2,0])
            linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    }   
}

module key_slot(w, ws, h, th, sw, sth, m=0.1) {
    difference() {
        translate([0,h/2,0]) 
            scube(x=w-2*m, xs=ws-2*m, y=h, z=th-m, center=true);
        
        translate([0,0,0]) 
            linear_extrude(sth) translate([-sw/2, 0]) square([sw, h]);
    
    }
}

module screw_hole(dl, ds, h) {
    large = 100;
    cylinder(h=large, d=ds, $fn=20);
    cylinder(h=h, d1=dl, d2=ds, $fn=20);
    mirror([0,0,1]) cylinder(h=large, d=dl, $fn=20);
}



st = 4;
wm = 26;
wms = 23;
wd = 29;
wds = 26;
m = 0.1;

h = 4.4;

mirror([0,0,1]) difference() {
    union() {
        translate([wm/2+0.8+s,0,0]) // mailbox
            key_slot(w=wm, ws=wms, h=h, th=st, sw=12, sth=2.2); 
        translate([-wd/2-0.8+s,0,0]) // door
            key_slot(w=wd, ws=wds, h=h, th=st, sw=16, sth=2.4); 
        #translate([s,h/2,(st-m)/2]) cube([6, h,st-m], center=true);
    }
    ev = 28.3; // blocker end value = wm/2+0.8+s + wm/2 = -wd/2-0.8+s - wd/2
    translate([+ev-4,h/2,st-1.5]) mirror([0,0,1]) 
        screw_hole(ds=1.5, dl=3, h=1.5);
    translate([-ev+4,h/2,st-1.5]) mirror([0,0,1]) 
        screw_hole(ds=1.5, dl=3, h=1.5);
}

