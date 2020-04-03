/**
Bias tape maker.  Reverse engineered from design by SamHillCreations
at https://www.thingiverse.com/thing:3034992 - it's a clever design.
Very slim; I like it.

Make sure to run get_deps.sh, or manually download the git repos listed
therein, and copy them into "deps.link/".

Provided any 2 of the following 3 inputs, a bias tape maker is made.
INPUT - width of the input cloth
OUTPUT - width of the output tape
OVERLAP_RATIO - what ratio of the output width is taken up by the
  two sides folded over *each other*.  E.g., 0 if the two sides just
  barely touch, 1 if the entire thing is folded in thirds, and anywhere
  in between is somewhere in between.

The following three are equivalent:

biasTapeMaker(INPUT=undef,OUTPUT=0.642857*INCH,OVERLAP_RATIO=1/3);
biasTapeMaker(INPUT=1.5*INCH,OUTPUT=undef,OVERLAP_RATIO=1/3);
biasTapeMaker(INPUT=1.5*INCH,OUTPUT=0.642857*INCH,OVERLAP_RATIO=undef);

You can also add tabs, via the TAB_LENGTH (and optional TAB_WIDTH) params.
(Note that they are not exact - BORDER (5) is added around them.)
*/

use <deps.link/erhannisScad/misc.scad>
use <deps.link/scadFluidics/common.scad>

$fn=60;
BIG = 1000;
EPS = 1e-40;

INCH = 25.4;

/**
See file header.
*/
module biasTapeMaker(INPUT=undef, OUTPUT=0.645*INCH, OVERLAP_RATIO = 1/3, TAB_LENGTH=0, TAB_WIDTH=10) {
  if (INPUT == undef) {
    FOLD_F = (OVERLAP_RATIO/2+0.5)*OUTPUT;
    INPUT0 = OUTPUT+FOLD_F*2;
    biasTapeMaker(INPUT=INPUT0,OUTPUT=OUTPUT,OVERLAP_RATIO=OVERLAP_RATIO,TAB_LENGTH=TAB_LENGTH,TAB_WIDTH=TAB_WIDTH);
  } else if (OUTPUT == undef) {
    OUTPUT0 = INPUT/(OVERLAP_RATIO+2);
    biasTapeMaker(INPUT=INPUT,OUTPUT=OUTPUT0,OVERLAP_RATIO=OVERLAP_RATIO,TAB_LENGTH=TAB_LENGTH,TAB_WIDTH=TAB_WIDTH);
  } else {
    echo(INPUT=INPUT/INCH);
    echo(OVERLAP_RATIO=(INPUT/OUTPUT-2));
    echo(OUTPUT=OUTPUT/INCH);

    BH = 2;

    INPUT_SLOT_L = 5;
    INPUT_RAMP_EXTRA_L = BH;
    FUNNEL_L = INPUT;
    FOLD_SECTION_L = 20;
    
    FOLDING_BAR_DZ = 1.5;

    BL = INPUT_RAMP_EXTRA_L+INPUT_SLOT_L+FUNNEL_L+FOLD_SECTION_L;
    BW = INPUT;

    WALL_H = BH/2 + INPUT*0.025;
    WALL_T = 3;

    BORDER = 5;

    union() {
      difference() {
        // Body
        translate([0,BL/2,0]) minkowski() {
          translate([0,0,BH/2]) union() {
            cube([BW,BL,BH],center=true);
            cube([BW+TAB_LENGTH*2,TAB_WIDTH,BH],center=true);
          }
          cylinder(d=BORDER*2,h=EPS);
        }
        // Input slot
        skew([0,0,0,45,0,0]) translate([0,INPUT_SLOT_L/2,0]) cube([INPUT,INPUT_SLOT_L,BIG],center=true);
        // Folding section void
        translate([0,INPUT_SLOT_L+INPUT_RAMP_EXTRA_L+FUNNEL_L,0]) translate([0,FOLD_SECTION_L/2,0]) cube([OUTPUT,FOLD_SECTION_L,BIG],center=true);
      }
      // Funnel
      translate([0,INPUT_SLOT_L+INPUT_RAMP_EXTRA_L,0]) difference() {
        minkowski() {
          rotate([-90,0,0]) linear_extrude(height=FUNNEL_L,scale=OUTPUT/INPUT) {
            square([INPUT,BIG/(OUTPUT/INPUT)],center=true);
          }
          cube([WALL_T*2,EPS,EPS],center=true);
        }
        rotate([-90,0,0]) linear_extrude(height=FUNNEL_L,scale=OUTPUT/INPUT) {
          square([INPUT,BIG/(OUTPUT/INPUT)],center=true);
        }
        OZm();
        OZp([0,0,BH+WALL_H]);
      }
      // Output walls
      cmirror([1,0,0]) translate([OUTPUT/2+WALL_T/2,INPUT_SLOT_L+INPUT_RAMP_EXTRA_L+FUNNEL_L,0]) translate([-WALL_T/2,0,0]) cube([WALL_T,FOLD_SECTION_L,BH+WALL_H]);
      // Folding ramp
      translate([0,INPUT_SLOT_L+INPUT_RAMP_EXTRA_L+FUNNEL_L,0]) difference() {
        rotate([45,0,0]) cube([OUTPUT,BH*sqrt(2),BH*sqrt(2)],center=true);
        OZm();
        OYm();
      }
      // Folding bar
      translate([0,INPUT_SLOT_L+INPUT_RAMP_EXTRA_L+FUNNEL_L+FOLD_SECTION_L/2,FOLDING_BAR_DZ]) translate([0,0,BH]) difference() {
        rotate([45,0,0]) cube([OUTPUT,BH*sqrt(2),BH*sqrt(2)],center=true);
        OZp();
      }
      // Output ramp
      translate([0,INPUT_SLOT_L+INPUT_RAMP_EXTRA_L+FUNNEL_L+FOLD_SECTION_L,0]) difference() {
        rotate([45,0,0]) cube([OUTPUT,BH*sqrt(2),BH*sqrt(2)],center=true);
        OZm();
        OYp();
      }
    }
  }
}

biasTapeMaker(INPUT=1*INCH,OUTPUT=3/8*INCH,OVERLAP_RATIO=undef,TAB_LENGTH=1*INCH);