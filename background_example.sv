 module background_example (
	input logic [10:0] BallX, BallY, DrawX, DrawY, Ball_size, 
							CAR_X, CAR_Y, CAR_SIZE, 
							lightX, lightY, light_size, 
							lightX1, lightY1,lightX2, lightY2,lightX3, lightY3, lightX4, lightY4, lightX5, lightY5, //lightX6, lightY6, lightX7, lightY7,
							manX, manY, manS, 
							coinX, coinY, coinS, coinX2, coinY2, coinX3, coinY3, coinX4, coinY4, coinX5, coinY5, coinX6, coinY6, coinX7, coinY7, coinX8, coinY8,
							GREEN_EN, RED_EN, YELLOW_EN, GREEN_EN_W6, RED_EN_W6, YELLOW_EN_W6,GREEN_EN_FIFTH, RED_EN_FIFTH, YELLOW_EN_FIFTH,
							GREEN_EN_FOURTH, RED_EN_FOURTH, YELLOW_EN_FOURTH,
							PurpleCarWon_X, PurpleCarWon_Y, PurpleCarWon_Size,
	input logic Execute, vga_clk, blank, walk1, walk2, walk3, purpleCarWon, greenCarWon, Reset, times_up, hit_man, hit_man2,
	input gameState0, gameState1, gameState2,
	input [4:0] time_counter,
	output logic [3:0] red, green, blue, 
	output logic ones_place_number_on, coin1_collided, coin2_collided,
	output logic [3:0] number_of_coins_collected,
	output coin_on
);


//ADD BACK COIN 1 COLLISION

//declaring local variables
logic [18:0] label_rom_address, rom_address, PC_rom_address, GC_rom_address, pedestrian_romAddr, PW_romAddr, intro_rom_address, rules1_rom_address, number_rom_address;
logic [3:0] label_rom_q, rom_q, GC_rom_q, PC_rom_q, GC_palette_red, GC_palette_green, GC_palette_blue, PW_rom_q, GW_rom_q, intro_rom_q, rules1_rom_q, rules2_rom_q;
logic [3:0] zero_rom_q, one_rom_q, two_rom_q, three_rom_q, four_rom_q, five_rom_q, six_rom_q, seven_rom_q, eight_rom_q, nine_rom_q, lose_rom_q, win_rom_q;
logic [3:0] palette_red, palette_green, palette_blue, PC_palette_red, PC_palette_green, PC_palette_blue;
logic PC_on, GC_on, light_on, light_on1, light_on2, light_on3,light_on4, light_on5, light_on6, light_on7, pedestrian_on, CarWon_on, intro_on, /*coin_on,*/ coin2_on, coin3_on, coin4_on, coin5_on, coin6_on, coin7_on, coin8_on;
logic [10:0] intro_DistX, intro_DistY, PC_DistX, PC_DistY, GC_DistX, GC_DistY, man_DistX, man_DistY, purpleCarWon_DistX, purpleCarWon_DistY;
int DistX, DistY, Size, coin_DistX, coin_DistY, number_DistX, number_DistY, coin_DistX2, coin_DistY2, coin_DistX3, coin_DistY3, coin_DistX4, coin_DistY4;
int coin_DistX5, coin_DistY5, coin_DistX6, coin_DistY6, coin_DistX7, coin_DistY7, coin_DistX8, coin_DistY8;
int DistX1, DistY1, DistX2, DistY2, DistX3, DistY3, DistX4, DistY4, DistX5, DistY5, DistX6, DistY6, DistX7, DistY7;
logic [3:0] pedestrian_rom_q, pedestrian_red, pedestrian_green, pedestrian_blue, PW_red, PW_green, PW_blue, GW_red, GW_green, GW_blue;
logic [3:0] intro_screen_palette_red, intro_screen_palette_green, intro_screen_palette_blue;
logic [3:0] zero_palette_red, one_palette_red, two_palette_red, three_palette_red, four_palette_red, five_palette_red, six_palette_red, seven_palette_red, eight_palette_red, nine_palette_red;
logic [3:0] zero_palette_green, one_palette_green, two_palette_green, three_palette_green, four_palette_green, five_palette_green, six_palette_green, seven_palette_green, eight_palette_green, nine_palette_green;
logic [3:0] zero_palette_blue, one_palette_blue, two_palette_blue, three_palette_blue, four_palette_blue, five_palette_blue, six_palette_blue, seven_palette_blue, eight_palette_blue, nine_palette_blue;
logic [3:0] label_palette_red, label_palette_blue, label_palette_green, lose_palette_red, lose_palette_green, lose_palette_blue, win_palette_red, win_palette_green, win_palette_blue;
logic [10:0] numberX, numberY, NumberWonS;
logic tens_place_number_on, timer_second_ones_on, timer_second_tens_on;
logic coin3_collided, coin4_collided, coin5_collided, coin6_collided, coin7_collided, coin8_collided;
//logic ones_place_number_on;
	
	


