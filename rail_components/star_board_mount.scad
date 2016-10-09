// ring mount for components
// Copyright (C) 2016, Theodore C Yapo

use <utils.scad>;


ring_length = 10;
//center_height = 14.5;
center_height = 31;
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
face_height = center_height + base_thickness + 15;


module LED_mount(){
  difference(){
    union(){
      // face
      translate([-base_width/2, -center_height, 0]){
        cube([base_width, face_height, face_thickness]);
      }

      // base
      translate([-base_width/2, -center_height, 0]){
        cube([base_width, base_thickness, base_length]);
      }

      // brace
      brace_len = 20;
      brace_thickness = 5;
      translate([brace_thickness/2,
                 -center_height+brace_len,
                  0])
      rotate([0, -90, 0])
      linear_extrude(height = brace_thickness){
        polygon([[0, 0], [0, -brace_len], [brace_len, -brace_len]]);
      }
    }

    // star board holes
    translate([0, 0, -epsilon]){
      cylinder($fn=6, d = 10, h = face_thickness+2*epsilon);
    }
    translate([0, +8, -epsilon]){
      cylinder($fn=6, d = 10, h = face_thickness+2*epsilon);
    }
    translate([0, -8, -epsilon]){
      cylinder($fn=6, d = 10, h = face_thickness+2*epsilon);
    }

    // mounting screw clearance slots
    translate([-inch(0.6)/2,
               -center_height + base_thickness,
               (base_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=12, d = inch(0.37), h = inch(0.25));
      }
    }
    translate([+inch(0.6)/2,
               -center_height + base_thickness,
               (base_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=12, d = inch(0.37), h = inch(0.25));
      }
    }
    
    
    // mounting screw holes
    translate([-inch(0.6)/2,
               -center_height-epsilon,
               (base_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=8, d = inch(0.125), h = inch(0.25));
      }
    }
    translate([+inch(0.6)/2,
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


module printing_layout()
{
  rotate([0, 90, 0]){
    LED_mount();
  }
}

module LED_mount_assembly()
{
  LED_mount();
  translate([0, 0, -10]){
    rotate([0, 0, 90]){
      color("purple") board();
    }
    translate([0, 0, -6]){
      led();
    }
  }

}


printing_layout();

//LED_mount_assembly();


