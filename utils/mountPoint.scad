include <../config.scad>;

// Example:
mountPoint(
  13,
  25,
  15,
  25
);

module mountPoint(
  width,
  height,
  depth,
  slope
) {
  difference() {

    // Main body:
    translate([ 0 - MAGIC, 0, 0 ])
    rotate([ 0, slope, 0 ])
    translate([ -width, height / -2, 0 ])
    union() {

      // Rotated cube that becomes the mount point:
      color("Red")
      cube([ width, height, depth ]);

      // Fill the space that would be left above the rotated cube:
      color("Green")
      rotate([ 0, -slope, 0 ])
      cube([ width, height, depth ]);

    }

    // Chop off parts that would extrude from cover plate:
    translate([ 0, height / -2 - MAGIC, 0 ])
    cube([ width, height + MAGIC * 2, depth * 2 ]);

    translate([ 0 - width + MAGIC, height / -2 - MAGIC, depth ])
    cube([ width, height + MAGIC * 2, depth * 2 ]);

  }

}
