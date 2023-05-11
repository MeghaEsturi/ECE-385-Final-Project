module lightCollision( input [10:0] light_size, light_center_x, light_center_y, Car_X_Pos, Car_Y_Pos, Car_Size, top_bound, bottom_bound,
		input [10:0] left_bound, right_bound,
       input vga_clk, RED_EN, 
       output light_collision  
);


logic [10:0] x_right_edge, y_right_edge, x_left_edge, y_left_edge, x_top_edge, y_top_edge, x_bottom_edge, y_bottom_edge;


//assign light_collision = 0;

always_ff @ (posedge vga_clk)
begin


x_right_edge <= Car_X_Pos + Car_Size;
y_right_edge <= Car_Y_Pos + Car_Size/2;// -4;


x_left_edge <= Car_X_Pos;
y_left_edge <= Car_Y_Pos + Car_Size/2;// -4;


x_top_edge <= Car_X_Pos + Car_Size/2;
y_top_edge <= Car_Y_Pos;// - 4;


x_bottom_edge <=Car_X_Pos + Car_Size/2;
y_bottom_edge <=Car_Y_Pos + Car_Size;// - 4;

if (RED_EN)
begin
	if ((left_bound < x_right_edge && x_right_edge < right_bound) && (top_bound < y_right_edge && y_right_edge < bottom_bound))
		light_collision <= 1;


	else if ((left_bound < x_left_edge && x_left_edge < right_bound) && (top_bound < y_left_edge && y_left_edge < bottom_bound))
		light_collision <= 1;


	else if ((left_bound < x_bottom_edge && x_bottom_edge < right_bound) && (top_bound < y_top_edge && y_top_edge < bottom_bound))
		light_collision <= 1;


	else if ((left_bound < x_bottom_edge && x_bottom_edge < right_bound) && (top_bound < y_bottom_edge && y_bottom_edge < bottom_bound))
		light_collision <= 1;
end

else
	light_collision <= 0;

end

endmodule