//calculations for lights

assign Size = light_size;
assign DistX = DrawX - lightX;
assign DistY = DrawY - lightY;

assign DistX1 = DrawX - lightX1;
assign DistY1 = DrawY - lightY1;

assign DistX2 = DrawX - lightX2;
assign DistY2 = DrawY - lightY2;

assign DistX3 = DrawX - lightX3;
assign DistY3 = DrawY - lightY3;

assign DistX4 = DrawX - lightX4;
assign DistY4 = DrawY - lightY4;

assign DistX5 = DrawX - lightX5;
assign DistY5 = DrawY - lightY5;

//assign DistX6 = DrawX - lightX6;
//assign DistY6 = DrawY - lightY6;
//
//assign DistX7 = DrawX - lightX7;
//assign DistY7 = DrawY - lightY7;

//calculating rom addresses
assign PC_DistX = DrawX - BallX;
assign PC_DistY = DrawY - BallY;

assign GC_DistX = DrawX - CAR_X;
assign GC_DistY = DrawY - CAR_Y;

assign man_DistX = DrawX - manX;
assign man_DistY = DrawY - manY;

assign purpleCarWon_DistX = DrawX - PurpleCarWon_X;
assign purpleCarWon_DistY = DrawY - PurpleCarWon_Y;

assign intro_DistX = DrawX - introX;
assign intro_DistY = DrawY - introY;

assign coin_DistX = DrawX - coinX;
assign coin_DistY = DrawY - coinY;

assign coin_DistX2 = DrawX - coinX2;
assign coin_DistY2 = DrawY - coinY2;

assign coin_DistX3 = DrawX - coinX3;
assign coin_DistY3 = DrawY - coinY3;

assign coin_DistX4 = DrawX - coinX4;
assign coin_DistY4 = DrawY - coinY4;

assign coin_DistX5 = DrawX - coinX5;
assign coin_DistY5 = DrawY - coinY5;

assign coin_DistX6 = DrawX - coinX6;
assign coin_DistY6 = DrawY - coinY6;

assign coin_DistX7 = DrawX - coinX7;
assign coin_DistY7 = DrawY - coinY7;

assign coin_DistX8 = DrawX - coinX8;
assign coin_DistY8 = DrawY - coinY8;

assign number_DistX = DrawX - numberX;
assign number_DistY = DrawY - numberY;

logic [9:0] introX, introY, introS;
CarWonSign introSign(.CarWonX(introX), .CarWonY(introY), .CarWonS(introS));

//((r * colSize) + c) * element size
//DrawX-BallX - BallS + (DrawY-BallY - BallS)10

assign GC_rom_address = ((GC_DistY * 20) + GC_DistX);
assign PC_rom_address = ((PC_DistY * 20) + PC_DistX);

assign rom_address = ((DrawX * 640) / 640) + (((DrawY * 480) / 480) * 640);	//background

assign pedestrian_romAddr = (man_DistY*20) + man_DistX;

assign PW_romAddr = (purpleCarWon_DistY*245) + purpleCarWon_DistX;

assign number_rom_address = (number_DistY * 15) + number_DistX;

assign intro_rom_address = (intro_DistY*200) + intro_DistX;//(((DrawX * 150) / 150) + (((DrawY * 100) / 100) * 150));
	
always_comb
begin:Ball_on_proc
  //draw car 2
	PC_on = 1'b0;
//   if ((DrawX >= BallX - Ball_size+9) &&(DrawX <= BallX + Ball_size+11) && (DrawY>= BallY - Ball_size+10) && (DrawY <= BallY + Ball_size + 8))
	if ((DrawX >= BallX - Ball_size+9) &&(DrawX <= BallX + Ball_size+11) && (DrawY>= BallY - Ball_size+10) && (DrawY <= BallY + Ball_size + 8))
		PC_on = 1'b1;

  //draw car 1
	GC_on = 1'b0;
	if ((DrawX >= CAR_X - CAR_SIZE+9) &&(DrawX <= CAR_X + CAR_SIZE+11) && (DrawY >= CAR_Y - CAR_SIZE+10) && (DrawY <= CAR_Y + CAR_SIZE+8))
		GC_on = 1'b1;
		
	//draw pedestrian	
	pedestrian_on = 1'b0;	
	if ((DrawX >= manX - manS + 9) && (DrawX <= manX + manS + 8) && (DrawY >= manY - manS + 9 ) && (DrawY <= manY + manS+11)) // 3 7
		pedestrian_on = 1'b1;
	
	//draw win sign
	CarWon_on = 1'b0;
	if ((DrawX >= 198 + 50) && (DrawX <= 435 + 50) && (DrawY >= 6) && (DrawY <= 37))
		CarWon_on = 1'b1;
	
	//draw intro sign
	intro_on = 1'b0;
	if ((DrawX >= 167) && (DrawX <= 167+200) && (DrawY >= 160) && (DrawY <= 160+150))
		intro_on = 1'b1;
	
	//draw zero
	ones_place_number_on = 1'b0;	//hardcoded to 1 for testing
