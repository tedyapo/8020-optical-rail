//
// 30mm lens mount for 1" 8020 aluminum extrusion
//
use <utils.scad>;
use <t_slot.scad>;
use <thumbscrew.scad>;


extrusion_width = 0.42; // mm
slot_tol = inch(0.03);

epsilon = 1;
inch_epsilon = 25.4*epsilon;

slider_length = inch(1.125);
top_thickness = inch(0.2);
side_thickness = inch(0.125);
slider_height = top_thickness + inch(0.8);
slider_width = 2*side_thickness + inch(1.0);
slider_trim = inch(0.07);

slot_rider_width = inch(0.23);
slot_rider_height = inch(0.04);
slot_rider_length = inch(0.5);

screw_clearance_diameter = inch(0.17); // 6-32 screw

// captive nut slot
wrench_size = inch(0.25); // 1/4" nut
wrench_tol = inch(0.02);
nut_thickness = inch(0.1);
nut_offset = inch(0.08);

// calculation based on hex-shaped nut
nut_diameter = (wrench_size + wrench_tol) / cos(30);

// t-slot captive nut holder
module slider()
{
  difference()
  {
    // body
    translate([0, -slider_trim, 0])
    {
      t_slot(slot_rider_length, slot_tol = inch(0.07));
    }
    
    // screw thru hole
    translate([0, -inch(0.5), slot_rider_length/2])
    {
      rotate([-90, 0, 0])
      {
        cylinder($fn=53, h=inch(1), r=screw_clearance_diameter/2);
      }
    }
    
    // captive nut recess
    translate([0,
               nut_offset,
               slot_rider_length/2])
    {
      rotate([-90, 30, 0])
      {
        cylinder($fn = 6, r = nut_diameter/2, h=inch(0.5));
      }
    }
    
    // cut off top of tab
    translate([-25, -50, -epsilon])
    {
      cube([50, 50, 50]);
    }
  }
}


//
//         +--+                     4 +--+ 3
//        /   | |\                 /| |   \
//       /    +-+ |               | +-+    \
//      /     +-+ |  +--------+   | +-+     \
//     /      | |/  +---+  +---+   \| |      \
//    /       |         |  |          |       \
// +-+        +---------+  +----------+ 5    2 +--+ 1
// |                                              |
// +----------------------------------------------+ 0
//
//

p0x = inch(0.5)+side_thickness;
p0y = 0;
p1x = p0x;
p1y = top_thickness - slot_tol/2;
p2x = inch(0.5)+side_thickness;
p2y = p1y;
p3x = inch(0.5)+side_thickness;
p3y = top_thickness+inch(0.8);
p4x = inch(0.5) + slot_tol/2;
p4y = p3y;
p5x = p4x;
p5y = p1y;
p0 = [p0x, p0y];
p1 = [p1x, p1y];
p2 = [p2x, p2y];
p3 = [p3x, p3y];
p4 = [p4x, p4y];
p5 = [p5x, p5y];

// matrix to mirror about y-axis for symmetry exploit
M = [[-1, 0],
     [ 0, 1]];

module mount()
{
  difference()
  {
    union()
    {
      // base
      linear_extrude(height = slider_length)
      {
        polygon(points=[p0, p1, p2, p3, p4, p5,
                        M*p5, M*p4, M*p3, M*p2, M*p1, M*p0],
                paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12]],
                convexity = 4);
      }

      // t-slot tabs
      translate([0, top_thickness + inch(0.5), 0])
      {
        translate(inch([0, -0.5, 0]) + [0, -slot_tol/2, 0])
        {
          rotate([0, 0, 0])
          {
            t_slot(slider_length, slot_tol=inch(0.07));
          }
        }

        translate([inch(0.5)-slot_rider_height+slot_tol/2,-slot_rider_width/2, 0])
        {
          cube([slot_rider_height, slot_rider_width, slider_length]);
        }

        translate([inch(-0.5)-slot_tol/2,-slot_rider_width/2, 0])
        {
          cube([slot_rider_height, slot_rider_width, slider_length]);
        }
      }
    }

    // mounting screw holes
    translate([-inch(0.6)/2, -epsilon, (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=8, d = inch(0.125), h = inch(0.25));
      }
    }
    translate([+inch(0.6)/2, -epsilon, (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=8, d = inch(0.125), h = inch(0.25));
      }
    }
    translate([-inch(0.6)/2, -epsilon,
               slider_length - (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=8, d = inch(0.125), h = inch(0.25));
      }
    }
    translate([+inch(0.6)/2, -epsilon,
               slider_length - (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=8, d = inch(0.125), h = inch(0.25));
      }
    }


    // captive nut recesses
    nut_d = inch(0.25) / cos(30) + 0.5;
    nut_h = 3;
    translate([-inch(0.6)/2,
               top_thickness-nut_h,
               (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=6, d = nut_d, h = nut_h + epsilon);
      }
    }
    translate([+inch(0.6)/2,
               top_thickness-nut_h,
               (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=6, d = nut_d, h = nut_h + epsilon);
      }
    }
    translate([-inch(0.6)/2,
               top_thickness-nut_h,
               slider_length - (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=6, d = nut_d, h = nut_h + epsilon);
      }
    }
    translate([+inch(0.6)/2,
               top_thickness-nut_h,
               slider_length - (slider_length - inch(0.75))/2]){
      rotate([-90, 0, 0]){
        cylinder($fn=6, d = nut_d, h = nut_h + epsilon);
      }
    }

    // holes for clamp screws
    translate([inch(-1), top_thickness+inch(0.5), slider_length/2])
    {
      rotate([0,90, 0])
      {
        cylinder($fn=53, r=screw_clearance_diameter/2, h=inch(2));
      }
    }
  }
}

module slider_mount()
{
  mount();

  // thumbscrews
  translate(inch([1, 1.25, 0]))
  {
    thumbscrew();
  }
  translate(inch([-1, 1.25, 0]))
  {
    thumbscrew();
  }

  // make the two sliders
  translate([inch(1), inch(-0.5), 0])
  {
    slider();
  }
  
  translate([inch(-1), inch(-.5), 0])
  {
    slider();
  }
}

module slider_assembly()
{
  mount();

  translate(inch([1, 0.7, 0]) + [0, 0, slider_length/2])
  {
    rotate([0, 90, 0]){
      thumbscrew();
    }
  }
  translate(inch([-1, 0.7, 0]) + [0, 0, slider_length/2])
  {
    rotate([0, -90, 0]){
      thumbscrew();
    }
  }
}

slider_mount();
//slider_assembly();

