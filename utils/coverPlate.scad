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
  connectorPlugD = 4,
  connectorPlugTolerance = .85,
  connectorPlugShorten = .75
) {
  // If we're making a connecting bit, subtract one or two wallThickness(es) from the height as needed:
  switchHeight =
    (connectingTop && !connectingBottom || !connectingTop && connectingBottom) ? switchHeight - wallThickness :
    connectingTop && connectingBottom ? switchHeight - wallThickness * 2 :
    switchHeight
    ;

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
      translate([
        switchWidth / 2 - connectorPlugD / 2,
        -switchHeight / 2 - MAGIC,
        switchDepth + wallThickness - (connectorDepth + wallThickness) / 2
      ])
      rotate([ 90, 0, 0 ])
      cylinder(d = connectorPlugD, h = wallThickness);

      color("green")
      translate([
        -switchWidth / 2 + connectorPlugD / 2,
        -switchHeight / 2 - MAGIC,
        switchDepth + wallThickness - (connectorDepth + wallThickness) / 2
      ])
      rotate([ 90, 0, 0 ])
      cylinder(d = connectorPlugD, h = wallThickness);
    }
  }

  // Add connecting top plugs:
  if (connectingTop) {
    color("red")
    translate([
      switchWidth / 2 - connectorPlugD / 2,
      switchHeight / 2 + wallThickness * 2 - wallThickness,
      switchDepth + wallThickness - (connectorDepth + wallThickness) / 2
    ])
    rotate([ -90, 0, 0 ])
    cylinder(
      d1 = connectorPlugD * connectorPlugTolerance,
      d2 = connectorPlugD * connectorPlugTolerance,
      h = wallThickness * connectorPlugShorten
    );

    color("green")
    translate([
      -switchWidth / 2 + connectorPlugD / 2,
      switchHeight / 2 + wallThickness * 2 - wallThickness,
      switchDepth + wallThickness - (connectorDepth + wallThickness) / 2
    ])
    rotate([ -90, 0, 0 ])
    cylinder(
      d1 = connectorPlugD * connectorPlugTolerance,
      d2 = connectorPlugD * connectorPlugTolerance,
      h = wallThickness * connectorPlugShorten
    );
  }
}
