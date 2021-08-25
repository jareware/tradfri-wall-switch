include <config.scad>;

use <main.scad>;

switchHeight = 152.5/2;
rotatePuckHolderDeg = 30;
puckHolderConnectionPackingMagic = 2.5;
mountPointsCenterPacking = 7;
sideMountPointsDepthAdjust = 1.5; // the sides are a bit higher on the physical wall switch :shrug:

main(
  connectingBottom = true,
  rotatePuckHolderDeg = rotatePuckHolderDeg,
  switchHeight = switchHeight,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);

translate([0, -78.76 - 10, 0])
main(
  connectingTop = true,
  switchHeight = switchHeight,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);
