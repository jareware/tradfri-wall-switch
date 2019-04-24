include <config.scad>;

use <utils/mountPoints.scad>;
use <utils/coverPlate.scad>;

main();

module main(
  bodyWallThickness = 2.5,
  holderWallThickness = 1.5,
  holderBaseThickness = 6.7,
  puckHeightCoverage = .75, // this needs to be enough to touch the widest point of the puck, to lock it in place
  accessHoleEdgeWidth = 6,
  rounding = 8,
  switchWidth = 84,
  switchHeight = 84,
  switchDepth = 17.5,
  switchPaddingX = 12,
  switchPaddingY = 14,
  switchPaddingMin = min(switchPaddingX, switchPaddingY),
  mountPointWidth = 25,
  mountPointSlope = 25,
  mountPointRaise = 6,
  fingerHoleDiameter = 25
) {

  translate([ 0, 0, switchDepth ])
  difference() {

    // Main body:
    cylinder(
      h = PUCK_THICK * puckHeightCoverage,
      d1 = PUCK_DIAM + holderWallThickness * 2 + holderBaseThickness * 2,
      d2 = PUCK_DIAM + holderWallThickness * 2
    );

    // Carve out space for puck:
    translate([ 0, 0, bodyWallThickness ])
    cylinder(h = PUCK_THICK, d = PUCK_DIAM + 1);

    // Carve out access hole:
    translate([ 0, 0, -MAGIC ])
    cylinder(h = ALOT, d = PUCK_DIAM - accessHoleEdgeWidth * 2);

    // Carve out finger hole:
    translate([
      0,
      PUCK_DIAM / -4,
      max(
        bodyWallThickness + fingerHoleDiameter / 2, // anchor the hole at its bottom edge (when fingerHoleDiameter is LARGE)
        PUCK_THICK * puckHeightCoverage // anchor the hole at its center axis (when fingerHoleDiameter is SMALL)
      )
    ])
    rotate([ 90, 0, 0 ])
    cylinder(d = fingerHoleDiameter, h = PUCK_DIAM / 2);
  }

  difference() {

    // Main body:
    color("SteelBlue")
    coverPlate(
      rounding,
      bodyWallThickness,
      switchWidth,
      switchHeight,
      switchDepth
    );

    // Punch a hole for underlying switch access:
    cylinder(d = PUCK_DIAM, h = ALOT);

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

}
