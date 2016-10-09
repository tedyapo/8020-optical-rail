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


board_width = inch(0.775);
board_length = inch(1.075);
board_thickness = 1.6;
board_hole_d = inch(0.126);
board_hole_offset = inch(0.1375);
board_center = 12.5;
LED_aperture = 12;
header_l = inch(0.11);
header_w = inch(0.22);

face_thickness = 4;
face_height = center_height + base_thickness + board_width/2;

module board_holes(height, fn, header_holes = true)
{
  // mounting holes
  translate([-board_width/2 + board_hole_offset,
             -board_length/2 + board_hole_offset,
             -epsilon]){
    cylinder($fn=fn, d=board_hole_d, h=height);
  }
  // mounting holes
  translate([-board_width/2 + board_hole_offset,
             +board_length/2 - board_hole_offset,
             -epsilon]){
    cylinder($fn=fn, d=board_hole_d, h=height);
  }
  // mounting holes
  translate([+board_width/2 - board_hole_offset,
             -board_length/2 + board_hole_offset,
             -epsilon]){
    cylinder($fn=fn, d=board_hole_d, h=height);
  }
  // mounting holes
  translate([+board_width/2 - board_hole_offset,
             +board_length/2 - board_hole_offset,
             -epsilon]){
    cylinder($fn=fn, d=board_hole_d, h=height);
  }
  if (header_holes){
    // header clearance hole
    translate([-header_w/2,
               +board_length/2 - board_hole_offset - header_l/2,
               -epsilon]){
      cube([header_w, header_l, height]);
    }
    // header clearance hole
    translate([-header_w/2,
               -board_length/2 + board_hole_offset - header_l/2,
               -epsilon]){
      cube([header_w, header_l, height]);
    }
  }
}

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
      brace_len = 25;
      brace_thickness = 5;
      translate([brace_thickness/2,
                 -center_height+brace_len,
                  0])
      rotate([0, -90, 0])
      linear_extrude(height = brace_thickness){
        polygon([[0, 0], [0, -brace_len], [brace_len, -brace_len]]);
      }
    }

    // required holes for board
    rotate([0, 0, 90]){
      board_holes(face_thickness+2*epsilon, 12, true);
    }
    translate([0, 0, -epsilon]){
      cylinder($fn=13, d = inch(0.3), h = face_thickness+2*epsilon);
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


led_d = 5.2;
led_lip_d = 6.5;
led_lip_l = 2;
aperture_d = 5.4;
//barrel_d = mount_height;
barrel_l = 8;

module led()
{
  color("red"){
    sphere($fn=27, d=5);
    cylinder($fn=27, d = 5, h = 5);
    translate([0, 0, 5]){
      cylinder($fn=27, d = 6, h = 1);
    }
  }
  color([0.75, 0.75, 0.75]){
    translate([+0.05*25.4, 0, 0]){
      rotate([0, 0, 45]){
        cylinder($fn=4, d=0.75, h = 15);
      }
    }
    translate([-0.05*25.4, 0, 0]){
      rotate([0, 0, 45]){
        cylinder($fn=4, d=0.75, h = 20);
      }
    }
  }
  
}

module board(header_holes=false)
{
  difference(){
    translate([-board_width/2, -board_length/2, 0]){  
      cube([board_width, board_length, board_thickness]);
    }
    board_holes(board_thickness + 2*epsilon, 13, header_holes);
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


