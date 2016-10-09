// ring mount for components
// Copyright (C) 2016, Theodore C Yapo

use <utils.scad>;


ring_length = 10;
center_height = 14.5;
outer_d = 2*center_height / cos(30);
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

face_thickness = 4;
aperture_d = 12;
board_guide_depth = 1;
board_tol = 0.25;

fan_mount_width = 55;
fan_cutout_d = 48;
fan_center = 25 - center_height + base_thickness;

module fan_mount(){
  difference(){
    union(){
      // face
      translate([-fan_mount_width/2, -center_height, 0]){
        cube([fan_mount_width, fan_mount_width, face_thickness]);
      }

      // base
      translate([-base_width/2, -center_height, 0]){
        cube([base_width, base_thickness, base_length]);
      }
    }

    // fan cutout
    translate([0, fan_center, -epsilon]){
      cylinder($fn = 53, d = fan_cutout_d, h = face_thickness+2*epsilon);
    }

    // fan mounting holes
    translate([0, fan_center, 0]){
      hole_spacing = 40;
      height = 11;
      hole_d = 4;
      
      translate([-hole_spacing/2, -hole_spacing/2, -epsilon]){
        cylinder($fn = 12, d = hole_d, h = height + 2 * epsilon);
      }
      translate([-hole_spacing/2, +hole_spacing/2, -epsilon]){
        cylinder($fn = 12, d = hole_d, h = height + 2*epsilon);
      }
      translate([+hole_spacing/2, -hole_spacing/2, -epsilon]){
        cylinder($fn = 12, d = hole_d, h = height + 2*epsilon);
      }
      translate([+hole_spacing/2, +hole_spacing/2, -epsilon]){
        cylinder($fn = 12, d = hole_d, h = height + 2*epsilon);
      }
    }

    // mounting screw clearance slots
    *translate([-inch(0.6)/2,
               -center_height + base_thickness,
               (base_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=12, d = inch(0.375), h = inch(0.125));
      }
    }
    *translate([+inch(0.6)/2,
               -center_height + base_thickness,
               (base_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=12, d = inch(0.375), h = inch(0.125));
      }
    }
    
    
    // mounting screw holes
    *translate([-inch(0.6)/2,
               -center_height-epsilon,
               (base_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=8, d = inch(0.125), h = inch(0.25));
      }
    }
    *translate([+inch(0.6)/2,
               -center_height-epsilon,
               (base_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=8, d = inch(0.125), h = inch(0.25));
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
}

module fan()
{
  corner_r = 5;
  hole_spacing = 40;
  height = 11;
  hole_d = 4;
  aperture_d = 47;
  hub_d = 23;
  n_blades = 7;
  blade_thickness = 2;
  blade_offset = -2;
  blade_d = 44;
  epsilon = 1;

  difference(){
    hull(){
      translate([-hole_spacing/2, -hole_spacing/2, 0]){
        cylinder($fn = 12, r = corner_r, h = height);
      }
      translate([-hole_spacing/2, +hole_spacing/2, 0]){
        cylinder($fn = 12, r = corner_r, h = height);
      }
      translate([+hole_spacing/2, -hole_spacing/2, 0]){
        cylinder($fn = 12, r = corner_r, h = height);
      }
      translate([+hole_spacing/2, +hole_spacing/2, 0]){
        cylinder($fn = 12, r = corner_r, h = height);
      }
    }

    // aperture
    translate([0, 0, -epsilon]){
      cylinder($fn = 37, d = aperture_d, h = height + 2 * epsilon);
    }    

    // mounting holes
    translate([-hole_spacing/2, -hole_spacing/2, -epsilon]){
      cylinder($fn = 12, d = hole_d, h = height + 2 * epsilon);
    }
    translate([-hole_spacing/2, +hole_spacing/2, -epsilon]){
      cylinder($fn = 12, d = hole_d, h = height + 2*epsilon);
    }
    translate([+hole_spacing/2, -hole_spacing/2, -epsilon]){
      cylinder($fn = 12, d = hole_d, h = height + 2*epsilon);
    }
    translate([+hole_spacing/2, +hole_spacing/2, -epsilon]){
      cylinder($fn = 12, d = hole_d, h = height + 2*epsilon);
    }
  }

  // blade hub
  translate([0, 0, 0]){
    cylinder($fn = 37, d = hub_d, h = height);
  }

  // blades
  intersection(){
    for (theta = [0:360/7:360]){
      translate([0.5*hub_d*cos(theta),
                 0.5*hub_d*sin(theta),
                 height/2]){
        rotate([0, 0, theta]){
          rotate([45, 0, 0]){
            translate([blade_offset, -height/2, 0])
              linear_extrude(height = blade_thickness){
              polygon([[0, 0],
                       [0, height],
                       [(aperture_d - hub_d)/2 - blade_offset, height],
                       [(aperture_d - hub_d)/2 - blade_offset, 0]]);
            }
          }
        }
      }
    }
    // aperture
    translate([0, 0, -epsilon]){
      cylinder($fn = 37, d = blade_d, h = height + 2 * epsilon);
    }    

  }
}

module printing_layout()
{
  fan_mount();
}

module fan_mount_assembly()
{
  fan_mount();
  translate([0, 13.5, face_thickness]){
    %fan();
  }
}


printing_layout();

//fan_mount_assembly();



