// mount for 35mm slides and compatible optical components
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

face_width = inch(2.5);
face_height = inch(2.5);
nut_block_thickness = 6;
nut_block_width = 12;

// recesses for #4-40 hex nuts
nut_d = inch(0.25) / cos(30) + 0.5;
nut_h = 3;

set_screw_d = inch(0.125);
mounting_hole_spacing = 40;
mounting_hole_height = 15;
mounting_hole_d = 3;
mounting_slot_length = 3;

epsilon = 1;

slide_aperture_height = 30;
slide_aperture_width = 40;

face_thickness = 4;

module LED_mount(){
  difference(){
    union(){
      // face
      translate([-face_width/2, -center_height, 0]){
        cube([face_width, face_height, face_thickness]);
      }

      // base
      translate([-base_width/2, -center_height, 0]){
        cube([base_width, base_thickness, base_length]);
      }
    }

    // slide aperture
    translate([-slide_aperture_width/2,
               +slide_aperture_height/2-center_height,
               -epsilon]){
      cube([slide_aperture_width,
            slide_aperture_height,
            face_thickness + 2*epsilon]);
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
}

module HS()
{
  translate([-19/2, -14/2, 1.6]){
    cube([19, 14, 5]);
  }
}
module Saber_Z1()
{
  translate([-9.9/2, -9.9/2, 0]){
    cube([34.8, 9.9, 1.6]);
  }
}

module printing_layout()
{
  // rotate([0, 90, 0]){
    LED_mount();
    // }
}

module LED_mount_assembly()
{
  LED_mount();

  translate([0, 0, face_thickness]){
    Saber_Z1();
    color("red") HS();
  }
}


printing_layout();

//LED_mount_assembly();



