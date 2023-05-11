module collision_wall(input[10:0] Car_X_Pos, Car_Y_Pos, Car_Size, 
							input vga_clk,
							 output in_bounds_vertical, in_bounds_horizontal

);

logic [10:0]  x_center, y_center, x_top, y_top, x_bottom, y_bottom, x_left, y_left, x_right, y_right, y_front, y_back, x_front, x_back;

always_ff  @ (posedge vga_clk)
begin

x_front <= Car_X_Pos + Car_Size/2;
y_front <= Car_Y_Pos;


x_back <= x_front;
y_back <= Car_Y_Pos + Car_Size;


x_right <= Car_X_Pos + Car_Size;
y_right <= Car_Y_Pos + Car_Size/2;


x_left <= Car_X_Pos;
y_left <= y_right;


in_bounds_vertical <= 0;
in_bounds_horizontal <= 0;




// vertical motion

if (44 < y_front && y_back < 444)
begin
   if ((59  < x_left && x_right < 86)  ||
       (120 < x_left && x_right < 147) ||
       (184 < x_left && x_right < 211) ||
		(249 < x_left && x_right < 276) ||
		(311 < x_left && x_right < 337) ||
       (378 < x_left && x_right < 404) ||
       (446 < x_left && x_right < 473) ||
       (502 < x_left && x_right < 529) ||
       (567 < x_left && x_right < 594)  )
       in_bounds_vertical <= 1;
end

// horizontal  
if (0 < x_left && x_right < 640)
begin
   if (41 < y_front && y_back < 66 ||
       175 < y_front && y_back < 197 ||
       231 < y_front && y_back < 258 ||
       297 < y_front && y_back < 324 ||
       358 < y_front && y_back < 384 ||
       417 < y_front && y_back < 445  )
       in_bounds_horizontal <= 1;
end

		
end
endmodule 