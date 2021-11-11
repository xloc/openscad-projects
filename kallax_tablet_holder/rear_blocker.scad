
tw = 35; // tape width
h = 80; // block height

tb = 8; // blocker thickness
tt = 4;  // tape surfaces thickness

kw = 58.8-0.2; // kallax subdivision width - tolerance

rotate([90,0,0]) difference() {
    translate([-kw/2,0,0])cube([kw,tw,h]);

    bdx = kw - tt*2;
    translate([-bdx/2,tb,0])cube([bdx,tw,h]);
}