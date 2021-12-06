// to lift ipad up and fit my eye level when lying down

wt = 2; // wall thickness
px = 215 + 0.4; // ipad x dim
pz = 6.4 + 0.4; // ipad z dim
bt = 8; // bezzle thickness

epy = 50; // extender ipad y dim 
ey = 70; // extended y dim

lg = 200;

// calculated dims ============
ax = px + 2*wt; // all x dim


rotate([90,0,0]) union() {
    difference() {
        translate([-ax/2,0,0]) cube([ax, epy, pz + 2*wt]);
        translate([-px/2,0,wt]) cube([px, epy, pz]);
        bx = px-2*bt; // bezzle cutting x dim
        translate([-bx/2, bt, -lg/2]) cube([bx, lg, lg]);
    }

    mirror([0,1,0]) translate([-ax/2,0,0]) cube([ax, ey, pz + 2*wt]);
}