mr = 40; // margin between the slot and the wall
ml = 20;
sw = 15; // slot width

d = 160; // depth of the extrude
bh = 10; // height below the slot
sh = 25; // height of the slot

module block(bh){
    difference() {
        translate([0,0,-bh-sh]) cube([mr+ml+sw, d, bh+sh]);
        translate([ml,0,-sh]) translate([sw/2,d/2,0]) 
            linear_extrude(height=sh, scale=[1.4,1]) 
                square([sw, d], center=true);
        
        fd = 20; // depth of flat lower part of the stand
        translate([ml+sw+ml,fd, -bh-sh]) cube([mr+ml+sw, d, bh+sh]);
    }
}

block(bh);