include <config.scad>;

use <main.scad>;

main(
  switchHeight = 152.5/2,
  connectingBottom = true,
  rotatePuckHolderDeg = 30,
  puckHolderConnectionPackingMagic = 2.5
);

translate([0, -78.76 - 10, 0])
main(
  switchHeight = 152.5/2,
  connectingTop = true,
  puckHolderConnectionPackingMagic = 2.5
);

// // Verification cube:
// translate([0, -115.5, 0])
// #cube([10, 152.5, 50]);
