include <../config.scad>;

// Example:
mountPoint(
  0,
  14.5,
  13,
  15,
  25,
  25,
  3
);

module mountPoint(
  switchWidth,
  switchDepth,
  switchPaddingX,
  switchPaddingY,
  mountPointWidth,
  mountPointRotate,
  mountPointRaise
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