//	if ((DrawX >= 600 - 20) && (DrawX <= 600 + 20) && (DrawY >= 23 - 20) && (DrawY <= 23 + 20))
	if ((DrawX >= numberX - NumberWonS + NumberWonS) && (DrawX <= numberX + NumberWonS) && (DrawY >= numberY- NumberWonS) && (DrawY <= numberY + NumberWonS - NumberWonS - 5)) 
		ones_place_number_on = 1'b1;
		
	tens_place_number_on = 1'b0;	
	if ((DrawX >= numberX - NumberWonS) && (DrawX <= numberX + NumberWonS - NumberWonS) && (DrawY >= numberY- NumberWonS) && (DrawY <= numberY + NumberWonS - NumberWonS - 5)) 
		tens_place_number_on = 1'b1;
		
	//TIMER VALUES
		
	timer_second_ones_on = 1'b0;	
	if ((DrawX >= numberX - NumberWonS - 570 + 14) && (DrawX <= numberX + NumberWonS - NumberWonS - 573 + 15) && (DrawY >= numberY- NumberWonS + 3) && (DrawY <= numberY + NumberWonS - NumberWonS)) // 0 5
		timer_second_ones_on = 1'b1;
	
	timer_second_tens_on = 1'b0;	
	if ((DrawX >= numberX - NumberWonS - 570) && (DrawX <= numberX + NumberWonS - NumberWonS - 573) && (DrawY >= numberY- NumberWonS) && (DrawY <= numberY + NumberWonS - NumberWonS + 5)) 
		timer_second_tens_on = 1'b1;
		
  //draw wright springfield
  if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
		light_on = 1'b1;
  else 
		light_on = 1'b0;
	
	//draw wright and green
	if ( ( DistX1*DistX1 + DistY1*DistY1) <= (Size * Size) ) 
		light_on1 =1'b1;
	else 
		light_on1 = 1'b0;
	
	//draw sixth and white
	if ( ( DistX2*DistX2 + DistY2*DistY2) <= (Size * Size) ) 
		light_on2 =1'b1;
	else 
		light_on2 = 1'b0;	
		
	//draw sixth and healey
	if ( ( DistX3*DistX3 + DistY3*DistY3) <= (Size * Size) ) 
		light_on3 =1'b1;
	else 
		light_on3 = 1'b0;	
	//draw fifth and stoughton
	if ( ( DistX4*DistX4 + DistY4*DistY4) <= (Size * Size) ) 
		light_on4 =1'b1;
	else 
		light_on4 = 1'b0;	
	//draw fifth and chalmers
	if ( ( DistX5*DistX5 + DistY5*DistY5) <= (Size * Size) ) 
		light_on5 =1'b1;
	else 
		light_on5 = 1'b0;	
	//draw fourth and john
//	if ( ( DistX6*DistX6 + DistY6*DistY6) <= (Size * Size) ) 
//		light_on6 =1'b1;
//	else 
//		light_on6 = 1'b0;	
//		
//	//draw fourth and clark
//	if ( ( DistX7*DistX7 + DistY7*DistY7) <= (Size * Size) ) 
//		light_on7 =1'b1;
//	else 
//		light_on7 = 1'b0;	
		
	//draw coin at 6th and springfield
	if ( ( coin_DistX*coin_DistX + coin_DistY*coin_DistY) <= (coinS * coinS ) )
		coin_on =1'b1;
	else 
		coin_on = 1'b0;
	
	// draw coin Clark & 4th
	if ( ( coin_DistX2*coin_DistX2 + coin_DistY2*coin_DistY2) <= (coinS * coinS ) )
		coin2_on = 1'b1;
	else 
		coin2_on = 1'b0;
		
	if ( ( coin_DistX3*coin_DistX3 + coin_DistY3*coin_DistY3) <= (coinS * coinS ) )
		coin3_on = 1'b1;
	else 
		coin3_on = 1'b0;
		
	if ( ( coin_DistX4*coin_DistX4 + coin_DistY4*coin_DistY4) <= (coinS * coinS ) )
		coin4_on = 1'b1;
	else 
		coin4_on = 1'b0;
		
	if ( ( coin_DistX5*coin_DistX5 + coin_DistY5*coin_DistY5) <= (coinS * coinS ) )
		coin5_on =1'b1;
	else 
		coin5_on = 1'b0;
	
	// draw coin Clark & 4th
	if ( ( coin_DistX6*coin_DistX6 + coin_DistY6*coin_DistY6) <= (coinS * coinS ) )
		coin6_on = 1'b1;
	else 
		coin6_on = 1'b0;
		
	if ( ( coin_DistX7*coin_DistX7 + coin_DistY7*coin_DistY7) <= (coinS * coinS ) )
		coin7_on = 1'b1;
	else 
		coin7_on = 1'b0;
		
	if ( ( coin_DistX8*coin_DistX8 + coin_DistY8*coin_DistY8) <= (coinS * coinS ) )
		coin8_on = 1'b1;
	else 
		coin8_on = 1'b0;

