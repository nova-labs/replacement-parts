include <MCAD/units.scad>;

HOLE_DIAMETER = 3.4 * inch;
LIP_DIAMETER  = 4.5 * inch;
THICKNESS     = 1 * mm;
HEIGHT        = 1 * inch;
OVERLAP       = 0.01 * mm;

$fa=1;


difference() {
    union() {
        cylinder(d=HOLE_DIAMETER,h=HEIGHT);
        cylinder(d=LIP_DIAMETER,h=THICKNESS);
    }
    translate( [0,0,THICKNESS-OVERLAP] )
        cylinder(d=HOLE_DIAMETER-2*THICKNESS,h=HEIGHT+OVERLAP);
}