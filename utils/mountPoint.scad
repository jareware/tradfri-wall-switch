include <../config.scad>;

// Example:
mountPoint();

module mountPoint(
  switchWidth = 82 + TOLERANCE,
  switchHeight = 82 + TOLERANCE,
  switchDepth = 14.5 + TOLERANCE,
  switchPaddingX = 13 - TOLERANCE,
  switchPaddingY = 15 - TOLERANCE,
  mountPointWidth = 25,
  mountPointRotate = 25,
  mountPointRaise = 2
) {
  switchPaddingMin = min(switchPaddingX, switchPaddingY); // of the given X/Y paddings, use the smaller one

  difference() {

    // Main body:
    translate([ switchWidth / 2 - MAGIC, 0, mountPointRaise - MAGIC ])
    rotate([ 0, mountPointRotate, 0 ])
    translate([ -switchPaddingMin, mountPointWidth / -2, 0 ])
    union() {
      // Rotated cube that becomes the mount point:
      cube([ switchPaddingMin, mountPointWidth, switchDepth ]);

      // Fill the space that would be left above the rotated cube:
      rotate([ 0, -mountPointRotate, 0 ])
      cube([ switchPaddingMin, mountPointWidth, switchDepth ]);
    }

    // Chop off parts that would extrude from cover plate:
    translate([ switchWidth / 2, mountPointWidth / -2 - MAGIC, 0 ])
    cube([ switchPaddingMin, mountPointWidth + MAGIC * 2, switchDepth * 2 ]);

    translate([ switchWidth / 2 - switchPaddingMin + MAGIC, mountPointWidth / -2 - MAGIC, switchDepth ])
    cube([ switchPaddingMin, mountPointWidth + MAGIC * 2, switchDepth * 2 ]);

  }

}
