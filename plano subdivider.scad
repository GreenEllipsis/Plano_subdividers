/** @brief customizable subdivider for Plano tackle boxes
    @author Brian Alano, Green Ellipsis
    @copyright 2023, Green Ellipsis. Released under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    @version 2.4.1 change 3750 mold 3666 to 3999
    @version 2.4.0 mm sizes in Customizer. Add flutes to 3700/4005.
    @version 2.3.0 make double-fluting the default
    @version 2.2.0 optionals flutes on both sides for less warping
    @version 2.1.0
    @note Minor changes: for custom, engraves actual width and length instead of percentages
    @note v2.0.0
    Major changes: renamed engraveed text to engraved text
    Minor changes: added flutes for strength and to increase storage volume. Only meaured for Plano 3750 mold 4000.
    @note v1.3.0 
    Minor changes: added extra-large size. Changed default percentage to 100%
    Bugfixes: fixed dimensions of model 3750 model 4000
    @note v1.2.0 added Plano 3450. Added presets.
    @note v1.1.0 rounded vertical corners
    
*/
/* [presets] */
//Plano 3700/4005:  Plano 3750/3999  Plano 3750/4000: 
model = 1; // [0:custom,1:"Plano 3450 S:31.2x48.6 M:31.2x96 L:31.2x99",2:"Plano 3700 S:52.5x50.2 M:52.5x50.2",3:"Plano 3700 Mold 4005 S:52.5x46.2 M:340x44.1",4:"Plano 3750 Mold 3999 S:24.5x46.2 M:52.5x95.5 L:52.5x95.5",5:"Plano 3750 Mold 4000 S:24.5x45.8 M:52.5x95.5 L:339x45 XL:339x90.8"]
// which division in the container are we sub-dividing? Ignored for custom. If a model has less than four divisions, the larger settings will be repeat the largest size. Sizes are sorted by left-to-right dimension first.
division = 0; // [0:small, 1:medium, 2:large, 3:extra-large]

/* [features] */
// percentage of the division's width to fill
left_to_right_percentage = 100; //[1:100]
// percentage of the division's length to fill
front_to_back_percentage = 100; //[1:100]
// render as a solid block for spiral/vase mode printing?
spiral_vase_mode = "yes"; //["no","yes"]
// include engraved text on the bottom listing model and size?
engrave_text = "yes"; //["no","yes"]
// start flutes from the left or right side. Flutes wrap around the original divider slots, but also reduce warping of long sides.
flute_start_end = "left"; // ["right", "left"]
flutes_both_sides = "yes"; //["no", "yes"]

/* [custom] */
// set model to custom to use custom_width
custom_width = 52.5; 
// set model to custom to use custom_length
custom_length = 45.7; 
// set model to custom to use custom_height
custom_height = 44; 
// Thickness of the walls and bottom. Ignored for vase mode
wall_thickness = 0.9;
// Chamfer distance from the front/back edge. Should be large enough to account for any radius in the container
horizontal_chamfer = 4.5;
// Chamfer distance from the bottom edge. A relatively large chamfer improves printability in vase mode.
vertical_chamfer = 9;
// gap between subdivisions to account for tolerance or allow easy sliding
gap=0.5;
text_depth = 0.25;
/* [Hidden] */
epsilon=0.01;
NAME=4; // column in size[]
FLUTE_TYPE=3; // column in size[]
// array is [small_division_size, medium_division_size, large_division_size, extra_large_division_size, name, flute_type], where
// size is width, length, height (x, y, z) and flute_type.
// If container less than 3 divisions, duplicate the last division to make 3.
// These measurements include an inset of about 0.4 mm 
size = [
    [ [custom_width, custom_length, custom_height, 0], [custom_width, custom_length, custom_height, 0], [custom_width, custom_length, custom_height, 0],[custom_width, custom_length, custom_height, 0], "custom"],
    [ [31.2, 48.6, 29.2, 0],[31.2, 96, 29.2, 0],[31.2, 99, 29.2, 0],[0,0,0,0, 0], "Plano 3450"],
    [ [52.5, 50.2, 43.5, 0],[52.5, 50.2, 43.5, 0],[0, 0,0,0,0],[0, 0,0,0,0], "Plano 3700"], // no mold #
    [ [52.5, 46.2, 43.5, 0],[57*5+52.5, 41.8+2.3, 43.5, 1],[0,0,0,0, 0],[0,0,0,0, 0], "Plano 3700 Mold 4005"],
    [ [24.5, 46.2, 44, 0],[52.5, 95.5, 44, 0],[52.5, 95.5, 44, 0],[0,0,0,0,0], "Plano 3750 Mold 3999"],
    [ [24.5, 45.8, 43.8, 0],[52.5, 95.5, 43.8, 0],[140*2+59, 45, 43.8, 1],[140*2+59, 90.8, 43.8, 2], "Plano 3750 Mold 4000"],
      ];
