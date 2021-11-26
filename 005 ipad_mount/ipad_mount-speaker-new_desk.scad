cd = 25; // claw depth
cth = 4; // claw thickness
bth = 3; // back plate thickness
fsz = 5; // frame size (the ipad blocker in the front)
fth = 2; // frame thickness (the ipad blocker in the front)
sfsz = 2;// support frame size (the one surround ipad)


h = 70;
l = 30;
nsz = 0; // faceid notch size 15

pth = 6.5;// ipad thickness + tolerance
dth = 37.2;// desk thickness + tolerance

module back_plate() {
    translate([0,0,-bth]) cube([h,l,bth]);
    translate([0,0,-(bth+cd)]) cube([cth,l,bth+cd]);
    translate([dth+cth,0,-(bth+cd)]) cube([cth,l,bth+cd]);
}

module front_frame() {
    difference() {
        cube([h,l,pth]);
        translate([-sfsz,sfsz,0]) cube([h,l,pth]);
    }

    translate([0,0,pth]) difference() {
        cube([h,l,fth]);
        $fn=20; translate([-fsz-sfsz,fsz+sfsz,0]) minkowski() {
            rr = 5; // round corner radius
            rd = rr*2;
            translate([rr,rr,0]) cube([h-rd,l-rd,fth]);
            cylinder(r=rr,h=0.001);
        }
        large = 300; translate([0,sfsz,0]) cube([nsz,large,fth]);
    }
}

module speaker_hole(length, large) {
    mirror([0,1,0]) rotate([90,0,0]) translate([pth/2,pth/2,0]) union() { 
        $fn = 20;
        cylinder(d=pth,h=large);
        translate([length/2-pth/2,0,0]) 
            linear_extrude(large) square([length-pth,pth], center=true);
        translate([length-pth,0,0]) cylinder(d=pth,h=large);
    }
}


module ipad_mount() {
    intersection() {
        large = 300;
        union() { back_plate(); front_frame(); }
        $fn=20; translate([0,0,-large]) minkowski() {
            rr = 0; // round corner radius
            rd = rr*2;
            translate([rr-large,rr,0]) cube([h-rd+large,l-rd+large,fth+pth+large]);
            cylinder(r=rr,h=0.001);
        }
    }
}

module ipad_mount_speaker() {
    difference() {
        ipad_mount();
        translate([10,0,0]) speaker_hole(length=33, large=100);
    }
}

rotate([90,0,0]) ipad_mount_speaker();
translate([0,cd*2.5,0]) mirror([0,1,0]) rotate([90,0,0]) ipad_mount_speaker();