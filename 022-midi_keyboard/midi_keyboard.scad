module white_key(ww, wl, bw, bl, mw, mb) {
    // ww/wl: white key width/length
    // bw/bl: black key width/length
    // mw/mb: margin between w&w / b&w keys
    
    difference() {
        for (i=[0:6]) {
            translate([i*(ww+mw)+0.5*mw, 0,0]) cube([ww, wl, 2]);
        }
        
        c = (ww+mb)*3/5;
        for (i=[1.5*c, 3.5*c]) {
            translate([i-bw/2-mb, 0,0]) cube([bw+2*mb, bl+mb, 2]);
        }
        
        c = (ww+mb)*4/7;
        for (i=[1.5*c, 3.5*c, 5.5*c]) {
            translate([(ww+mb)*3+i-bw/2-mb, 0,0]) cube([bw+2*mb, bl+mb, 2]);
        }
        
    }
    
}

module black_key(ww, wl, bw, bl, mw, mb) {
    // ww/wl: white key width/length
    // bw/bl: black key width/length
    // mw/mb: margin between w&w / b&w keys
        
    c = (ww+mb)*3/5;
    for (i=[1.5*c, 3.5*c]) {
        translate([i-bw/2, 0,0]) cube([bw, bl, 2]);
    }
    
    c = (ww+mb)*4/7;
    for (i=[1.5*c, 3.5*c, 5.5*c]) {
        translate([(ww+mb)*3+i-bw/2, 0,0]) cube([bw, bl, 2]);
    }
        

    
}

white_key(ww=12, wl=50, bw=8, bl=30, mw=1, mb=1);
black_key(ww=12, wl=50, bw=8, bl=30, mw=1, mb=1);