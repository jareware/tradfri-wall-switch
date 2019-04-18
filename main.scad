include <config.scad>;

use <utils/roundedCube.scad>;
use <utils/mountPoint.scad>;

wallThick = 3.5;
puckHeightCoverage = .55;
accessHoleEdgeWidth = 6;
rounding = 5;

*difference() {

  // Main body:
  cylinder(h = PUCK_THICK * puckHeightCoverage + wallThick, d = PUCK_DIAM + wallThick * 2);

  // Carve out space for puck:
  translate([ 0, 0, wallThick ])
  cylinder(h = PUCK_THICK, d = PUCK_DIAM + TOLERANCE);

  // Carve out access hole:
  translate([ 0, 0, -MAGIC ])
  cylinder(h = wallThick + MAGIC * 2, d = PUCK_DIAM - accessHoleEdgeWidth * 2);

}

switchWidth = 82 + TOLERANCE;
switchHeight = 82 + TOLERANCE;
switchDepth = 14.5 + TOLERANCE;
switchPaddingX = 13 - TOLERANCE;
switchPaddingY = 15 - TOLERANCE;
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

difference() {
  coverPlate();

  translate([ 0, -65, 0 ])
  cube(100, 50, 50, center = true);

  translate([ 0, 65, 0 ])
  cube(100, 50, 50, center = true);
}

color("SaddleBrown")
mountPoint();

color("SaddleBrown")
mirror([ 1, 0, 0 ])
mountPoint();
