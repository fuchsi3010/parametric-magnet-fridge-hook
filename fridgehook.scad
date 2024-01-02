
$fn=80;

magnet_amount = 2;
magnet_height = 2;
magnet_diameter = 8;

baseplate_width = magnet_diameter+20;
baseplate_height = magnet_amount*magnet_height+0.2+0.6; //0.2 = bottom thickness (low --> good magnet strength), 0.6 = top thickness
baseplate_chamfer = 2;
difference(){
  union(){
    difference(){
      baseplate();
      union(){
        translate([-35,0,0.2]) magnet_cavity();
        translate([35,0,0.2]) magnet_cavity();
        translate([0,0,0.2]) magnet_cavity();
      }
    }
    hook();
  }
  chamfer_apply();
}
module baseplate(){
  translate([0,0,(magnet_amount*magnet_height+0.2+0.6)/2])
  cube([100,baseplate_width,baseplate_height], center=true); //thickness: 4mm for magnets    
}

module magnet_cavity() {
  cylinder(h=magnet_height*magnet_amount, r=magnet_diameter);
}

module hook() {
  difference(){   
     translate([0,0,baseplate_height/2]) 
       rotate([0,7,0]) 
       cylinder(h=5, r1=12, r2=5);
     baseplate();
  }

  difference(){
    translate([0,0,baseplate_height/2]) 
      rotate([0,7,0]) 
      cylinder(h=60, r1=5, r2=4);
    baseplate();
  }
}

module chamfer_struct(){
  difference(){
    square([baseplate_chamfer,baseplate_chamfer]);
    circle(r=baseplate_chamfer);
  }
}


module chamfer_apply(){
rotate([0,-90,0]) translate([baseplate_height-baseplate_chamfer,baseplate_width/2-baseplate_chamfer,-50]) linear_extrude(100) chamfer_struct();
rotate([180,270,0]) translate([baseplate_height-baseplate_chamfer,baseplate_width/2-baseplate_chamfer,-50]) linear_extrude(100) chamfer_struct();
rotate([90,-90,0]) translate([baseplate_height-baseplate_chamfer,50-2,-baseplate_width/2]) linear_extrude(baseplate_width) chamfer_struct();
rotate([-90,-90,0]) translate([baseplate_height-baseplate_chamfer,50-2,-baseplate_width/2]) linear_extrude(baseplate_width) chamfer_struct();

}