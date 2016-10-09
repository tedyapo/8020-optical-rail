// rail mounting assembly
use <utils.scad>;
use <t_slot.scad>;
use <ring_mount.scad>;
use <VEML7700_mount.scad>;
use <LED_board_mount.scad>;
use <rail_foot.scad>;
use <sensor_mount.scad>;

type = "laser_mount";
type = "LED_mount";

if (type == "laser_mount"){
  // ring mount
  translate([60, 0, 0]){
    translate([0, 0, 33]){
      rotate([90, 0, -90]){
        ring_mount_assembly();
        l = 42;
        translate([0, 0, -l]) color("red") cylinder($fn=13, d=0.5, h=l);
        color([0.75, 0.75, 0.75]) cylinder($fn=13, d=6, h=10);
      }
    }
    
    translate([0, 0, inch(0.69)]){
      rotate([-90, 0, 90]){
        slider_assembly();
      }
    }
  }
}

if (type == "LED_mount"){
  // board mount
  translate([60, 0, 0]){
    translate([0, 0, 33]){
      rotate([90, 0, -90]){
        LED_mount_assembly();
      }
    }
    translate([0, 0, inch(0.69)]){
      rotate([-90, 0, 90]){
        slider_assembly();
      }
    }
  }
}


// sensor mount
translate([100, 0, 0]){
  translate([0, 0, inch(0.69)]){
    rotate([-90, 0, -90]){
      slider_assembly();
    }
  }
  translate([14.4, 0, 29.5]){
    sensor_board();
    // hex standoffs
    color([0.25, 0.25, 0.25]){
      translate([inch(-0.75/2), inch(-0.6/2), -11.5]){
        cylinder($fn=6, d = inch(3/16), h = inch(7/16));
      }
      translate([inch(-0.75/2), inch(+0.6/2), -11.5]){
        cylinder($fn=6, d = inch(3/16), h = inch(7/16));
      }
      translate([inch(+0.75/2), inch(-0.6/2), -11.5]){
        cylinder($fn=6, d = inch(3/16), h = inch(7/16));
      }
      translate([inch(+0.75/2), inch(+0.6/2), -11.5]){
        cylinder($fn=6, d = inch(3/16), h = inch(7/16));
      }
    }
  }
}

// rail
rotate([0, 90, 0]){
  color([0.25, 0.25, 0.25]) rail_1x1(170);
}

// feet
translate([160, 0, -inch(0.75)]){
  rotate([90, 0, 90]){
    rail_foot();
  }
}
translate([10, 0, -inch(0.75)]){
  rotate([90, 0, -90]){
    rail_foot();
  }
}


