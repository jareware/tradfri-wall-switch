include <../config.scad>;

// Example:
puckHolder(
  3.5,
  3.5,
  3,
  .75,
  6,
  25
);

module puckHolder(
  bodyWallThickness,
  holderWallThickness,
  holderBaseExtraThickness,
  puckHeightCoverage,
  accessHoleEdgeWidth,
  fingerHoleDiameter
) {
  difference() {

    // Main body:
    cylinder(
      h = PUCK_THICK * puckHeightCoverage,
      d1 = PUCK_DIAM + holderWallThickness * 2 + holderBaseExtraThickness * 2,
      d2 = PUCK_DIAM + holderWallThickness * 2
    );

    // Carve out space for puck:
    translate([ 0, 0, bodyWallThickness ])
    cylinder(h = PUCK_THICK, d = PUCK_DIAM);

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

}
