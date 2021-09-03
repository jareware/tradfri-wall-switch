include <config.scad>;

use <main.scad>;

switchHeight = (223 + 1.5) / 3; // measured + tolerance
rotatePuckHolderDeg = 30;
puckHolderConnectionPackingMagic = 2.5;
mountPointsCenterPacking = 7;
sideMountPointsDepthAdjust = .5; // the sides are a tiny bit higher on the physical wall switch :shrug:
centerPartHeightReduction = 7;
partSeparation = 15; // set to 0 to print a fused model

main(
  connectingBottom = true,
  rotatePuckHolderDeg = rotatePuckHolderDeg,
  switchHeight = switchHeight + centerPartHeightReduction / 2,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);

translate([0, -switchHeight - 2 - partSeparation, 0])
main(
  connectingTop = true,
  connectingBottom = true,
  rotatePuckHolderDeg = rotatePuckHolderDeg,
  switchHeight = switchHeight - centerPartHeightReduction,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);

translate([0, (-switchHeight - 2 - partSeparation) * 2, 0])
main(
  connectingTop = true,
  switchHeight = switchHeight + centerPartHeightReduction / 2,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);
