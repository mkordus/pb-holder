$fn=40;
fingerRadius = 11;
fingerGap = 14;
thumbRadius = 12;
thumbGap = 30;
wallThicness = 3;

readerY = 8;
readerX = 137.2;
readerXScreen = 121.0;


module donut(r1, r2) {
    difference () {
        rotate_extrude(r) translate([r1+r2,0,0]) circle(r2);
        translate([0, -r1*4, 0]) cube(r1*8, true);
    }
}

module handle() {
    handleHeight = fingerRadius * 8 + 5;
    handleBackHeight = 4;
    translate ([0,6,6]) difference () {
    rotate ([-8,0,0]) translate ([0,-fingerRadius*2,-handleHeight]) difference () {
            hull() {
                translate([0, fingerRadius*2, 0]) cylinder(r=fingerRadius, h=handleHeight-6);
                translate ([0,5,fingerRadius*handleBackHeight-4]) scale([1,1,handleBackHeight]) sphere(fingerRadius);
                rotate ([8,0,0]) translate([-9, fingerRadius*2-1.3, handleHeight]) cube([18, 1, 10]);
                rotate ([8,0,0]) translate([-9, fingerRadius*2 + readerY -1.3, handleHeight]) cube([18, wallThicness, 40]);
            };
            translate ([0,fingerRadius+6,fingerRadius]) donut(fingerRadius, fingerGap);
            translate ([0,fingerRadius+6,fingerRadius*3]) donut(fingerRadius, fingerGap);
            translate ([0,fingerRadius+6,fingerRadius*5]) donut(fingerRadius, fingerGap);
            translate ([0,fingerRadius+6,fingerRadius*7]) donut(fingerRadius, fingerGap);
        };
    translate([0,0,-handleHeight-50]) cube(100, true);
    }
}

module holder() {
    translate ([0,0,24]) union() {
        hull () {
            translate ([-1,0,0]) cube([2, wallThicness, 20]);
            translate ([readerX/2,0,40]) cube([wallThicness, wallThicness, 20]);
        }
        hull () {
            translate ([readerX/2,0,40]) cube([wallThicness, wallThicness, 20]);
            translate ([readerX/2,-readerY-wallThicness,50]) cube([wallThicness, wallThicness, 20]);
        }
        hull () {
            translate ([readerX/2,-readerY-wallThicness,50]) cube([wallThicness, wallThicness, 20]);
            translate ([readerXScreen/2,-readerY-wallThicness,55]) cube([wallThicness, wallThicness, 20]);
        }
    } 
}

difference () {
    union() {
        handle();
        holder();
        mirror ([1,0, 0]) holder();
    }
    translate([-readerX/2,-readerY-wallThicness +3,20]) cube([readerX, readerY, 90]);
    %translate([-readerX/2,-readerY-wallThicness +3,20]) cube([readerX, readerY, 90]);

}
