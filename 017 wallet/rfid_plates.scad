
cw = 54+0.2; // card width
ch = 85.6+0.2; // card height

bw = 3; // border width

fr = 3; // fillet radius

lg = 1000; // large vaule

ct = 0.6; // case thickness

sw = 25; // slot width
sh = 8; // slot height

module body_2d() {
    polygon([
        [0,0],
        [cw,0],
        [cw,          ch-fr],
        [cw/2+sw/2+fr,ch-fr],
        [cw/2+sw/2+fr,ch-fr-sh],
        [cw/2-sw/2-fr,ch-fr-sh],
        [cw/2-sw/2-fr,ch-fr],
        [0,           ch-fr],
    ]);
}

module body(th){
    difference() {
        minkowski() {
            $fn=20;
            translate([0,fr,0]) linear_extrude(th-0.01) body_2d();
            cylinder(r=fr, h=0.01);
        }
        //translate([-lg/2,-lg,0]) cube([lg,lg,lg]);
        
        translate([cw/2+sw/2-fr,ch-sh+fr,0]) cylinder(h=th, r=fr);
        translate([cw/2-sw/2+fr,ch-sh+fr,0]) cylinder(h=th, r=fr);
        translate([cw/2-sw/2+fr,ch-sh,0]) cube([sw-2*fr,fr,th]);
    }
}

th = 5.5; // plate thickness
st = 4.5; // slot thickness
kw = 72; // slot width
iw = 3; // inset width

difference() {
    body(th);

    #translate([lg/2,4+kw/2,th-st]) 
        linear_extrude(st, scale=[(lg-2*iw)/lg, (kw-2*iw)/kw])
        translate([-lg/2,-kw/2]) square([lg,kw]);
    
}