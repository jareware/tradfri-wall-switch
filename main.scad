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
  fingerHoleDiameter = 25,
  connectingTop = false,
  connectingBottom = false,
  rotatePuckHolderDeg = 0,
  puckHolderConnectionPackingMagic = 0,
  mountPointsCenterPacking = 0,
  sideMountPointsDepthAdjust = 0
) {
  connectionAdjustY = // move the puck holder (and its hole) slightly off-center as needed, to compensate for connections/rounding
    !connectingTop && connectingBottom ? (rounding + puckHolderConnectionPackingMagic) / -2 :
    connectingTop && !connectingBottom ? (rounding + puckHolderConnectionPackingMagic) / +2 :
    0;

  // Puck holder:
  difference() {
    translate([ 0, connectionAdjustY, switchDepth ])
    rotate([ 0, 0, rotatePuckHolderDeg ])
    puckHolder(
      bodyWallThickness,
      holderWallThickness,
      holderBaseExtraThickness,
      puckHeightCoverage,
      accessHoleEdgeWidth,
      fingerHoleDiameter
    );

    // If the puck holder would stick out of a connecting end, chop the excess off:
    connectingBoth = connectingTop && connectingBottom;
    if (connectingTop) {
      translate([ 0, (switchHeight + (connectingBoth ? 0 : bodyWallThickness / 2)) * +1, 0 ])
      cube([ switchWidth / 2, switchHeight, ALOT ], center = true);
    }
    if (connectingBottom) {
      translate([ 0, (switchHeight + (connectingBoth ? 0 : bodyWallThickness / 2)) * -1, 0 ])
      cube([ switchWidth / 2, switchHeight, ALOT ], center = true);
    }
  }

  // Main body:
  difference() {
    color("SteelBlue")
    coverPlate(
      rounding,
      bodyWallThickness,
      switchWidth,
      switchHeight,
      switchDepth,
      connectingTop = connectingTop,
      connectingBottom = connectingBottom
    );

    // Punch a hole for underlying switch access:
    translate([ 0, connectionAdjustY, switchDepth - MAGIC * 2 ])
    cylinder(d = PUCK_DIAM, h = ALOT);
  }

  // Mount points:
  color("SaddleBrown")
  translate([ 0, 0, mountPointRaise - MAGIC ])
  mountPoints(
    min(switchPaddingX, switchPaddingY), // whichever padding is smaller, use that both horizontally & vertically, for symmetry
    mountPointWidth,
    switchDepth - mountPointRaise,
    mountPointSlope,
    switchWidth,
    switchHeight,
    skipTop = connectingTop,
    skipBottom = connectingBottom,
    heightWisePacking =
      !connectingTop && connectingBottom ? +mountPointsCenterPacking :
      connectingTop && !connectingBottom ? -mountPointsCenterPacking :
      0,
    sideDepthAdjust = sideMountPointsDepthAdjust
  );
}
