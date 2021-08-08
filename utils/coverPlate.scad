include <../config.scad>;

use <roundedCube.scad>;

// Example:
coverPlate(
  5,
  3,
  100,
  100,
  15,
  connectingTop = true,
  connectingBottom = true
);

module coverPlate(
  rounding,
  wallThickness,
  switchWidth,
  switchHeight,
  switchDepth,
  connectingTop = false,
  connectingBottom = false,
  connectorDepth = 6,
  connectorPlugD = 4
) {
  difference() {

    // Main body:
    roundedCube(
      switchWidth + wallThickness * 2,
      switchHeight + wallThickness * 2,
      switchDepth + wallThickness,
      r = rounding,
      flatBottom = true,
      center = true,
      flatFront = connectingBottom,
      flatBack = connectingTop
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

    // Connecting top:
    if (connectingTop) {
      translate([ 0, wallThickness + MAGIC, switchDepth / 2 - connectorDepth / 2 - MAGIC ])
      cube([ switchWidth, switchHeight, switchDepth - connectorDepth ], center = true);
    }

    // Connecting bottom:
    if (connectingBottom) {
      translate([ 0, -wallThickness - MAGIC, switchDepth / 2 - connectorDepth / 2 - MAGIC ])
      cube([ switchWidth, switchHeight, switchDepth - connectorDepth ], center = true);
    }

    // Carve out connecting bottom plug holes:
    if (connectingBottom) {
      color("red")
      translate([ switchWidth / 2 - connectorPlugD / 2, -switchHeight / 2 - MAGIC, switchDepth + wallThickness - (connectorDepth + wallThickness) / 2 ])
      rotate([ 90, 0, 0 ])
      cylinder(d = connectorPlugD, h = wallThickness);

      color("green")
      translate([ -switchWidth / 2 + connectorPlugD / 2, -switchHeight / 2 - MAGIC, switchDepth + wallThickness - (connectorDepth + wallThickness) / 2 ])
      rotate([ 90, 0, 0 ])
      cylinder(d = connectorPlugD, h = wallThickness);
    }
  }

  // Add connecting top plugs:
  if (connectingTop) {
    color("red")
    translate([ switchWidth / 2 - connectorPlugD / 2, switchHeight / 2 + wallThickness * 2, switchDepth + wallThickness - (connectorDepth + wallThickness) / 2 ])
    rotate([ 90, 0, 0 ])
    cylinder(d1 = connectorPlugD * .75, d2 = connectorPlugD, h = wallThickness * .9);

    color("green")
    translate([ -switchWidth / 2 + connectorPlugD / 2, switchHeight / 2 + wallThickness * 2, switchDepth + wallThickness - (connectorDepth + wallThickness) / 2 ])
    rotate([ 90, 0, 0 ])
    cylinder(d1 = connectorPlugD * .75, d2 = connectorPlugD, h = wallThickness * .9);
  }
}
