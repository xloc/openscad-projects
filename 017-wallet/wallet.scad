th=4.8+0.3; // cards thickness
cw = 54+0.2; // card width
ch = 85.6+0.2; // card height

bw = 3; // border width

fr = 3; // fillet radius

sw = 12; // slot width
sh = 25; // slot height
st = 4; // slot thickness

lg = 1000; // large vaule

ct = 0.8; // case thickness

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

translate([0,0,ct]) union() {
    difference() {
        body(th);
        cube([cw, ch, th]);
    }
    translate([0,0,-ct]) body(ct);
    d = 1.5;
    intersection() {
        translate([-d/2+0.3,d/2,0]) cylinder(d=d, h=th, $fn=30);
        cube([cw, ch, th]);
    }
}