// flute_type is [bottom_width, depth, top_width, on-center spacing]
flute_type = [
    // Type 0: no flutes
    [ 0, 0, 0, 0], 
    // Type 1: Plano 3750 mold 4000, large division
    [ 8.5, 2.3, 6.4, (151.06-8.5)/5], 
    // Type 2: Plano 3750 mold 4000, x-large division
    [ 8.5, 2.3, 6.4, (151.06-8.5)/2.5], 
    ];
    
model_size = size[model][division];
model_name = size[model][NAME];
flute = flute_type[model_size[FLUTE_TYPE]];
echo(model_name=model_name,model_size=model_size);
width = model_size.x * left_to_right_percentage/100 - gap;
length = model_size.y * front_to_back_percentage/100 - gap;
height = model_size.z;
dimensions = model_name == "custom" 
    ? str(round(width*10)/10, "x", round(length*10)/10 )
    : str((division==0 ? "S" : division==1 ? "M" : division==2 ? "L" : "X") , " ", left_to_right_percentage, "%x", front_to_back_percentage, "%") ;
echo(width=width, length=length, dimensions=dimensions);
bound_height = max(0, height);
bound_width = max(0, width);
bound_length = max(0, length);
bound_vertical_chamfer = max(0, vertical_chamfer);

// a trapezoidal pillar
module flutes(thickness = 0) {
    bottom_w = flute[0];
    depth = flute[1];
    top_w = flute[2];
    spacing = flute[3];
    division_length = model_size.y;
    flute_cnt = floor((model_size.x-1)/spacing);
    flutes_w = (flute_cnt+1) * spacing;
    flutes_offset= (model_size.x - bound_width)/2;
    flute_mirror = flute_start_end == "left" ? [0,0,0] : [1, 0, 0];
    echo(flutes_w=flutes_w, flutes_offset=flutes_offset);
    
    module flute() {
        translate([0,0,-epsilon]) 
            linear_extrude(bound_height+epsilon*2)
            offset(delta=thickness) polygon([[-bottom_w/2, -epsilon], [-top_w/2, depth], [top_w/2, depth], [bottom_w/2, -epsilon]]);
    }
    
    module row() {
        // start flutes from the left
        for(x = [spacing: spacing: spacing*flute_cnt]) {
            translate([x-flutes_w/2+flutes_offset, -division_length/2]) flute();    
        }
    }
    
    if (bottom_w > 0) { // skip if flute has 0 width (i.e. no flute)
        mirror(flute_mirror) {
            if (flutes_both_sides == "yes") {
                reflect([0,1,0]) 
                    translate([0, (division_length-bound_length)/2])
                    row();
            } else {
                    translate([0, (division_length-bound_length)/2]) 
                    row();
            }            
        }
    }
}
    
module profile(width, length, radius) {
    offset(radius) square([width, length], center=true);
}

module shape(inset = 0) {    
    bound_chamfer = min(horizontal_chamfer, (bound_height - inset), bound_width/2 - inset, bound_length/2 - inset);
    w2 = bound_width/2 - inset;
    l2 = bound_length/2 - inset;
    wc = w2 - bound_chamfer;
    lc = l2 - bound_chamfer;
    q1 = [[w2, lc], [wc, l2] ];
    q2 = [[-wc, l2], [-w2, lc]];
    q3 = -q1;
    q4 = -q2;
    s = (height - inset) - bound_vertical_chamfer;
    if (lc <=0) {
        text("front to back % too low");
    } else if (wc <=0) {
        text("left to right % too low");
    } else {
        
        profile = concat(q1, q2, q3, q4);
        echo(w2=w2, l2=l2,wc=wc,lc=lc);
        echo(profile=profile);
        // base
        hull() {
           linear_extrude(epsilon) square([w2*2, lc*2], center=true);
            translate([0,0, bound_vertical_chamfer]) linear_extrude(epsilon) profile(wc*2, lc*2, bound_chamfer);
        }
        //sides
        translate([0, 0, bound_vertical_chamfer]) linear_extrude(s) profile(wc*2, lc*2, bound_chamfer);
    }
}

module id() {
    available_length = length - horizontal_chamfer * 2 - 4;
    available_width = width - 4;
    long = max(available_length, available_width);
    short = min(available_length, available_width);
    spin = (available_length > available_width) ? 90 : 0;
    thickness = text_depth;
    if (engrave_text=="yes") {
        translate([0,0,-epsilon]) linear_extrude(thickness) rotate([180,0,spin]) {
            translate([0, 0]) resize([long, short/2.2]) text(model_name, font="San Serif",halign="center");
            translate([0, -short/2]) resize([long, short/2.2]) text(dimensions, font="San Serif", halign="center");
        }
    }
}

module model() {
    t = min(wall_thickness, bound_height, bound_width/2, bound_length/2);
    
    if (model_size.x == 0) {
       text("size not defined");
    } else {
        difference() {
            shape();
            id();
            if (spiral_vase_mode == "no") difference() { 
                translate([0,0, t+epsilon]) shape(inset = t);
                flutes(t);
            }
            flutes();
        }
    }
}

module reflect(v) {
    mirror(v) children();
    children();
}
model();
