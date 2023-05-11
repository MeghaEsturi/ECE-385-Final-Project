module  CarWonSign (output [9:0]  CarWonX, CarWonY, CarWonS);
    
    logic [9:0] CarWon_X_Pos, CarWon_Y_Pos, CarWon_Size;
	 logic [9:0] CarWon_X_Center, CarWon_Y_Center;
	
	 assign CarWon_X_Center = 250;  // Center position on the X axis
    assign CarWon_Y_Center = 23;  // Center position on the Y axis

    assign CarWon_Size = 10;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"10
   
//    always_ff @ (posedge Reset or posedge frame_clk )
//    begin: start_man
//        begin 
//				man_Y_Pos <= man_Y_Center;
//				man_X_Pos <= man_X_Center;
//        end
//	end
//           
       
    assign CarWonX = CarWon_X_Pos;
			
    assign CarWonY = CarWon_Y_Pos;
   
    assign CarWonS = CarWon_Size;
    

endmodule
