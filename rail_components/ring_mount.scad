// ring mount for components
// Copyright (C) 2016, Theodore C Yapo

use <utils.scad>;
use <thumbscrew.scad>;


ring_length = 10;
//center_height = 14.5;
center_height = 31;
//outer_d = 2*center_height / cos(30);
outer_d = 65;
ring_thickness = 4;
inner_d = outer_d - 2*ring_thickness;
screw_spacing = inch(0.6);
base_width = inch(1.25);
base_thickness = inch(0.125);
base_length = inch(1.125);

nut_block_thickness = 6;
nut_block_width = 12;

// recesses for #4-40 hex nuts
nut_d = inch(0.25) / cos(30) + 0.5;
nut_h = 3;

set_screw_d = inch(0.125);

epsilon = 1;

module ring_mount(){
  difference(){
    union(){
      difference(){
        union(){
          //ring body
          cylinder($fn = 6, d = outer_d, h = ring_length);
          // base
          translate([-base_width/2, -center_height, 0]){
            cube([base_width, base_thickness, base_length]);
          }
        }
    
        // hollow inside
        translate([0, 0, -epsilon]){
          cylinder($fn = 6, d = inner_d, h = ring_length + 2*epsilon);
        }
    
        // mounting screw holes
        translate([-inch(0.6)/2,
                   -center_height-epsilon,
                   (base_length - inch(0.75))/2]){
          rotate([-90, 0, 0]){
            *cylinder($fn=8, d = inch(0.125), h = inch(0.25));
          }
        }
        translate([+inch(0.6)/2,
                   -center_height-epsilon,
                   (base_length - inch(0.75))/2]){
          rotate([-90, 0, 0]){
            *cylinder($fn=8, d = inch(0.125), h = inch(0.25));
          }
        }
        translate([-inch(0.6)/2,
                   -center_height - epsilon,
                   base_length - (base_length - inch(0.75))/2]){
          rotate([-90, 0, 0]){
            cylinder($fn=8, d = inch(0.125), h = inch(0.25));
          }
        }
        translate([+inch(0.6)/2,
                   -center_height - epsilon,
                   base_length - (base_length - inch(0.75))/2]){
          rotate([-90, 0, 0]){
            cylinder($fn=8, d = inch(0.125), h = inch(0.25));
          }
        }
      }
  
      // top nut block
      translate([-nut_block_width/2,
                 inner_d/2-nut_block_thickness/2,
                 0]){
        cube([nut_block_width, nut_block_thickness, ring_length]);
      }

      // left nut block
      rotate([0, 0, 120]){
        translate([-nut_block_width/2,
                   inner_d/2-nut_block_thickness/2,
                   0]){
          cube([nut_block_width, nut_block_thickness, ring_length]);
        }
      }

      // right nut block
      rotate([0, 0, -120]){
        translate([-nut_block_width/2,
                   inner_d/2-nut_block_thickness/2,
                   0]){
          cube([nut_block_width, nut_block_thickness, ring_length]);
        }
      }

    }

    // top nut recess
    translate([0,
               inner_d/2-nut_h/2,
               ring_length/2]){
      rotate([-90, 0, 0]){
        hull(){
          rotate([0, 0, 30]){
            cylinder($fn=6, d = nut_d, h = nut_h);
          }
          translate([0, -10, 0]){
            rotate([0, 0, 30]){
              cylinder($fn=6, d = nut_d, h = nut_h);
            }
          }
        }
      }
    }
    // top screw hole
    translate([0,
               inner_d/2 - ring_thickness,
               ring_length/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=6, d = set_screw_d, h = 2*ring_thickness);
      }
    }

    // left nut recess
    rotate([0, 0, 120]){
      translate([0,
                 inner_d/2-nut_h/2,
                 ring_length/2]){
        rotate([-90, 0, 0]){
          hull(){
            rotate([0, 0, 30]){
              cylinder($fn=6, d = nut_d, h = nut_h);
            }
            translate([0, -10, 0]){
              rotate([0, 0, 30]){
                cylinder($fn=6, d = nut_d, h = nut_h);
              }
            }
          }
        }
      }
      // screw hole
      translate([0,
                 inner_d/2 - ring_thickness,
                 ring_length/2]){
        rotate([-90, 0, 0]){
          cylinder($fn=6, d = set_screw_d, h = 2*ring_thickness);
        }
      }
    }

    // right nut recess
    rotate([0, 0, -120]){
      translate([0,
                 inner_d/2-nut_h/2,
                 ring_length/2]){
        rotate([-90, 0, 0]){
          hull(){
            rotate([0, 0, 30]){
              cylinder($fn=6, d = nut_d, h = nut_h);
            }
            translate([0, -10, 0]){
              rotate([0, 0, 30]){
                cylinder($fn=6, d = nut_d, h = nut_h);
              }
            }
          }
        }
      }
      // screw hole
      translate([0,
                 inner_d/2 - ring_thickness,
                 ring_length/2]){
        rotate([-90, 0, 0]){
          cylinder($fn=6, d = set_screw_d, h = 2*ring_thickness);
        }
      }
    }
   
  }
}

module printing_layout()
{
  ring_mount();
  
  translate([-17, 0, 0]){
    thumbscrew(size = "#4-40");
  }
  translate([+17, 0, 0]){
    thumbscrew(size = "#4-40");
  }
  
  thumbscrew(size = "#4-40");
}

module ring_mount_assembly()
{
  ring_mount();
  
  translate([0, 25, ring_length/2]){
    rotate([-90, 0, 0]){
      thumbscrew(size = "#4-40");
    }
  }

  rotate([0, 0, 120]){
    translate([0, 25, ring_length/2]){
      rotate([-90, 0, 0]){
        thumbscrew(size = "#4-40");
      }
    }
  }

  rotate([0, 0, -120]){
    translate([0, 25, ring_length/2]){
      rotate([-90, 0, 0]){
        thumbscrew(size = "#4-40");
      }
    }
  }
}


printing_layout();
//ring_mount_assembly();

