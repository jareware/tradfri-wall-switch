include <config.scad>;

use <main.scad>;

switchHeight = 152.5/2;
rotatePuckHolderDeg = 30;
puckHolderConnectionPackingMagic = 2.5;
mountPointsCenterPacking = 7;

main(
  connectingBottom = true,
  rotatePuckHolderDeg = rotatePuckHolderDeg,
  switchHeight = switchHeight,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking
);

translate([0, -78.76 - 10, 0])
main(
  connectingTop = true,
  switchHeight = switchHeight,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking
);
