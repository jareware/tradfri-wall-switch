use <utils/roundedCube.scad>;

$fn = 100;

MAGIC = 0.01;
LOOSEN_BY = 1;
PUCK_DIAM = 68.3;
PUCK_THICK = 18.6;

wallThick = 3.5;
puckHeightCoverage = .55;
accessHoleEdgeWidth = 6;
rounding = 5;

*difference() {

  // Main body:
  cylinder(h = PUCK_THICK * puckHeightCoverage + wallThick, d = PUCK_DIAM + wallThick * 2);

  // Carve out space for puck:
  translate([ 0, 0, wallThick ])
  cylinder(h = PUCK_THICK, d = PUCK_DIAM + LOOSEN_BY);

  // Carve out access hole:
  translate([ 0, 0, -MAGIC ])
  cylinder(h = wallThick + MAGIC * 2, d = PUCK_DIAM - accessHoleEdgeWidth * 2);

}

switchWidth = 82 + LOOSEN_BY;
switchHeight = 82 + LOOSEN_BY;
switchDepth = 14.5 + LOOSEN_BY;
switchPaddingX = 13 - LOOSEN_BY;
switchPaddingY = 15 - LOOSEN_BY;
switchPaddingMin = min(switchPaddingX, switchPaddingY);
mountPointWidth = 25;
mountPointRotate = 25;
mountPointRaise = 2;

module coverPlate() {

  color("SteelBlue")
  difference() {

    // Main body:
    roundedCube(
      switchWidth + wallThick * 2,
      switchHeight + wallThick * 2,
      switchDepth + wallThick,
      r = rounding,
      flatBottom = true,
      center = true
    );

    // Carve out space for the switch:
    translate([ 0, 0, -MAGIC ])
    roundedCube(
      switchWidth,
      switchHeight,
      switchDepth,
      r = rounding,
      flatBottom = true,
      center = true
    );

  }

}

module mountPoint() {

  color("SaddleBrown")
  difference() {

    // Main body:
    translate([ switchWidth / 2 - MAGIC, 0, mountPointRaise - MAGIC ])
    rotate([ 0, mountPointRotate, 0 ])
    translate([ -switchPaddingMin, mountPointWidth / -2, 0 ])
    union() {
      // Rotated cube that becomes the mount point:
      cube([ switchPaddingMin, mountPointWidth, switchDepth ]);

      // Fill the space that would be left above the rotated cube:
      rotate([ 0, -mountPointRotate, 0 ])
      cube([ switchPaddingMin, mountPointWidth, switchDepth ]);
    }

    // Chop off parts that would extrude from cover plate:
    translate([ switchWidth / 2, mountPointWidth / -2, 0 ])
    cube([ switchPaddingMin, mountPointWidth, switchDepth * 2 ]);

    translate([ switchWidth / 2 - switchPaddingMin, mountPointWidth / -2, switchDepth ])
    cube([ switchPaddingMin, mountPointWidth, switchDepth * 2 ]);

  }

}

difference() {
  coverPlate();

  translate([ 0, -65, 0 ])
  cube(100, 50, 50, center = true);

  translate([ 0, 65, 0 ])
  cube(100, 50, 50, center = true);
}

mountPoint();

mirror([ 1, 0, 0 ])
mountPoint();
