
eh = 45; // reel height
ed = 100; // reel outer diameter
ei = 15.2; // reel inner diameter - margin

lg = 120;

rotate([90,0,0]) intersection() {
    
    intersection() {
        union() {
            cylinder(d=ei, h=eh, center=true);
            difference() {
                $fn=120;
                cylinder(d=ed+8, h=eh+4, center=true);
                cylinder(d=ed, h=eh, center=true);
                translate([ed/2-1,0,0]) rotate([0,90,0]) cylinder(d=2, h=10);
            }
        }

        cube([lg, 11,lg], center=true);
    }
    
    difference() {
        union() {
            cylinder(d=ei, h=lg, center=true);
            translate([0,-ei/2,-lg/2]) cube([lg,ei,lg]); 
        }
        #cube([ei, ei, 30], center=true);
    }
    
}