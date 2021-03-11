include <config.scad>;

use <utils/mountPoints.scad>;
use <utils/coverPlate.scad>;
use <utils/puckHolder.scad>;

main();

module main(
  bodyWallThickness = 2.5,
  holderWallThickness = 1,
  holderBaseExtraThickness = 3,
  puckHeightCoverage = .675, // this needs to be enough to touch the widest point of the puck, to lock it in place
  accessHoleEdgeWidth = 6,
  rounding = 5.5,
  switchWidth = 82.5,
  switchHeight = 82.5,
  switchDepth = 17.5,
  switchPaddingX = 12,
  switchPaddingY = 14,
  mountPointWidth = 25,
  mountPointSlope = 25,
  mountPointRaise = 5.5, // this controls where the cover plate sits: too high a value and the mount points don't touch the sides of the switch; too low a value and there's an akward gap between the cover plate and the wall
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
