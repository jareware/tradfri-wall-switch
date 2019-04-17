$fn = 100;

MAGIC = 0.01;
LOOSEN_BY = 1;
PUCK_DIAM = 68.3;
PUCK_THICK = 18.6;

wallThick = 3.5;
puckHeightCoverage = .55;
accessHoleEdgeWidth = 6;

difference() {

  // Main body:
  cylinder(h = PUCK_THICK * puckHeightCoverage + wallThick, d = PUCK_DIAM + wallThick * 2);

  // Carve out hole for puck:
  translate([ 0, 0, wallThick ])
  cylinder(h = PUCK_THICK, d = PUCK_DIAM + LOOSEN_BY);

  // Carve out access hole:
  translate([ 0, 0, -MAGIC ])
  cylinder(h = wallThick + MAGIC * 2, d = PUCK_DIAM - accessHoleEdgeWidth * 2);

}
