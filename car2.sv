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

//PURPLE CAR

module  car2 ( input Reset, frame_clk, vga_clk,
					input [7:0] keycode, keycode2,
					input [10:0] X_CENTER, Y_CENTER,
					input RED_EN, RED_EN_W6, RED_EN_FOURTH, RED_EN_FIFTH,
               output [10:0]  BallX, BallY, BallS,
					output purpleCarWon);
    
    logic [10:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size, Ball_X_Center, Ball_Y_Center, side_x;
	 logic in_bounds_horizontal, in_bounds_vertical;
	 assign Ball_X_Center = X_CENTER;
	 assign Ball_Y_Center = Y_CENTER;
	
    parameter [10:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [10:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [10:0] Ball_Y_Min=36;       // Topmost point on the Y axis
    parameter [10:0] Ball_Y_Max=444;     // Bottommost point on the Y axis
    parameter [10:0] Ball_X_Step=2;      // Step size on the X axis
    parameter [10:0] Ball_Y_Step=2;      // Step size on the Y axis
	 

    assign Ball_Size = 8;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 
	 logic hitLight_FourthClark, hitLight_FourthJohn, hitLight_FifthChalmers, hitLight_FifthStoughton, hitLight_wrightSpringfield, hitLight_SixthWhite, hitLight_WrightGreen, hitLight_SixthHealey;
	 
   
    always_ff @ (posedge Reset or posedge frame_clk ) 
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Y_CENTER;
				Ball_X_Pos <= X_CENTER;
        end

		  
//		  else if (hitLight_wrightSpringfield && RED_EN)
//		  begin
//				Ball_Y_Pos <= 619;
//				Ball_X_Pos <= 431;
//		  end
//		  
           
        else 
        begin 
							
				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max)  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
				
				  else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max)  // Ball is at the Right edge, BOUNCE!
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min)  // Ball is at the Left edge, BOUNCE!
					  Ball_X_Motion <= Ball_X_Step;		  
				 else begin
					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
		
					  
				if(keycode == 8'h04 || keycode2 == 8'h04)
				begin
					if (in_bounds_horizontal)
						begin
							Ball_X_Motion <= -2;//A
							Ball_Y_Motion<= 0; 
						end
				
				end
					
					
					
				else if((keycode == 8'h07 || keycode2 == 8'h07))
				begin
					if (in_bounds_horizontal)
					
						begin
							Ball_X_Motion <= 2;//D
							Ball_Y_Motion<= 0;
						 end
					
				end
					
				else if((keycode == 8'h16 || keycode2 == 8'h16))
				begin
					if (in_bounds_vertical)
					
						begin
							Ball_X_Motion <= 0;//S
							Ball_Y_Motion<= 2;
						 end
					
				end
					
				else if((keycode == 8'h1A || keycode2 == 8'h1A))
				begin
					if (in_bounds_vertical)
					
						begin
							Ball_X_Motion <= 0;//W
							Ball_Y_Motion<= -2;
						 end
					
				end
		  
						 
				else 
					begin
						Ball_X_Motion <= 0;
						Ball_Y_Motion <= 0;
					end
					
				 end
				 
				if (hitLight_FourthClark || hitLight_FourthJohn || hitLight_FifthChalmers || hitLight_FifthStoughton || hitLight_wrightSpringfield || hitLight_SixthWhite || hitLight_WrightGreen || hitLight_SixthHealey)
				begin
					Ball_Y_Pos <= 430;
					Ball_X_Pos <= 601;
				end
				
				else 
				begin
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				end
		end
	end
			  

    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
	

	 
 collision_wall for_car(.Car_X_Pos(Ball_X_Pos),
							  .Car_Y_Pos(Ball_Y_Pos),
							  .vga_clk(vga_clk),
							  .Car_Size(BallS),
							  .in_bounds_vertical(in_bounds_vertical),
							  .in_bounds_horizontal(in_bounds_horizontal) );
			

lightCollision WrightSpringField (.light_size(7),
											 .light_center_x(265),
											 .light_center_y(180),
											 .RED_EN(RED_EN),
											 .Car_X_Pos(Ball_X_Pos),
											 .Car_Y_Pos(Ball_Y_Pos),
											 .Car_Size(BallS),
											 .top_bound(177),	
											 .bottom_bound(183),
											 .left_bound(262),	
											 .right_bound(268),	
											 .vga_clk(vga_clk),
											 .light_collision(hitLight_wrightSpringfield));
									
