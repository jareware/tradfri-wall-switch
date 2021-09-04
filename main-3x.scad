include <config.scad>;

use <main.scad>;

switchHeight = (223 + 1.5) / 3; // measured + tolerance
bodyWallThickness = 2.5;
rotatePuckHolderDeg = 30;
puckHolderConnectionPackingMagic = 2.5;
mountPointsCenterPacking = 7;
sideMountPointsDepthAdjust = .5; // the sides are a tiny bit higher on the physical wall switch :shrug:
centerPartHeightReduction = 3.5;
partSeparation = 15; // set to 0 to print a fused model

topPartOuterHeight = switchHeight + centerPartHeightReduction / 2 + bodyWallThickness;
centerPartOuterHeight = switchHeight - centerPartHeightReduction;
bottomPartOuterHeight = topPartOuterHeight;

translate([0, topPartOuterHeight / -2, 0])
main(
  connectingBottom = true,
  rotatePuckHolderDeg = rotatePuckHolderDeg,
  switchHeight = switchHeight + centerPartHeightReduction / 2,
  bodyWallThickness = bodyWallThickness,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);

translate([0, centerPartOuterHeight / -2 - topPartOuterHeight - partSeparation, 0])
main(
  connectingTop = true,
  connectingBottom = true,
  rotatePuckHolderDeg = rotatePuckHolderDeg,
  switchHeight = switchHeight - centerPartHeightReduction,
  bodyWallThickness = bodyWallThickness,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);

translate([0, bottomPartOuterHeight / -2 - topPartOuterHeight - centerPartOuterHeight - partSeparation * 2, 0])
main(
  connectingTop = true,
  switchHeight = switchHeight + centerPartHeightReduction / 2,
  bodyWallThickness = bodyWallThickness,
  puckHolderConnectionPackingMagic = puckHolderConnectionPackingMagic,
  mountPointsCenterPacking = mountPointsCenterPacking,
  sideMountPointsDepthAdjust = sideMountPointsDepthAdjust
);
