use <utils.scad>;

module sensor_board()
{
  epsilon = 1;
  color("purple") difference(){
    translate([-inch(1.)/2, -inch(0.85)/2, 0]){
      cube([inch(1.), inch(0.85), 1.6]);
    }
    translate([inch(-0.75/2), inch(-0.6/2), -epsilon]){
      cylinder($fn=13, d=inch(.126), h=1.6+2*epsilon);
    }
    translate([inch(-0.75/2), inch(+0.6/2), -epsilon]){
      cylinder($fn=13, d=inch(.126), h=1.6+2*epsilon);
    }
    translate([inch(+0.75/2), inch(-0.6/2), -epsilon]){
      cylinder($fn=13, d=inch(.126), h=1.6+2*epsilon);
    }
    translate([inch(+0.75/2), inch(+0.6/2), -epsilon]){
      cylinder($fn=13, d=inch(.126), h=1.6+2*epsilon);
    }
  }
  translate([-inch(0.5)-2.35/2+inch(0.1)-1, -6.8/2, 1.6]){
    color("white") cube([2.35, 6.8, 3]);
    translate([0, 6.8/2, 1.95]){
      cone_len = 20;
      rotate([0, -90, 0]) %cylinder(r1=0.5, r2=0.5 + cone_len*tan(55), h=cone_len);
    }
  }
}

sensor_board();
