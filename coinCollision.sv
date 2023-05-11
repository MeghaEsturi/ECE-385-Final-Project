module coinCollision( input [10:0] coin_x_center, coin_y_center, Car_X_Pos, Car_Y_Pos, Car_Size, 
							input [10:0] coin_y_back, coin_y_front, coin_x_left, coin_x_right,
                     input vga_clk, Reset,
                     output collect_coin

);


logic coin_flag;
logic [1:0] coin_size;
//logic [10:0] x_front, y_front, x_back, y_back, x_right, y_right, x_left, y_left;//, coin_y_front, coin_y_back, coin_x_right, coin_x_left;

assign coin_size = 3;
logic [10:0] x_right_edge, y_right_edge, x_left_edge, y_left_edge, x_top_edge, y_top_edge, x_bottom_edge, y_bottom_edge;


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

//if ((x_left_edge < coin_x_left && x_left_edge < coin_x_right) && (coin_y_front < y_right_edge && y_right_edge < coin_y_back))
//	coin_flag <= 1;

if ((coin_x_left < x_right_edge && x_right_edge < coin_x_right) && (coin_y_front < y_right_edge && y_right_edge < coin_y_back))
		coin_flag <= 1;

else if ((x_right_edge < coin_x_left && coin_x_right < x_right_edge) && ( y_top_edge < coin_y_front && coin_y_back < y_bottom_edge))
		coin_flag <= 1;

	
else if ((coin_x_left < x_right_edge && x_right_edge < coin_x_right) && (coin_y_front < y_right_edge && y_right_edge < coin_y_back))
	coin_flag <= 1;


else if ((coin_x_left < x_left_edge && x_left_edge < coin_x_right) && (coin_y_front < y_left_edge && y_left_edge < coin_y_back))
	coin_flag <= 1;


else if ((coin_x_left < x_bottom_edge && x_bottom_edge < coin_x_right) && (coin_y_front < y_top_edge && y_top_edge < coin_y_back))
	coin_flag <= 1;


//else if ((coin_x_left < x_bottom_edge && x_bottom_edge < coin_x_right) && (coin_y_front < y_bottom_edge && y_bottom_edge < coin_y_back))
//	coin_flag <= 1;

else
	coin_flag <= 0;




//coin_y_front <= coin_y_center - 2;//coin_size/2;
//coin_y_back <= coin_y_center + 2;//coin_size/2;
//coin_x_right <= coin_x_center + 2;//coin_size/2;
//coin_x_left <= coin_x_center - 2;//coin_size/2;

//x_right_edge <= Car_X_Pos + Car_Size;
//y_right_edge <= Car_Y_Pos + Car_Size/2;
//
//
//x_left_edge <= Car_X_Pos;
//y_left_edge <= Car_Y_Pos + Car_Size/2 ;
//
//
//x_top_edge <= Car_X_Pos + Car_Size/2;
//y_top_edge <= Car_Y_Pos;
//
//
//x_bottom_edge <= Car_X_Pos + Car_Size/2;
//y_bottom_edge <= Car_Y_Pos + Car_Size;
//
//
//if ((x_left_edge < coin_x_left && x_right_edge > coin_x_right) ||
//	 (y_top_edge < coin_y_front && y_bottom_edge > coin_y_back) ) 
//   coin_flag <= 1;   
//
//else
//	coin_flag <= 0;  

end	
					
coinFSM collected(.Reset(Reset), .Clk(vga_clk), .coin_flag(coin_flag), .collect_coin(collect_coin));


endmodule
