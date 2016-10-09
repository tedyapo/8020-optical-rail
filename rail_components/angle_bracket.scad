use <utils.scad>;
use <t_slot.scad>;

*new_corner();
*corner_clip();
*new_nut_slider();
*8020_corner();

module angle_corner(angle){
  thickness = inch(0.40);
  screw_hole = inch(0.19);
  screw_recess = inch(0.5);
  epsilon = 1;
  theta = 270 + angle;
  length = inch(1.5);
  l2 = inch(0.5);

  //translate([0, 0, sqrt(2)*length/2])
  //rotate([-90, 45, 0])
  difference(){
    union(){
      intersection(){
        linear_extrude(inch(1.0)){
          polygon([[0, 0],
                   [0, length],
                   [l2, length],
                   [length*cos(theta) - l2*sin(theta),
                    length*sin(theta) + l2*cos(theta)],
                   [length*cos(theta), length*sin(theta)]]);
        }
       * cube([inch(1.25), inch(1.25), inch(1.25)]);
      }
    }

    // screw holes
    translate([length*cos(theta)/2,
               length*sin(theta)/2,
               inch(0.5)]){
      rotate([-90, 0, 0]){
        rotate([0, -theta,0])
          translate([0, 0, -inch(1)])
        cylinder($fn=8, d = screw_hole, h = inch(2));
      }
    }
    translate([-epsilon, length/2, inch(0.5)]){
      rotate([0, 90, 0]){
        cylinder($fn=8, d = screw_hole, h = inch(1));
      }
    }    

    // screw recesses
    translate([length*cos(theta)/2 - thickness*sin(theta),
               length*sin(theta)/2 + thickness*cos(theta),
               inch(0.5)]){
      rotate([-90, 0, 0]){
        rotate([0, -theta,0])
          translate([0, 0, 0])
        cylinder($fn=12, d = screw_recess, h = inch(1));
      }
    }
    translate([thickness, length/2, inch(0.5)]){
      rotate([0, 90, 0]){
        cylinder($fn=12, d = screw_recess, h = inch(1));
      }
    }    
    
  }
}

angle_corner(15);
