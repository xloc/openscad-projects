
cw = 54+0.2; // card width
ch = 85.6+0.2; // card height
bw = 3; // border width

m = 0.1; // plug margin

th = 5.5 - m; // plate thickness
st = 4.5 - m; // slot thickness
kw = 65 - m; // slot width
ks = 0.9; // slot narrowing scale factor

lg = 1000; // large vaule

module plug() {
    translate([-bw,kw/2,0]) linear_extrude(st, scale=[1,ks])
        translate([0,-kw/2]) square([cw+bw,kw]);
}
        
 dw = 34; // bus card width
 ctl = 2; // lower bus card thickness
 ctu = st - ctl; // uppwer bus card thickness
 
 module bus_card_slot() {
     translate([lg/2,dw/2,ctl]) union() {
         mirror([0,0,1]) linear_extrude(ctl, scale=[1,0.9]) 
            square([lg, dw], center=true);
         linear_extrude(ctu, scale=[1,0.9]) 
            square([lg, dw], center=true);
     }
 }
 
 
difference() {
    plug();
    translate([0,3,0]) bus_card_slot();
}

