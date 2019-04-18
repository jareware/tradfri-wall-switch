include <config.scad>;

use <utils/mountPoint.scad>;
use <utils/coverPlate.scad>;

wallThickness = 3.5;
puckHeightCoverage = .55;
accessHoleEdgeWidth = 6;
rounding = 5;

translate([ 0, 0, switchDepth ])
difference() {

  // Main body:
  cylinder(h = PUCK_THICK * puckHeightCoverage + wallThickness, d = PUCK_DIAM + wallThickness * 2);

  // Carve out space for puck:
  translate([ 0, 0, wallThickness ])
  cylinder(h = PUCK_THICK, d = PUCK_DIAM + TOLERANCE);

  // Carve out access hole:
  translate([ 0, 0, -MAGIC ])
  cylinder(h = wallThickness + MAGIC * 2, d = PUCK_DIAM - accessHoleEdgeWidth * 2);

}

switchWidth = 82 + TOLERANCE;
switchHeight = 82 + TOLERANCE;
switchDepth = 14.5 + TOLERANCE;
switchPaddingX = 13 - TOLERANCE;
switchPaddingY = 15 - TOLERANCE;
switchPaddingMin = min(switchPaddingX, switchPaddingY);
mountPointWidth = 25;
mountPointRotate = 25;
mountPointRaise = 8;

difference() {
  color("SteelBlue")
  coverPlate(
    rounding, wallThickness,
    switchWidth = 82 + TOLERANCE,
    switchHeight = 82 + TOLERANCE,
    switchDepth = 14.5 + TOLERANCE
  );

  cylinder(d = PUCK_DIAM + wallThickness * 2, h = ALOT);

  translate([ 0, -65, 0 ])
  cube(100, 50, 50, center = true);

  translate([ 0, 65, 0 ])
  cube(100, 50, 50, center = true);
}

color("SaddleBrown")
mountPoint(
  switchWidth,
  switchDepth,
  switchPaddingX,
  switchPaddingY,
  mountPointWidth,
  mountPointRotate,
  mountPointRaise
);

color("SaddleBrown")
mirror([ 1, 0, 0 ])
mountPoint(
  switchWidth,
  switchDepth,
  switchPaddingX,
  switchPaddingY,
  mountPointWidth,
  mountPointRotate,
  mountPointRaise
);
