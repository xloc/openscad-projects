module ball_joint(d, th, gap) {
    $fn=80;
    od = d+gap+th;
    translate([0,0,od/2]) difference() {
        union() {
            difference() {
                union() {
                    sphere(d=od);
                    mirror([0,0,1]) cylinder(d=od, h=od/2);
                }
                sphere(d=d+gap);
                translate([0,0,od*0.25]) 
                    linear_extrude(od) square([od,od], center=true);
                translate([0,0,-od/2]) cylinder(d=od/2, h=od/2);
            }
            
            sphere(d=d);
            cylinder(d=d*0.4, h=d, $fn=6);
        }
        translate([0,0,-od/2]) cylinder(d=od/2, h=gap+th);
    }
    
}

$fn=30;
ball_joint(40, 3, 0.6);

// loose: ball bottom, gap=0.5