end 


////// KEEPING TRACK OF THE COINS COLLECTED
//register coinsCollected(.Clk(vga_clk), 
//					 .Reset(Reset_h), 
//					 .Load(coin1_collided), 
//					 .D(number_of_coins_collected + 1), 
//					 .Data_Out(number_of_coins_collected));

assign number_of_coins_collected = coin8_collided + coin7_collided + coin6_collided + coin5_collided + coin4_collided + coin3_collided + coin2_collided + coin1_collided;

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;
	

if (blank) 
begin
	
	if (gameState0)
		begin
			red <= intro_screen_palette_red;
			green <= intro_screen_palette_green;
			blue <= intro_screen_palette_blue;
		end
		
	else if (ones_place_number_on && gameState2)
		begin
			if (number_of_coins_collected == 8)
				begin
					red <= eight_palette_red;
					green <= eight_palette_red;
					blue <= eight_palette_red;
				end
			
			else if (number_of_coins_collected == 7)
				begin
					red <= seven_palette_red;
					green <= seven_palette_red;
					blue <= seven_palette_red;
				end
			
			else if (number_of_coins_collected == 6)
				begin
					red <= six_palette_red;
					green <= six_palette_red;
					blue <= six_palette_red;
				end
				
			else if (number_of_coins_collected == 5)
				begin
					red <= five_palette_red;
					green <= five_palette_red;
					blue <= five_palette_red;
				end
				
			else if (number_of_coins_collected == 4)
				begin
					red <= four_palette_red;
					green <= four_palette_red;
					blue <= four_palette_red;
				end
		
			else if (number_of_coins_collected == 3)
				begin
					red <= three_palette_red;
					green <= three_palette_red;
					blue <= three_palette_red;
				end
				
			else if (number_of_coins_collected == 2)
				begin
					red <= two_palette_red;
					green <= two_palette_red;
					blue <= two_palette_red;
				end
			
			else if (number_of_coins_collected == 1) // changed to be OR
				begin
					red <= one_palette_red;
					green <= one_palette_green;
					blue <= one_palette_blue;
				end
				
			else
				begin
					red <= zero_palette_red;
					green <= zero_palette_green;
					blue <= zero_palette_blue;
				end
		end
		
	else if (tens_place_number_on && gameState2)
			begin
				red <= zero_palette_red;
				green <= zero_palette_green;
				blue <= zero_palette_blue;
			end
		
		
	// TIMER
	
	else if (timer_second_tens_on && gameState2)
		begin
		
				if (time_counter / 10 == 0)
				begin
					red <= zero_palette_red;
					green <= zero_palette_green;
					blue <= zero_palette_blue;
				end
				
				else if (time_counter / 10 == 1)
				begin
					red <= one_palette_red;
					green <= one_palette_green;
					blue <= one_palette_blue;
				end
				
				else if (time_counter / 10 == 2)
				begin
					red <= two_palette_red;
					green <= two_palette_green;
					blue <= two_palette_blue;
				end
				
				else if (time_counter / 10 == 3)
				begin
					red <= three_palette_red;
					green <= three_palette_green;
					blue <= three_palette_blue;
				end
				
				else
				begin
					red <= zero_palette_red;
					green <= zero_palette_green;
					blue <= zero_palette_blue;
				end
					
		end
	
	else if(timer_second_ones_on && gameState2)
		begin
		
				if (time_counter % 10 == 0)
				begin
					red <= zero_palette_red;
					green <= zero_palette_green;
					blue <= zero_palette_blue;
				end
				
				else if (time_counter % 10 == 1)
				begin
					red <= one_palette_red;
					green <= one_palette_green;
					blue <= one_palette_blue;
				end
				
				else if (time_counter % 10 == 2)
				begin
					red <= two_palette_red;
					green <= two_palette_green;
					blue <= two_palette_blue;
				end
				
				else if (time_counter % 10 == 3)
				begin
					red <= three_palette_red;
					green <= three_palette_green;
					blue <= three_palette_blue;
				end
				
				else if (time_counter % 10 == 4)
				begin
					red <= four_palette_red;
					green <= four_palette_green;
					blue <= four_palette_blue;
				end
				
				else if (time_counter % 10 == 5)
				begin
					red <= five_palette_red;
					green <= five_palette_green;
					blue <= five_palette_blue;
				end
				
				else if (time_counter % 10 == 6)
				begin
					red <= six_palette_red;
					green <= six_palette_green;
					blue <= six_palette_blue;
				end
				
				else if (time_counter % 10 == 7)
				begin
					red <= seven_palette_red;
					green <= seven_palette_green;
					blue <= seven_palette_blue;
				end
				
				else if (time_counter % 10 == 8)
				begin
					red <= eight_palette_red;
					green <= eight_palette_green;
					blue <= eight_palette_blue;
				end
				
				else if (time_counter % 10 == 9)
				begin
					red <= nine_palette_red;
					green <= nine_palette_green;
					blue <= nine_palette_blue;
				end
				
				else
				begin
					red <= zero_palette_red;
					green <= zero_palette_green;
					blue <= zero_palette_blue;
				end
			
		end

		
	//car 1 purple
	else if (PC_on == 1'b1 && (PC_palette_red != 4'h0 && PC_palette_green!=4'h0 && PC_palette_blue!=4'h0)) 
		begin 
			red <= PC_palette_red;
			green <= PC_palette_green;
			blue <= PC_palette_blue;
		end 
			
	//car 2 green
	else if (GC_on == 1'b1 && (GC_palette_red != 4'h0 && GC_palette_green!=4'h0 && GC_palette_blue!=4'h0))

		begin 
			red <= GC_palette_red;
			green <= GC_palette_green;
			blue <= GC_palette_blue;
		end
		
	else if (coin_on && ~coin1_collided && gameState2)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
	
	else if (coin2_on && gameState2 && ~coin2_collided)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
		
	else if (coin3_on && gameState2 && ~coin3_collided && coin1_collided)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
		
	else if (coin4_on && gameState2 && ~coin4_collided && coin2_collided)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
		
	else if (coin5_on && gameState2 && ~coin5_collided && coin3_collided)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
		
	else if (coin6_on && gameState2 && ~coin6_collided && coin4_collided)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
		
	else if (coin7_on && gameState2 && ~coin7_collided && coin5_collided)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
		
	else if (coin8_on && gameState2 && ~coin8_collided && coin6_collided)
		begin
		red <= 4'hd;
		green <= 4'ha;
		blue <= 4'h2;
		end
	
	// ALL THE COINS - ENCAPSULATE WITH THE GAME STATE IF TEAM PLAYER

		
  //wright and springfield
  else if (light_on && RED_EN)
		begin 
		red <= 4'hf;
		green <= 4'h0;
		blue <= 4'h0;
		end 
  
  else if (light_on && GREEN_EN)
		begin 
		red <= 4'h0;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on && YELLOW_EN)
		begin 
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on)
		begin
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'hf;
		end
  
				
	//wright and green
	else if (light_on1 && RED_EN)
		begin 
		red <= 4'hf;
		green <= 4'h0;
		blue <= 4'h0;
		end 
  
  else if (light_on1 && GREEN_EN)
		begin 
		red <= 4'h0;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on1 && YELLOW_EN)
		begin 
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on1)
		begin
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'hf;
		end
		
	//sixth and white
		else if (light_on2 && RED_EN_W6)
		begin 
		red <= 4'hf;
		green <= 4'h0;
		blue <= 4'h0;
		end 
  
  else if (light_on2 && GREEN_EN_W6)
		begin 
		red <= 4'h0;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on2 && YELLOW_EN_W6)
		begin 
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on2)
		begin
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'hf;
		end
			
	//sixth and healey
	else if (light_on3 && RED_EN_W6)
		begin 
		red <= 4'hf;
		green <= 4'h0;
		blue <= 4'h0;
		end 
  
  else if (light_on3 && GREEN_EN_W6)
		begin 
		red <= 4'h0;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on3 && YELLOW_EN_W6)
		begin 
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on3)
		begin
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'hf;
		end
		
