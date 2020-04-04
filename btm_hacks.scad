/**
This basically loads the
Bias tape maker by Oscarko - https://www.thingiverse.com/thing:3880491
and the
Bias tape folder by Arnie - https://www.thingiverse.com/thing:4236663
and chops most of the wings of, cuts slots into it to feed tape through,
and rescales it to accept the given input width of cloth.
*/

use <deps.link/erhannisScad/misc.scad>
use <deps.link/scadFluidics/common.scad>

$fn=60;
BIG = 1000;
EPS = 1e-40;
INCH = 25.4;

SLOT_W = 2;
WALL_T = 3;

INPUT = 1*INCH;



SCALE = INPUT/(1.25*INCH);

/*
scale(SCALE) difference() { // Bias tape folder
  FIN_OFFSET = 12.6;
  HEIGHT = 27.5;
  translate([-9.35,10,0]) import("BiasTapeHalf.stl", convexity=6);
  cmirror([1,0,0]) skew([0,-6.4,0,0,0,0]) translate([FIN_OFFSET,0,0]) union() {
    translate([0,0,WALL_T]) cube([SLOT_W,BIG,HEIGHT-2*WALL_T]);
    OXp([SLOT_W+WALL_T,0,0]);
  }
}
*/

scale(SCALE) difference() { // Double folder
  FIN_OFFSET = 7;
  HEIGHT = 25;
  rotate([0,0,90]) translate([-100,-100,0]) import("Double_Folder.stl", convexity=6);
  cmirror([1,0,0])
  //skew([0,-6.4,0,0,0,0])
  translate([FIN_OFFSET,0,0]) union() {
    translate([0,0,WALL_T]) cube([SLOT_W,BIG,HEIGHT-2*WALL_T]);
    OXp([SLOT_W+WALL_T,0,0]);
  }
}
