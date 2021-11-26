// A desktop stand for MUJI mechanical pencil


ro = 28; // outer radius

rotate_extrude($fn=100) {
    difference() {
        polygon([
            [1.78, 0],
            [3.8, 9],
            [4.5, 10.2],
            [6, 11.2],
            [6, 18],
            
            [7, 19],
            [ro+2, 19],
            
            
            //[ro, 13],
            //[ro, 0],
            [ro, -3.5],
            [1.78, -3.5],  
        ]);
        //translate([ro, 0]) scale([20,20]) translate([0,1]) circle(r=1);
    }
}