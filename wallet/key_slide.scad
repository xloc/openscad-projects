module scube(x, xs, y, z, center=false) {
    if(center){
        linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    } else {
        translate([x/2,y/2,0])
            linear_extrude(z, scale=[xs/x,1]) square([x,y], center=true);
    }   
}

module key_slot(w, ws, h, th, m=0.1) {
    intersection() {
        translate([0,h/2,0]) 
            scube(xs=w-2*m, x=ws-2*m, y=h, z=th-m, center=true);
        r = 4+m;
        #minkowski() {
            translate([-w/2+r,r,0]) cube([w-2*r,h-2*r,th-0.01]);
            cylinder(h=0.01, r=r, $fn=20);
        }
            
    }
}

module anti_slip(w, h, th){
    translate([0,0,th/2]) cube([w, 1, th], center=true);
    translate([0,h/2,th/2]) cube([w, 1, th], center=true);
    translate([0,-h/2,th/2]) cube([w, 1, th], center=true);
    
    
}

st = 4;
lg = 10;
h = 18.5;
aw = 12;
ah = 4;
translate([-30,0,0]) difference() {
    // mailbox

    key_slot(w=26, ws=23, h=h, th=st); 
    translate([0,0,st-2]) scale([1,1,lg]) rotate([0,0,-90]) mirror([1,0,0]) 
        import("./key_slider-mailbox.stl");
    
    translate([0,h/2,0]) anti_slip(aw,ah,1);
}
difference() {
    // door
    translate([0,0,0]) key_slot(w=29, ws=26, h=h, th=st); 
    translate([0,0,st-2.2]) scale([1,1,lg]) rotate([0,0,-90]) mirror([1,0,0]) 
        import("./key_slider.stl");
    
    translate([0,h/2,0]) anti_slip(aw,ah,1);
}