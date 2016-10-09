//
// thumbscrew cap for #6-32 nut (5/16 wrench)
//
use <utils.scad>;
epsilon = 1;

module thumbscrew(size = "#6-32", height = -1)
{

  epsilon = 1;
  major_diam_table = [["#4-40", inch(0.6)],
                      ["#6-32", inch(0.6)]];                      
  thumbscrew_knurl_diameter_table = [["#4-40", inch(0.7)],
                                     ["#6-32", inch(0.7)]];
  thumbscrew_knurl_size_table = [["#4-40", inch(0.1)],
                                 ["#6-32", inch(0.1)]];
  thumbscrew_num_knurls_table = [["#4-40", 6],
                                 ["#6-32", 6]];
  thumbscrew_height_table = [["#4-40", inch(0.2)],
                             ["#6-32", inch(0.2)]];
  thumbscrew_base_thickness_table = [["#4-40", inch(0.1)],
                                     ["#6-32", inch(0.075)]];
  thumbscrew_wrench_size_table = [["#4-40", inch(1/4)],
                                  ["#6-32", inch(5/16)]];
  thumbscrew_wrench_tol_table = [["#4-40", inch(0.01)],
                                 ["#6-32", inch(0.01)]];
  screw_clearance_diameter_table = [["#4-40", inch(0.135)],
                                    ["#6-32", inch(0.165)]];


  thumbscrew_diameter = 
    major_diam_table[search([size], major_diam_table)[0]][1];

  thumbscrew_knurl_diameter =
    thumbscrew_knurl_diameter_table[search([size],
                                           thumbscrew_knurl_diameter_table)[0]][1];

  thumbscrew_knurl_size = 
    thumbscrew_knurl_size_table[search([size],
                                       thumbscrew_knurl_size_table)[0]][1];
  thumbscrew_num_knurls =
    thumbscrew_num_knurls_table[search([size],
                                       thumbscrew_num_knurls_table)[0]][1];
  thumbscrew_height = (height > 0) ? height :
    thumbscrew_height_table[search([size],
                                   thumbscrew_height_table)[0]][1];
  thumbscrew_base_thickness =
    thumbscrew_base_thickness_table[search([size],
                                           thumbscrew_base_thickness_table)[0]][1];
  thumbscrew_wrench_size =
    thumbscrew_wrench_size_table[search([size],
                                        thumbscrew_wrench_size_table)[0]][1];
  thumbscrew_wrench_tol =
    thumbscrew_wrench_tol_table[search([size],
                                       thumbscrew_wrench_tol_table)[0]][1];
  screw_clearance_diameter = 
    screw_clearance_diameter_table[search([size],
                                          screw_clearance_diameter_table)[0]][1];

  // calculation based on hex-shaped nut
  thumbscrew_nut_diameter = (thumbscrew_wrench_size +
                             thumbscrew_wrench_tol) / cos(30);

  difference()
  {
    // main body
    rotate([0, 0, 180/thumbscrew_num_knurls])
    {
      cylinder($fn=thumbscrew_num_knurls*3,
               r=thumbscrew_diameter/2,
               h=thumbscrew_height);
    }
    // thru hole
    translate([0, 0, -epsilon])
    {
      cylinder($fn=max(3, round(2*screw_clearance_diameter)),
               r=screw_clearance_diameter/2, h=inch(1));
    }
    // nut recess
    translate([0, 0, thumbscrew_base_thickness])
    {
      cylinder($fn=6, r=thumbscrew_nut_diameter/2, h=inch(1));
    }
    for(i = [0 : thumbscrew_num_knurls-1])
    {
      translate([0.5*thumbscrew_knurl_diameter*
                 cos(30+360*i/thumbscrew_num_knurls),
                 0.5*thumbscrew_knurl_diameter*
                 sin(30+360*i/thumbscrew_num_knurls),
                 -epsilon])
      {
        cylinder($fn=thumbscrew_num_knurls*2,
                 r = thumbscrew_knurl_size, inch(1.0));
      }
    }
  }
}

thumbscrew("#4-40");