//fifth and stoughton
	else if (light_on4 && RED_EN_FIFTH)
		begin 
		red <= 4'hf;
		green <= 4'h0;
		blue <= 4'h0;
		end 
  
  else if (light_on4 && GREEN_EN_FIFTH)
		begin 
		red <= 4'h0;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on4 && YELLOW_EN_FIFTH)
		begin 
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on4)
		begin
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'hf;
		end
	
//fifth and john
	else if (light_on5 && RED_EN_FIFTH)
		begin 
		red <= 4'hf;
		green <= 4'h0;
		blue <= 4'h0;
		end 
  
  else if (light_on5 && GREEN_EN_FIFTH)
		begin 
		red <= 4'h0;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on5 && YELLOW_EN_FIFTH)
		begin 
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on5)
		begin
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'hf;
		end
		
		

//fourth and chalmers
	else if (light_on6 && RED_EN_FOURTH)
		begin 
		red <= 4'hf;
		green <= 4'h0;
		blue <= 4'h0;
		end 
  
  else if (light_on6 && GREEN_EN_FOURTH)
		begin 
		red <= 4'h0;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on6 && YELLOW_EN_FOURTH)
		begin 
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'h0;
		end 
  
  else if (light_on6)
		begin
		red <= 4'hf;
		green <= 4'hf;
		blue <= 4'hf;
		end
		
		
		

