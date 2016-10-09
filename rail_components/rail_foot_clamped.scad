//
// feet for 1" 8020 aluminum extrusion
//
use <utils.scad>;
use <t_slot.scad>;
use <thumbscrew.scad>;

extrusion_width = 0.42; // mm

epsilon = 1/25.4;
inch_epsilon = inch(epsilon);

slot_length = inch(0.5);


// 6-32 screw
screw_clearance_diameter = inch(0.15);

// captive nut slot
wrench_size = inch(5/16); // 6-32 nut
wrench_tol = inch(0.01);
nut_thickness = inch(0.12);

//base_height = inch(0.25);
base_height = nut_thickness + 9*extrusion_width;
nut_height = 2*extrusion_width;


// calculation based on hex-shaped nut
nut_diameter = (wrench_size + wrench_tol) / cos(30);

screw_foot_size = slot_length;
//screw_foot_size = (wrench_size + wrench_tol) + 12 * extrusion_width;

slider_height = inch(0.2);
slider_base_diameter = inch(0.25);
slider_top_diameter = inch(0.17);
slider_thread_diameter = inch(0.15);
slider_nonthreaded_height = inch(0.07);

tab_slot_tol = inch(0.05);
side_tol = inch(0.015);

module rail_foot()
{
  difference(){
    union(){
      // t-slot tabs
      translate([0, base_height + inch(0.5), 0])
      {
        translate([0, inch(-0.5)-side_tol, 0])
        {
          t_slot(slot_length, extra_depth = side_tol, slot_tol=tab_slot_tol);
        }
      }
      
      translate([inch(0.5)-slot_rider_height+side_tol,
                 base_height + inch(0.5) -slot_rider_width/2,
                 0]){
        cube([slot_rider_height, slot_rider_width, slot_length]);
      }
      translate([inch(-0.5)-side_tol,
                 base_height + inch(0.5) -slot_rider_width/2,
                 0]){
        cube([slot_rider_height, slot_rider_width, slot_length]);
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

      p0x = inch(1.1);
      p0y = 0;
      p1x = p0x;
      p1y = base_height;
      p2x = inch(0.625);
      p2y = p1y;
      p3x = inch(0.625);
      p3y = base_height+inch(0.8);
      p4x = inch(0.5) + side_tol;
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
      
      // base
      linear_extrude(height = slot_length)
      {
        polygon(points=[p0, p1, p2, p3, p4, p5,
                        M*p5, M*p4, M*p3, M*p2, M*p1, M*p0],
                paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12]],
                convexity = 4);
      }
      
      eps = 0.1;
      // adjustment screw feet blocks
      difference()
      {
        translate([p1x-eps, 0, 0])
        {
          cube([screw_foot_size+eps, base_height, screw_foot_size]);
        }
        if (0){
          // clearance hole for adjustment screw
          translate([p1x+screw_foot_size/2,
                     base_height+epsilon,
                     screw_foot_size/2])
          {
            rotate([90, 0, 0])
            {
              cylinder($fn = 35, 
                       h = base_height+2*epsilon,
                       r = screw_clearance_diameter/2);
            }
          }
          
          // captive nut slot for 6-32 nut
          translate([p1x+screw_foot_size/2,
                     nut_height,
                     screw_foot_size/2])
          {
            hull()
            {
              rotate([-90, 30, 0])
              {
                cylinder($fn = 6, r = nut_diameter/2, h=nut_thickness);
              }
              
              translate([0, 0, screw_foot_size])
              {
                rotate([-90, 30, 0])
                {
                  cylinder($fn = 6, r = nut_diameter/2, h=nut_thickness);
                }
              }
            }
          }
        }
      }

      
      difference()
      {
        translate([-p1x-screw_foot_size, 0, 0])
        {
          cube([screw_foot_size+eps, base_height, screw_foot_size]);
        }
        
        if (0){
          
          // thru hole for adjustment screw
          translate([-p1x-screw_foot_size/2,
                     base_height+epsilon,
                     screw_foot_size/2])
          {
            rotate([90, 0, 0])
            {
              cylinder($fn = 35, 
                       h = base_height+2*epsilon,
                       r = screw_clearance_diameter/2);
            }
          }
          
          // slot for captive nut
          translate([-p1x-screw_foot_size/2,
                     nut_height,
                     screw_foot_size/2])
          {
            hull()
            {
              rotate([-90, 30, 0])
              {
                cylinder($fn = 6, r = nut_diameter/2, h=nut_thickness);
              }
              translate([0, 0, screw_foot_size])
              {
                rotate([-90, 30, 0])
                {
                  cylinder($fn = 6, r = nut_diameter/2, h=nut_thickness);
                }
              }
            }
          }
        }
      }
    }
    // holes for clamp screws
    translate([inch(-1), base_height+inch(0.5), slot_length/2])
    {
      rotate([0,90, 0])
      {
        cylinder($fn=8, r=screw_clearance_diameter/2, h=inch(2));
      }
    }
  }
}
slider_trim = inch(0.07);
slider_length = inch(1.125);
slot_rider_length = inch(0.5);
slot_rider_width = inch(0.23);
slot_rider_height = inch(0.04);

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
    translate([0, 0, -1.1]){
      rotate([90, 0, 0]){
        difference(){
          // body
          translate([0, -slider_trim, 0])
          {
            t_slot(slot_rider_length, slot_tol = inch(0.05));
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
        }
      }
    }
    
    // cut off bottom of tab
    translate([-25, -25, -50])
    {
      cube([50, 50, 50]);
    }
  }
}

rail_foot();

translate([-10, -15, 0]){
  slider();
}
translate([+10, -15, 0]){
  slider();
}
translate([+30, -15, 0]){
  thumbscrew();
}
translate([-30, -15, 0]){
  thumbscrew();
}
