module  pedestrian ( input Reset, frame_clk, hit_man, hit_man2,
					//input [10:0] x_center, y_center,
               output [10:0]  manX, manY, manS);
    
 logic [10:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
    parameter [10:0] Ball_X_Center=0;  // Center position on the X axis
    parameter [10:0] Ball_Y_Center=360;  // Center position on the Y axis
    parameter [10:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [10:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [10:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [10:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [10:0] Ball_X_Step=3;      // Step size on the X axis
    parameter [10:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign Ball_Size = 8;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= Ball_X_Step; //was 0;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end
           
        else 
        begin //added this
				// if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max)  // Ball is at the bottom edge, BOUNCE!
//					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//					  Ball_Y_Motion <= Ball_Y_Step;
					
						
				 if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
					  Ball_X_Motion <= Ball_X_Step;		  
				 else 
					begin
					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  
				 
//				 case (keycode)
//					8'h04 : begin
//
//								Ball_X_Motion <= -1;//A
//								Ball_Y_Motion<= 0;
//							  end
//					        
//					8'h07 : begin
//								
//					        Ball_X_Motion <= 1;//D
//							  Ball_Y_Motion <= 0;
//							  end
//
//							  
//					8'h16 : begin
//
//					        Ball_Y_Motion <= 1;//S
//							  Ball_X_Motion <= 0;
//							 end
//							  
//					8'h1A : begin
//					        Ball_Y_Motion <= -1;//W
//							  Ball_X_Motion <= 0;
//							 end	  
//					default: ;
//			   endcase
				
				end //added this
				
				if (hit_man || hit_man2)
					Ball_X_Pos <= Ball_X_Pos;
				
				else
				begin
				 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				end
				
		end  
    end
       
    assign manX = Ball_X_Pos;
   
    assign manY = Ball_Y_Pos;
   
    assign manS = Ball_Size;
    

endmodule





//-------------------------------------------------------------------------


//module  pedestrian ( input Reset, frame_clk,
//					 input [10:0]  x_center, y_center,
//               output [10:0]  manX, manY, manS);
//					
//
 

//   logic [10:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Motion, Ball_Y_Pos, Ball_Size, Ball_X_Center, Ball_Y_Center;
//	 assign Ball_X_Center = x_center;
//	 assign Ball_Y_Center = y_center;
//	
//    parameter [10:0] Ball_X_Min=0;       // Leftmost point on the X axis
//    parameter [10:0] Ball_X_Max=639;     // Rightmost point on the X axis
//    parameter [10:0] Ball_X_Step=1;      // Step size on the X axis
//	 
//    assign Ball_Size = 8;  
//	    
//    always_ff @ (posedge Reset or posedge frame_clk ) 
//    begin: Move_Ball	//begin A
//	 
//        if (Reset)  // Asynchronous Reset
//        begin 	//begin B
//            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
//				Ball_X_Motion <= 10'd1; //Ball_X_Step;
//				Ball_Y_Pos <= y_center;
//				Ball_X_Pos <= x_center;
//        end	//end B
//			
//		
//		  else
//		  begin //begin C
//				 if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max)  // Ball is at the Right edge, BOUNCE!
//					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1); 
//					  
//				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min)  // Ball is at the Left edge, BOUNCE!
//				  Ball_X_Motion <= Ball_X_Step;	
//				
//				 else 
//				 Ball_X_Motion <= Ball_X_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
//										
//		  
//		  end // end C
//		  
//				Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
//						
//		end	//end A
//		
//			  
//
//    assign manX = Ball_X_Pos;
//   
//    assign manY = y_center;
//   
//    assign manS = Ball_Size;
//	
//	
//endmodule


	