////fourth and chalmers
//	else if (light_on7 && RED_EN_FOURTH)
//		begin 
//		red <= 4'hf;
//		green <= 4'h0;
//		blue <= 4'h0;
//		end 
//  
//  else if (light_on7 && GREEN_EN_FOURTH)
//		begin 
//		red <= 4'h0;
//		green <= 4'hf;
//		blue <= 4'h0;
//		end 
//  
//  else if (light_on7 && YELLOW_EN_FOURTH)
//		begin 
//		red <= 4'hf;
//		green <= 4'hf;
//		blue <= 4'h0;
//		end 
//  
//  else if (light_on7)
//		begin
//		red <= 4'hf;
//		green <= 4'hf;
//		blue <= 4'hf;
//		end

	else if (pedestrian_on && (pedestrian_red != 4'h0 && pedestrian_green!=4'h0 && pedestrian_blue!=4'h0))
		begin
		red <= pedestrian_red;
		green <= pedestrian_green;
		blue <= pedestrian_blue;
		end
		
//	else if (pedestrian_on)
//		begin
//		red <= 4'hf;
//		green <= 4'hf;
//		blue <= 4'hf;
//		end
		
	else if (purpleCarWon && CarWon_on && ~greenCarWon && gameState1)
		begin
		red <= PW_red;
		green <= PW_green;
		blue <= PW_blue;
		end
	else if (~purpleCarWon && CarWon_on && greenCarWon && gameState1)
		begin
		red <= GW_red;
		green <= GW_green;
		blue <= GW_blue;
		end
		
	else if (CarWon_on && gameState2 && (hit_man || hit_man2))
		begin
		red <= lose_palette_red;
		green <= lose_palette_green;
		blue <= lose_palette_blue;
		end
		
	else if (CarWon_on && gameState1 && hit_man)
		begin
		red <= PW_red;
		green <= PW_green;
		blue <= PW_blue;
		end
		
	else if (CarWon_on && gameState1 && hit_man2)
		begin
		red <= GW_red;
		green <= GW_green;
		blue <= GW_blue;
		end
		
	else if (CarWon_on && gameState2 && times_up && number_of_coins_collected < 8)
		begin
		red <= lose_palette_red;
		green <= lose_palette_green;
		blue <= lose_palette_blue;
		end
		
	else if (CarWon_on && gameState2 && times_up && (~greenCarWon || ~purpleCarWon))
		begin
		red <= lose_palette_red;
		green <= lose_palette_green;
		blue <= lose_palette_blue;
		end
	
	else if (CarWon_on && gameState2 && number_of_coins_collected == 8 && greenCarWon && purpleCarWon)
		begin
		red <= win_palette_red;
		green <= win_palette_green;
		blue <= win_palette_blue;
		end
		
	else
	begin
	if (~gameState0)
		begin
			red <= palette_red;
			green <= palette_green;
			blue <= palette_blue;
		end
	end
	
end
	
end

// COIN COLLISIONS
logic coin1_collided_green, coin2_collided_green, coin1_collided_purple, coin2_collided_purple, coin3_collided_green, coin3_collided_purple;
logic coin4_collided_green, coin4_collided_purple, coin5_collided_green, coin5_collided_purple;
logic coin6_collided_green, coin6_collided_purple, coin7_collided_green, coin7_collided_purple;
logic coin8_collided_green, coin8_collided_purple;

always_comb
begin

coin1_collided = coin1_collided_green || coin1_collided_purple;

coin2_collided = coin2_collided_green || coin2_collided_purple;

coin3_collided = coin3_collided_green || coin3_collided_purple;

coin4_collided = coin4_collided_green || coin4_collided_purple;

coin5_collided = coin5_collided_green || coin5_collided_purple;

coin6_collided = coin6_collided_green || coin6_collided_purple;

coin7_collided = coin7_collided_green || coin7_collided_purple;

coin8_collided = coin8_collided_green || coin8_collided_purple;
end


// COIN COLLISIONS IMPLEMENTED FOR GREEEN CAR

coinCollision coin1_greenCar(.coin_x_center(coinX),
										.coin_y_center(coinY),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (243+10), 
										.coin_y_front (243-10), 
										.coin_x_left(262-10), 
										.coin_x_right(262+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin1_collided_green));
										
coinCollision coin2_greenCar(.coin_x_center(coinX2),
										.coin_y_center(coinY2),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (372+10), 
										.coin_y_front (372-10), 
										.coin_x_left(134-10), 
										.coin_x_right(134+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin2_collided_green));

coinCollision coin3_greenCar(.coin_x_center(coinX2),
										.coin_y_center(coinY2),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (309+10), 
										.coin_y_front (309-10), 
										.coin_x_left(392-10), 
										.coin_x_right(392+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin3_collided_green));
										
coinCollision coin4_greenCar(.coin_x_center(coinX4),
										.coin_y_center(coinY4),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (245+10), 
										.coin_y_front (245-10), 
										.coin_x_left(581-10), 
										.coin_x_right(581+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin4_collided_green));
										
										
coinCollision coin5_greenCar(.coin_x_center(coinX5),
										.coin_y_center(coinY5),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (184+10), 
										.coin_y_front (184-10), 
										.coin_x_left(135-10), 
										.coin_x_right(135+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin5_collided_green));
										
coinCollision coin6_greenCar(.coin_x_center(coinX6),
										.coin_y_center(coinY6),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (311+10), 
										.coin_y_front (311-10), 
										.coin_x_left(71-10), 
										.coin_x_right(71+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin6_collided_green));

coinCollision coin7_greenCar(.coin_x_center(coinX7),
										.coin_y_center(coinY7),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (371+10), 
										.coin_y_front (371-10), 
										.coin_x_left(324-10), 
										.coin_x_right(324+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin7_collided_green));
										
coinCollision coin8_greenCar(.coin_x_center(coinX8),
										.coin_y_center(coinY8),
										.Car_X_Pos(CAR_X),
										.Car_Y_Pos(CAR_Y),
										.Car_Size(CAR_SIZE),
										.coin_y_back (55+10), 
										.coin_y_front (55-10), 
										.coin_x_left(519-10), 
										.coin_x_right(519+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin8_collided_green));
										
// COIN COLLISIONS IMPLEMENTED FOR PURPLE CAR

coinCollision coin1_purpleCar(.coin_x_center(coinX),
										.coin_y_center(coinY),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_size),
										.coin_y_back (243+10), 
										.coin_y_front (243-10), 
										.coin_x_left(262-10), 
										.coin_x_right(262+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin1_collided_purple));
										
coinCollision coin2_purpleCar(.coin_x_center(coinX2),
										.coin_y_center(coinY2),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_size),
										.coin_y_back (372+10), 
										.coin_y_front (372-10), 
										.coin_x_left(134-10), 
										.coin_x_right(134+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin2_collided_purple));

