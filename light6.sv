//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  light6 ( input Reset, frame_clk,
					 input [9:0]  x_center, y_center,
               output [9:0]  lightX, lightY, lightS);
    
    logic [9:0] light_X_Pos, light_Y_Pos, light_Size;
	 
	 logic [9:0] light_X_Center, light_Y_Center;
	 
//    parameter [9:0] light_X_Center = x_center;  // Center position on the X axis
//    parameter [9:0] light_Y_Center = y_center;  // Center position on the Y axis

	 assign light_X_Center = x_center;  // Center position on the X axis
    assign light_Y_Center = y_center;  // Center position on the Y axis

    assign light_Size = 7;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
       always_comb
        begin 
				light_Y_Pos = light_Y_Center;
				light_X_Pos = light_X_Center;
        end
       
    assign lightX = light_X_Pos;
   
    assign lightY = light_Y_Pos;
   
    assign lightS = light_Size;
    

endmodule
