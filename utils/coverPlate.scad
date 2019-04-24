include <../config.scad>;

use <roundedCube.scad>;

// Example:
coverPlate(
  5,
  3,
  100,
  100,
  15
);

module coverPlate(
  rounding,
  wallThickness,
  switchWidth,
  switchHeight,
  switchDepth
) {
  difference() {

    // Main body:
    roundedCube(
      switchWidth + wallThickness * 2,
      switchHeight + wallThickness * 2,
      switchDepth + wallThickness,
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
      r = max(rounding - wallThickness, 0),
      flatBottom = true,
      center = true
    );

  }

}
