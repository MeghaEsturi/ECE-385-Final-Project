module  numberSign (	input [10:0] X_Center, Y_Center,
							output [10:0]  NumberWonX, NumberWonY, NumberWonS);
    
    logic [10:0] NumberWon_Size;
	 logic [10:0] NumberWon_X_Center, NumberWon_Y_Center;
	
	 assign NumberWon_X_Center = X_Center;  // Center position on the X axis
    assign NumberWon_Y_Center = Y_Center;  // Center position on the Y axis
    assign NumberWon_Size = 15;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"10        
       
    assign NumberWonX = NumberWon_X_Center;
    assign NumberWonY = NumberWon_Y_Center;
    assign NumberWonS = NumberWon_Size;

endmodule
