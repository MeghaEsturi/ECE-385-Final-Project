module  introSign (output [9:0]  CarWonX, CarWonY, CarWonS);

	 logic [9:0] CarWon_X_Pos, CarWon_Y_Pos, CarWon_Size;
	 logic [9:0] CarWon_X_Center, CarWon_Y_Center;
	
	 assign CarWon_X_Center = 320;  // Center position on the X axis
    assign CarWon_Y_Center = 240;  // Center position on the Y axis

    assign CarWon_Size = 10;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"10
    assign CarWonX = CarWon_X_Center;
    assign CarWonY = CarWon_Y_Center;
    assign CarWonS = CarWon_Size;
    

endmodule
