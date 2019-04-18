include <config.scad>;

use <utils/mountPoints.scad>;
use <utils/coverPlate.scad>;

wallThickness = 3.5;
puckHeightCoverage = .55;
accessHoleEdgeWidth = 6;
rounding = 5;
switchWidth = 83;
switchHeight = 83;
switchDepth = 17.5;
switchPaddingX = 12;
switchPaddingY = 14;
switchPaddingMin = min(switchPaddingX, switchPaddingY);
mountPointWidth = 25;
mountPointSlope = 25;
mountPointRaise = 6;

translate([ 0, 0, switchDepth ])
difference() {

  // Main body:
  cylinder(h = PUCK_THICK * puckHeightCoverage + wallThickness, d = PUCK_DIAM + wallThickness * 2);

  // Carve out space for puck:
  translate([ 0, 0, wallThickness ])
  cylinder(h = PUCK_THICK, d = PUCK_DIAM + 1);

  // Carve out access hole:
  translate([ 0, 0, -MAGIC ])
  cylinder(h = wallThickness + MAGIC * 2, d = PUCK_DIAM - accessHoleEdgeWidth * 2);

}

difference() {
  color("SteelBlue")
  coverPlate(
    rounding, wallThickness,
    switchWidth,
    switchHeight,
    switchDepth
  );

  cylinder(d = PUCK_DIAM + wallThickness * 2, h = ALOT);

}

color("SaddleBrown")
translate([ 0, 0, mountPointRaise - MAGIC ])
mountPoints(
  switchPaddingMin,
  mountPointWidth,
  switchDepth - mountPointRaise,
  mountPointSlope,
  switchWidth,
  switchHeight
);