coinCollision coin3_purpleCar(.coin_x_center(coinX3),
										.coin_y_center(coinY3),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_size),
										.coin_y_back (309+10), 
										.coin_y_front (309-10), 
										.coin_x_left(392-10), 
										.coin_x_right(392+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin3_collided_purple));
										
coinCollision coin4_purpleCar(.coin_x_center(coinX4),
										.coin_y_center(coinY4),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_Size),
										.coin_y_back (245+10), 
										.coin_y_front (245-10), 
										.coin_x_left(581-10), 
										.coin_x_right(581+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin4_collided_purple));
										
coinCollision coin5_purpleCar(.coin_x_center(coinX5),
										.coin_y_center(coinY5),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_Size),
										.coin_y_back (184+10), 
										.coin_y_front (184-10), 
										.coin_x_left(135-10), 
										.coin_x_right(135+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin5_collided_purple));
										
coinCollision coin6_purpleCar(.coin_x_center(coinX6),
										.coin_y_center(coinY6),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_Size),
										.coin_y_front (311-10), 
										.coin_x_left(71-10), 
										.coin_x_right(71+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin6_collided_purple));

coinCollision coin7_purpleCar(.coin_x_center(coinX7),
										.coin_y_center(coinY7),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_Size),
										.coin_y_back (371+10), 
										.coin_y_front (371-10), 
										.coin_x_left(324-10), 
										.coin_x_right(324+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin7_collided_purple));
										
coinCollision coin8_purpleCar(.coin_x_center(coinX8),
										.coin_y_center(coinY8),
										.Car_X_Pos(BallX),
										.Car_Y_Pos(BallY),
										.Car_Size(Ball_Size),
										.coin_y_back (55+10), 
										.coin_y_front (55-10), 
										.coin_x_left(519-10), 
										.coin_x_right(519+10),
										.Reset(Reset),
										.vga_clk(vga_clk),
										.collect_coin(coin8_collided_purple));
							


background_rom background_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.q       (rom_q)
);

background_palette background_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

// introduction screen

introScreen_rom introScreen_rom (
	.clock   (vga_clk),
	.address (intro_rom_address),
	.q       (intro_rom_q)
);

introScreen_palette introScreen_palette (
	.index (intro_rom_q),
	.red   (intro_screen_palette_red),
	.green (intro_screen_palette_green),
	.blue  (intro_screen_palette_blue)
);

