module pedestrianCollision(input [10:0] Car_X_Pos, Car_Y_Pos, Car_Size, man_X_Pos, man_Y_Pos, man_Size,
									input vga_clk,
									output hit_man,
									output [3:0] test_var);
		
logic [10:0] x_right_edge, y_right_edge, x_left_edge, y_left_edge, x_top_edge, y_top_edge, x_bottom_edge, y_bottom_edge, man_x_right_edge, man_y_right_edge, man_x_left_edge,
					man_y_left_edge, man_x_top_edge, man_y_top_edge, man_x_bottom_edge, man_y_bottom_edge;
logic [10:0] x_center, y_center;

always_comb // @ (posedge vga_clk)
begin

x_center = Car_X_Pos + Car_Size/2;
y_center = Car_Y_Pos + Car_Size/2;

x_right_edge = Car_X_Pos + Car_Size;
y_right_edge = Car_Y_Pos + Car_Size/2;


x_left_edge = Car_X_Pos;
y_left_edge = Car_Y_Pos + Car_Size/2;


x_top_edge = Car_X_Pos + Car_Size/2;
y_top_edge = Car_Y_Pos;


x_bottom_edge = Car_X_Pos + Car_Size/2;
y_bottom_edge = Car_Y_Pos + Car_Size;

//-----------------------------------------------

man_x_right_edge = man_X_Pos + man_Size;
man_y_right_edge = man_Y_Pos + man_Size/2;


man_x_left_edge = man_X_Pos;
man_y_left_edge = man_Y_Pos + man_Size/2;


man_x_top_edge = man_X_Pos + man_Size/2;
man_y_top_edge = man_Y_Pos;


man_x_bottom_edge = man_X_Pos + man_Size/2;
man_y_bottom_edge = man_Y_Pos + man_Size;

// if the left of car is between the pedestrian values and the y values are between where the man runs

//if ((man_x_left_edge <= x_left_edge && x_left_edge <= man_x_right_edge) && (man_x_top_edge <= x_top_edge && man_x_bottom_edge >= x_bottom_edge))
//	hit_man = 1;
//
//// right of car
//else if ((man_x_left_edge <= x_right_edge && x_right_edge <= man_x_right_edge) && (man_x_top_edge <= x_top_edge && man_x_bottom_edge >= x_bottom_edge))
//	hit_man = 1;

//---------------------------------------------------------------------------------

//if ((man_x_left_edge <= x_left_edge && x_left_edge <= man_x_right_edge) && (man_y_top_edge - 5 <= y_top_edge && man_y_bottom_edge + 5 >= y_bottom_edge) && (man_y_top_edge - 5 <= y_top_edge && man_y_bottom_edge + 5 >= y_bottom_edge))
//	hit_man = 1;
//
//// right of car
//else if ((man_x_left_edge <= x_right_edge && x_right_edge <= man_x_right_edge) && (man_y_top_edge - 5 <= y_top_edge && man_y_bottom_edge + 5 >= y_bottom_edge)&& (man_y_top_edge - 5 <= y_top_edge && man_y_bottom_edge + 5 >= y_bottom_edge))
//	hit_man = 1;
//
//// checking center of car
//else if ((man_x_left_edge <= x_center && x_center <= man_x_right_edge) && (man_y_top_edge <= y_center && y_center <= man_y_bottom_edge))
//	hit_man = 1;
//
//else 
//	hit_man = 0;

//------------------------------------------------------------------------------------------
//
hit_man = 0;

if (358 < y_bottom_edge && y_bottom_edge < 384)
	begin
		if (man_x_left_edge <= x_right_edge && x_right_edge <= man_x_right_edge)
			hit_man = 1;
		else if (man_x_left_edge <= x_left_edge && x_left_edge <= man_x_right_edge)
			hit_man = 1;
	end
	
else if (358 < y_top_edge && y_top_edge < 384)
	begin
		if (man_x_left_edge <= x_right_edge && x_right_edge <= man_x_right_edge)
			hit_man = 1;
		else if (man_x_left_edge <= x_left_edge && x_left_edge <= man_x_right_edge)
			hit_man = 1;
	end
	
else if ((358 < y_bottom_edge && y_bottom_edge < 384) && (358 < y_top_edge && y_top_edge < 384))
	begin
		if (man_x_left_edge <= x_right_edge && x_right_edge <= man_x_right_edge)
			hit_man = 1;
		else if (man_x_left_edge <= x_left_edge && x_left_edge <= man_x_right_edge)
			hit_man = 1;
	end
	

//if (x_right_edge == man_x_left_edge)
//	hit_man = 1;
//else if (x_left_edge == man_x_right_edge)
//	hit_man = 1;
//else if ((y_top_edge == man_y_bottom_edge) && (x_right_edge == man_x_left_edge))
//	hit_man = 1;
//else if ((y_bottom_edge == man_y_top_edge) && (x_right_edge == man_x_left_edge))
//	hit_man = 1;
//else if ((y_top_edge == man_y_bottom_edge) && (x_left_edge == man_x_right_edge))
//	hit_man = 1;
//else if ((y_bottom_edge == man_y_top_edge) && (x_left_edge == man_x_right_edge))
//	hit_man = 1;
	

end


always_comb

begin

test_var = 4'b0;
if (x_right_edge == man_x_left_edge)
	test_var[0] = 1;
else if (x_left_edge == man_x_right_edge)
	test_var[1] = 1;
else if (y_top_edge == man_y_bottom_edge)
	test_var[2] = 1;
else if (y_bottom_edge == man_y_top_edge)
	test_var[3] = 1;
 
	

end
								
									
endmodule
