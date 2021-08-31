include <config.scad>;

use <main.scad>;

switchHeight = (152.5 + 1.5) / 2; // measured + tolerance
rotatePuckHolderDeg = 30;
puckHolderConnectionPackingMagic = 2.5;
mountPointsCenterPacking = 7;
sideMountPointsDepthAdjust = .5; // the sides are a tiny bit higher on the physical wall switch :shrug:

main(
  connectingBottom = true,
  rotatePuckHolderDeg = rotatePuckHolderDeg,
  switchHeight = switchHeight,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);

translate([0, -switchHeight - 2.5 - 15, 0])
main(
  connectingTop = true,
  switchHeight = switchHeight,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);
