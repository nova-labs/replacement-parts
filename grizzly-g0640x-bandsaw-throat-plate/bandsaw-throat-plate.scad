// Grizzly G0640X Throat Plate
//
// by W. Craig Trader is dual-licensed under 
// Creative Commons Attribution-ShareAlike 3.0 Unported License and
// GNU Lesser GPL 3.0 or later.
//
// ----------------------------------------------------------------------------

include <MCAD/units.scad>;

//  2.725" dia. x 0.155"

DIAMETER  = 2.725 * inch; // 69.44 * mm; 
THICKNESS = 0.155 * inch;

NUB_DIAMETER = 3 * mm;
NUB_HEIGHT   = 2 * mm;
NUB_OFFSET   = 2 * mm;

OVERLAP = 0.01 * mm;

FONT_NAME = "Arial:style=Regular";
FONT_SIZE = 11.0;

$fa=4; $fn=90;

module label(message) {
    // mirror( [0,1,0] )
    text( message, font=FONT_NAME, size=FONT_SIZE, halign="center", valign="center" );
}

module throat_plate( width, offset ) {
    length = DIAMETER - offset;
    radius = DIAMETER / 2;
    
    x1 = radius;
    x2 = x1 + THICKNESS * tan( 45 );
    
    y1 = width/2;
    y2 = y1 + THICKNESS * tan( 45 );
    
    z1 = -OVERLAP;
    z2 = THICKNESS+OVERLAP;
    
    points = [
        [ -x1, -y1, z1 ],   // p0
        [ +x1, -y1, z1 ],   // p1
        [ +x1, +y1, z1 ],   // p2
        [ -x1, +y1, z1 ],   // p3
        [ -x2, -y2, z2 ],   // p4
        [ +x2, -y2, z2 ],   // p5
        [ +x2, +y2, z2 ],   // p6
        [ -x2, +y2, z2 ],   // p7
    ];

    faces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3],  // left
    ];
    
    
    difference() {
        // Plate
        union() {
            cylinder( d=DIAMETER, h=THICKNESS );
            translate( [0,-radius+NUB_OFFSET, THICKNESS-OVERLAP] ) cylinder( d=NUB_DIAMETER, h=NUB_HEIGHT+OVERLAP );
            translate( [0, radius-NUB_OFFSET, THICKNESS-OVERLAP] ) cylinder( d=NUB_DIAMETER, h=NUB_HEIGHT+OVERLAP );
        }
        
        // Slot
        translate( [-radius+length,0,0] ) polyhedron( points, faces );
        
        // Label
        translate( [0,radius/2,THICKNESS+OVERLAP] )
            linear_extrude( height=1*mm+OVERLAP, center=true ) label(str(width, " x ", offset));
    }
}

module throat_plate_assortment() {
    dx=20; dy=20;
    
    translate( [ 2*dx, 2*dy, 0] ) throat_plate( 8, 16 );
    translate( [ 6*dx, 2*dy, 0] ) throat_plate( 7, 18 );
    translate( [10*dx, 2*dy, 0] ) throat_plate( 7, 20 );

    translate( [ 4*dx, 5*dy, 0] ) throat_plate( 6, 18 );
    translate( [ 8*dx, 5*dy, 0] ) throat_plate( 6, 20 );

    translate( [ 2*dx, 8*dy, 0] ) throat_plate( 5, 18 );
    translate( [ 6*dx, 8*dy, 0] ) throat_plate( 5, 20 );
    translate( [10*dx, 8*dy, 0] ) throat_plate( 4, 18 );
}

// throat_plate_assortment();

// Original slot size
// throat_plate( 8, 16 );

// Optimum slot size
throat_plate( 5, 18 );