lightCollision SixthWhite (.light_size(7),
							 .light_center_x(135),
							 .light_center_y(245),
							 .RED_EN(RED_EN_W6),
						 	 .Car_X_Pos(Ball_X_Pos),
							 .Car_Y_Pos(Ball_Y_Pos),
							 .Car_Size(BallS),
							 .top_bound(241),	
							 .bottom_bound(248),
							 .left_bound(132),	
							 .right_bound(138),							
							 .vga_clk(vga_clk),
							 .light_collision(hitLight_SixthWhite));
							
lightCollision WrightGreen (.light_size(7),
							 .light_center_x(325),
							 .light_center_y(180),
							 .RED_EN(RED_EN_W6),
							 .Car_X_Pos(Ball_X_Pos),
							 .Car_Y_Pos(Ball_Y_Pos),
							 .Car_Size(BallS),
							 .top_bound(176),	
							 .bottom_bound(184),
							 .left_bound(321),	
							 .right_bound(329),							
							 .vga_clk(vga_clk),
							 .light_collision(hitLight_WrightGreen));
							
lightCollision SixthHealey (.light_size(7),
							 .light_center_x(391),
							 .light_center_y(245),
							 .RED_EN(RED_EN_W6),
							 .Car_X_Pos(Ball_X_Pos),
							 .Car_Y_Pos(Ball_Y_Pos),
							 .Car_Size(BallS),
							 .top_bound(241),	
							 .bottom_bound(249),
							 .left_bound(387),	
							 .right_bound(395),							
							 .vga_clk(vga_clk),
							 .light_collision(hitLight_SixthHealey));
							
lightCollision FifthStoughton (.light_size(7),
							 .light_center_x(198),
							 .light_center_y(311),
							 .RED_EN(RED_EN_FIFTH),
							 .Car_X_Pos(Ball_X_Pos),
							 .Car_Y_Pos(Ball_Y_Pos),
							 .Car_Size(BallS),
							 .top_bound(308),	
							 .bottom_bound(315),
							 .left_bound(194),	
							 .right_bound(202),							
							 .vga_clk(vga_clk),
							 .light_collision(hitLight_FifthStoughton));
							
lightCollision FifthChalmers (.light_size(7),
							 .light_center_x(581),
							 .light_center_y(311),
							 .RED_EN(RED_EN_FIFTH),
							 .Car_X_Pos(Ball_X_Pos),
							 .Car_Y_Pos(Ball_Y_Pos),
							 .Car_Size(BallS),
							 .top_bound(308),	
							 .bottom_bound(315),
							 .left_bound(577),	
							 .right_bound(585),							
							 .vga_clk(vga_clk),
							 .light_collision(hitLight_FifthChalmers));
			
lightCollision FifthJohn (.light_size(7),
							 .light_center_x(460),
							 .light_center_y(371),
							 .RED_EN(RED_EN_FOURTH),
							 .Car_X_Pos(Ball_X_Pos),
							 .Car_Y_Pos(Ball_Y_Pos),
							 .Car_Size(BallS),
							 .top_bound(308),	
							 .bottom_bound(315),
							 .left_bound(365),	
							 .right_bound(377),							
							 .vga_clk(vga_clk),
							 .light_collision(hitLight_FourthJohn));
							
							
lightCollision FifthClark (.light_size(7),
							 .light_center_x(71),
							 .light_center_y(371),
							 .RED_EN(RED_EN_FOURTH),
							 .Car_X_Pos(Ball_X_Pos),
							 .Car_Y_Pos(Ball_Y_Pos),
							 .Car_Size(BallS),
							 .top_bound(308),	
							 .bottom_bound(315),
							 .left_bound(365),	
							 .right_bound(377),							
							 .vga_clk(vga_clk),
							 .light_collision(hitLight_FourthClark));
							
carWins purpleCar(.Car_X_Pos(Ball_X_Pos), 
						.Car_Y_Pos(Ball_Y_Pos), 
						.Car_Size(Ball_Size), 
						.vga_clk(vga_clk), 
						.carWon(purpleCarWon));
						


endmodule
