module carWins(input [9:0] Car_X_Pos, Car_Y_Pos, Car_Size,
					input vga_clk,
					output carWon

);


logic [9:0] car_right_edge_x, car_right_edge_y;

always_ff @ (posedge vga_clk)

begin

car_right_edge_x = Car_X_Pos + Car_Size;
car_right_edge_y = Car_Y_Pos;

if (car_right_edge_x < 90 && car_right_edge_y < 66)
	carWon <= 1;

else 
	carWon <= 0;
	
end

endmodule

