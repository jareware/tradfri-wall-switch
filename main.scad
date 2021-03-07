include <config.scad>;

use <utils/mountPoints.scad>;
use <utils/coverPlate.scad>;
use <utils/puckHolder.scad>;

main();

module main(
  bodyWallThickness = 2.5,
  holderWallThickness = 1.5,
  holderBaseExtraThickness = 6.7,
  puckHeightCoverage = .75, // this needs to be enough to touch the widest point of the puck, to lock it in place
  accessHoleEdgeWidth = 6,
  rounding = 8,
  switchWidth = 84,
  switchHeight = 85, // <units> * 70 + 15 = <total-height>
  switchDepth = 17.5,
  switchPaddingX = 12,
  switchPaddingY = 14,
  mountPointWidth = 25,
  mountPointSlope = 25,
  mountPointRaise = 6,
  fingerHoleDiameter = 25
) {

  translate([ 0, 0, switchDepth ])
  puckHolder(
    bodyWallThickness,
    holderWallThickness,
    holderBaseExtraThickness,
    puckHeightCoverage,
    accessHoleEdgeWidth,
    fingerHoleDiameter
  );

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
    min(switchPaddingX, switchPaddingY), // whichever padding is smaller, use that both horizontally & vertically, for symmetry
    mountPointWidth,
    switchDepth - mountPointRaise,
    mountPointSlope,
    switchWidth,
    switchHeight
  );

}
