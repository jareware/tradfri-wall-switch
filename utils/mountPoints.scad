include <../config.scad>;

use <./mountPoint.scad>;

// Example:
mountPoints(
  13,
  25,
  15,
  25,
  75,
  100
);

module mountPoints(
  width,
  height,
  depth,
  slope,
  totalWidth,
  totalHeight,
  skipTop = false,
  skipBottom = false,
  heightWisePacking = 0
) {

  union() {

    color("Red")
    rotate([ 0, 0, 0 ])
    translate([ totalWidth / 2, -heightWisePacking, 0 ])
    mountPoint(
      width,
      height,
      depth,
      slope
    );

    color("Green")
    rotate([ 0, 0, 180 ])
    translate([ totalWidth / 2, heightWisePacking, 0 ])
    mountPoint(
      width,
      height,
      depth,
      slope
    );

    if (!skipTop) {
      color("Blue")
      rotate([ 0, 0, 90 ])
      translate([ totalHeight / 2, 0, 0 ])
      mountPoint(
        width,
        height,
        depth,
        slope
      );
    }

    if (!skipBottom) {
      color("Yellow")
      rotate([ 0, 0, 270 ])
      translate([ totalHeight / 2, 0, 0 ])
      mountPoint(
        width,
        height,
        depth,
        slope
      );
    }

  }

}