purpleCar_rom purpleCar_rom (
	.clock   (vga_clk),
	.address (PC_rom_address),
	.q       (PC_rom_q)
);

purpleCar_palette purpleCar_palette (
	.index (PC_rom_q),
	.red   (PC_palette_red),
	.green (PC_palette_green),
	.blue  (PC_palette_blue)
);

greenCar_rom greenCar_rom (
	.clock   (vga_clk),
	.address (GC_rom_address),
	.q       (GC_rom_q)
);

greenCar_palette greenCar_palette (
	.index (GC_rom_q),
	.red   (GC_palette_red),
	.green (GC_palette_green),
	.blue  (GC_palette_blue)
);


//man 1
pedestrian_rom state1 (
	.clock(vga_clk),
	.address(pedestrian_romAddr),
	.q(pedestrian_rom_q)
);

pedestrian_palette state_1(
	.index(pedestrian_rom_q),
	.red(pedestrian_red),
	.green(pedestrian_green),
	.blue(pedestrian_blue)
);



//purplewin
purpleWin_rom  purple_won(
	.clock(vga_clk),
	.address(PW_romAddr),
	.q(PW_rom_q)
);

purpleWin_palette purpleWon(
	.index(PW_rom_q),
	.red(PW_red),
	.green(PW_green),
	.blue(PW_blue)
);

//greenwin
greenWin_rom  green_won(
	.clock(vga_clk),
	.address(PW_romAddr),
	.q(GW_rom_q)
);

greenWin_palette greenWon(
	.index(GW_rom_q),
	.red(GW_red),
	.green(GW_green),
	.blue(GW_blue)
);

// you lose sign

youLose_rom youLose_rom (
	.clock   (vga_clk),
	.address (PW_romAddr),
	.q       (lose_rom_q)
);

youLose_palette youLose_palette (
	.index (lose_rom_q),
	.red   (lose_palette_red),
	.green (lose_palette_green),
	.blue  (lose_palette_blue)
);

// you win sign

youWin_rom youWin_rom (
	.clock   (vga_clk),
	.address (PW_romAddr),
	.q       (win_rom_q)
);

youWin_palette youWin_palette (
	.index (win_rom_q),
	.red   (win_palette_red),
	.green (win_palette_green),
	.blue  (win_palette_blue)
);


//numbers

numberSign onesPlace(.X_Center(600), .Y_Center(23), .NumberWonX(numberX), .NumberWonY(numberY), .NumberWonS(NumberWonS));
							
							
number0_rom number0_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (zero_rom_q)
);

number0_palette number0_palette (
	.index (zero_rom_q),
	.red   (zero_palette_red),
	.green (zero_palette_green),
	.blue  (zero_palette_blue)
);


number1_rom number1_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (one_rom_q)
);

number1_palette number1_palette (
	.index (one_rom_q),
	.red   (one_palette_red),
	.green (one_palette_green),
	.blue  (one_palette_blue)
);

number2_rom number2_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (two_rom_q)
);

number2_palette number2_palette (
	.index (two_rom_q),
	.red   (two_palette_red),
	.green (two_palette_green),
	.blue  (two_palette_blue)
);

number3_rom number3_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (three_rom_q)
);

number3_palette number3_palette (
	.index (three_rom_q),
	.red   (three_palette_red),
	.green (three_palette_green),
	.blue  (three_palette_blue)
);

number4_rom number4_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (four_rom_q)
);

number4_palette number4_palette (
	.index (four_rom_q),
	.red   (four_palette_red),
	.green (four_palette_green),
	.blue  (four_palette_blue)
);

number5_rom number5_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (five_rom_q)
);

number5_palette number5_palette (
	.index (five_rom_q),
	.red   (five_palette_red),
	.green (five_palette_green),
	.blue  (five_palette_blue)
);


number6_rom number6_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (six_rom_q)
);

number6_palette number6_palette (
	.index (six_rom_q),
	.red   (six_palette_red),
	.green (six_palette_green),
	.blue  (six_palette_blue)
);


number7_rom number7_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (seven_rom_q)
);

number7_palette number7_palette (
	.index (seven_rom_q),
	.red   (seven_palette_red),
	.green (seven_palette_green),
	.blue  (seven_palette_blue)
);

number8_rom number8_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (eight_rom_q)
);

number8_palette number8_palette (
	.index (eight_rom_q),
	.red   (eight_palette_red),
	.green (eight_palette_green),
	.blue  (eight_palette_blue)
);


number9_rom number9_rom (
	.clock   (vga_clk),
	.address (number_rom_address),
	.q       (nine_rom_q)
);

number9_palette number9_palette (
	.index (nine_rom_q),
	.red   (nine_palette_red),
	.green (nine_palette_green),
	.blue  (nine_palette_blue)
);





endmodule
