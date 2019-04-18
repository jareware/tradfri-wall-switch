include <../config.scad>;

use <roundedCube.scad>;

// Example:
coverPlate(
  5,
  3
);

module coverPlate(
  rounding,
  wallThick,
  switchWidth = 82 + TOLERANCE,
  switchHeight = 82 + TOLERANCE,
  switchDepth = 14.5 + TOLERANCE,
  switchPaddingX = 13 - TOLERANCE,
  switchPaddingY = 15 - TOLERANCE,
  mountPointWidth = 25,
  mountPointRotate = 25,
  mountPointRaise = 2
) {
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
