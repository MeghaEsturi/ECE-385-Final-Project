//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,
	 
      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk;
logic walk1, walk2, walk3, dog1, dog2, dog3;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode, keycode2;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (time_counter / 10, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (time_counter % 10, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (times_up, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (second_passed, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[3:0];
	assign VGA_B = Blue[3:0];
	assign VGA_G = Green[3:0];
	
	
	lab62_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_pio_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_pio_export({hundreds, signs, 10'b0 /*LEDR*/}),
		.keycode_export(keycode),
		.keycode2_export(keycode2)
	 );


int time_counter;
logic times_up, coin_on, ones_place_number_on, collect_coin, collect_coin2, second_passed, purpleCarWon, greenCarWon, gameState0, gameState1;
logic gameState2, in_bounds_horizontal,in_bounds_vertical, GREEN_EN, RED_EN, YELLOW_EN, GREEN_EN_W6, RED_EN_W6, YELLOW_EN_W6, GREEN_EN_FIFTH;
logic RED_EN_FIFTH, YELLOW_EN_FIFTH, GREEN_EN_FOURTH, RED_EN_FOURTH, YELLOW_EN_FOURTH;
logic [3:0] number_of_coins_collected;		
logic [10:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig, lightxsig2, lightysig2,lightxsig3, lightysig3, lightxsig4, lightysig4;
logic [10:0] carxsig, carysig, carsizesig, lightxsig, lightysig, lightsizesig, lightxsig1, lightysig1, lightysig5, lightxsig5, lightsizesig1;
logic [10:0] coinxsig, coinysig, coinsizesig, manxsig, manysig, mansize, coinx2sig, coiny2sig;//lightxsig6, lightysig6, lightxsig7, lightysig7,; 
logic [10:0] coinx3sig, coiny3sig, coinx4sig, coiny4sig, coinx5sig, coiny5sig, coinx6sig, coiny6sig, coinx7sig, coiny7sig, coinx8sig, coiny8sig;
logic [10:0] PurpleCarWon_X, PurpleCarWon_Y, PurpleCarWon_Size, GreenCarWon_X, GreenCarWon_Y, GreenCarWon_Size;
					 
gameState stateOfGame(.Clk(MAX10_CLK1_50), .Reset(Reset_h), .keycode(keycode), .keycode2(keycode2), .gameState0(gameState0), .gameState1(gameState1), .gameState2(gameState2));
					 
vga_controller vga (
				.Clk(MAX10_CLK1_50),
				.Reset(Reset_h),  // is this correct
				.hs(VGA_HS),
				.vs(VGA_VS),
				.pixel_clk(VGA_Clk),
				.blank(blank),
				.sync(sync),
				.DrawX(drawxsig),
				.DrawY(drawysig)
				);


light WrightSpringfield (.Reset(Reset_h), 
				  .frame_clk(VGA_VS),
				  .x_center(265),
				  .y_center(180),
				  .lightX(lightxsig),
				  .lightY(lightysig),
				  .lightS(lightsizesig)
				  );
				  

light2 WrightGreen (.Reset(Reset_h), 
				  .frame_clk(VGA_VS),
				  .x_center(325),
				  .y_center(180),
				  .lightX(lightxsig1),
				  .lightY(lightysig1),
				  .lightS()
				  );
				  
light3 SixthWhite (.Reset(Reset_h), 
				  .frame_clk(VGA_VS),
				  .x_center(135),
				  .y_center(245),
				  .lightX(lightxsig2),
				  .lightY(lightysig2),
				  .lightS()
				  );

light4 SixthHealey (.Reset(Reset_h), 
				  .frame_clk(VGA_VS),
				  .x_center(391),
				  .y_center(245),
				  .lightX(lightxsig3),
				  .lightY(lightysig3),
				  .lightS()
				  );

light5 FifthStoughton (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(198),
				.y_center(311),
				.lightX(lightxsig4),
				.lightY(lightysig4),
				.lightS()
				);
			
				
light5 FifthChalmers (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(581),
				.y_center(311),
				.lightX(lightxsig5),
				.lightY(lightysig5),
				.lightS()
				);
				
//light6 FifthJohn (.Reset(Reset_h), 
//				.frame_clk(VGA_VS),
//				.x_center(460),
//				.y_center(311),
//				.lightX(lightxsig6),
//				.lightY(lightysig6),
//				.lightS()
//				);
//	
//light7 FifthClark (.Reset(Reset_h), 
//				.frame_clk(VGA_VS),
//				.x_center(71),
//				.y_center(311),
//				.lightX(lightxsig7),
//				.lightY(lightysig7),
//				.lightS()
//				);
				

//green car			
car car (
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.keycode(keycode),
	.keycode2(keycode2),
	.BallX(carxsig),
	.BallY(carysig),
	.BallS(carsizesig),
	.X_CENTER(601),
	.Y_CENTER(420),
	.vga_clk(VGA_Clk),
	//.in_bounds_horizontal(in_bounds_horizontal),
	//.in_bounds_vertical(in_bounds_vertical),
	//.hitLight_wrightSpringfield(hitLight_wrightSpringfield),
	.greenCarWon(greenCarWon),
	.RED_EN(RED_EN),
	.RED_EN_W6(RED_EN_W6),
	.RED_EN_FIFTH(RED_EN_FIFTH),
	.RED_EN_FOURTH(RED_EN_FOURTH),
	.hitLight_FourthJohn(hitLight_FourthJohn)
	);
	
	logic hitLight_FourthJohn;


car2 car2(
	.Reset(Reset_h),
	.frame_clk(VGA_VS),
	.keycode(keycode),
	.keycode2(keycode2),
	.BallX(ballxsig),
	.BallY(ballysig),
	.BallS(ballsizesig),
	.X_CENTER(601),
	.Y_CENTER(431),
	.vga_clk(VGA_Clk),
	.purpleCarWon(purpleCarWon),
	.RED_EN(RED_EN),
	.RED_EN_W6(RED_EN_W6),
	.RED_EN_FIFTH(RED_EN_FIFTH),
	.RED_EN_FOURTH(RED_EN_FOURTH)
);

			 
coin SixthSpringfield (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(262),
				.y_center(243),
				.lightX(coinxsig),
				.lightY(coinysig),
				.lightS(coinsizesig)
				);
				
coin WhiteFourth (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(134),
				.y_center(372),
				.lightX(coinx2sig),
				.lightY(coiny2sig),
				.lightS()
				);

coin HealeyFifth (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(392),
				.y_center(309),
				.lightX(coinx3sig),
				.lightY(coiny3sig),
				.lightS()
				);

coin ChalmersSixth (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(581),
				.y_center(245),
				.lightX(coinx4sig),
				.lightY(coiny4sig),
				.lightS()
				);
				
coin WhiteWrite (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(135),
				.y_center(184),
				.lightX(coinx5sig),
				.lightY(coiny5sig),
				.lightS()
				);

coin ClarkFifth (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(71),
				.y_center(311),
				.lightX(coinx6sig),
				.lightY(coiny6sig),
				.lightS()
				);	
				
coin GreenFourth (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(324),
				.y_center(371),
				.lightX(coinx7sig),
				.lightY(coiny7sig),
				.lightS()
				);	

coin DanielMatthews (.Reset(Reset_h), 
				.frame_clk(VGA_VS),
				.x_center(519),
				.y_center(55),
				.lightX(coinx8sig),
				.lightY(coiny8sig),
				.lightS()
				);

control traffic (.Clk(VGA_Clk),
							  .Reset(Reset_h),
							  .Execute(KEY[1]),  //NOT SURE ABOUT THIS
							  .GREEN_EN(GREEN_EN),
							  .RED_EN(RED_EN),
							  .YELLOW_EN(YELLOW_EN)
);		 

control2 sixth (.Clk(VGA_Clk),
							  .Reset(Reset_h),
							  .Execute(KEY[1]),  //NOT SURE ABOUT THIS
							  .GREEN_EN(GREEN_EN_W6),
							  .RED_EN(RED_EN_W6),
							  .YELLOW_EN(YELLOW_EN_W6)
);		 

control3 fifth (.Clk(VGA_Clk),
							  .Reset(Reset_h),
							  .Execute(KEY[1]),  //NOT SURE ABOUT THIS
							  .GREEN_EN(GREEN_EN_FIFTH),
							  .RED_EN(RED_EN_FIFTH),
							  .YELLOW_EN(YELLOW_EN_FIFTH)
);		

control4 fourth (.Clk(VGA_Clk),
							  .Reset(Reset_h),
							  .Execute(KEY[1]),  //NOT SURE ABOUT THIS
							  .GREEN_EN(GREEN_EN_FOURTH),
							  .RED_EN(RED_EN_FOURTH),
							  .YELLOW_EN(YELLOW_EN_FOURTH)
);		 

timer thirty(.Clk(VGA_Clk), 
				 .Reset(Reset_h), 
				 .Execute(KEY[1]), 
				 .second_passed(second_passed));
				 
//				 logic [4:0] temp_count;
//				 assign time_counter = temp_count >> 1;

register timing(.Clk(VGA_Clk), 
					 .Reset(Reset_h), 
					 .Load(second_passed), 
					 .D(time_counter - 1'd1), 
					 .Data_Out(time_counter));
					 				 
					 
//always_comb
//begin
//	if (Reset_h)
//		time_counter = 5'd30;
//	else if (second_passed)
//		time_counter = time_counter - 1;
//	else if (time_counter == 0)
//		time_counter = 0;
//	else 
//		time_counter = time_counter;
//end


				 
always_comb
begin
	times_up = 0;
	if (time_counter == 0)
		times_up = 1;
	
end

background_example background(
	.coin_on(coin_on),
	.Reset(Reset_h),
	.Execute(KEY[1]),
	.gameState0(gameState0),
	.gameState1(gameState1),
	.gameState2(gameState2),
	.BallX(ballxsig),
	.BallY(ballysig),
	.DrawX(drawxsig),
	.DrawY(drawysig),
	.Ball_size(ballsizesig),
	.CAR_X(carxsig),
	.CAR_Y(carysig),
	.CAR_SIZE(carsizesig),
	.coinX(coinxsig),
   .coinY(coinysig),
	.coinX2(coinx2sig),
   .coinY2(coiny2sig),
	.coinX3(coinx3sig),
	.coinY3(coiny3sig),
	.coinX4(coinx4sig),
	.coinY4(coiny4sig),
	.coinX5(coinx5sig),
   .coinY5(coiny5sig),
	.coinX6(coinx6sig),
	.coinY6(coiny6sig),
	.coinX7(coinx7sig),
	.coinY7(coiny7sig),
	.coinX8(coinx8sig),
	.coinY8(coiny8sig),
   .coinS(coinsizesig),
	.lightX(lightxsig),
	.lightY(lightysig),
	.lightX1(lightxsig1),
	.lightY1(lightysig1),
	.lightX2(lightxsig2),
	.lightY2(lightysig2),
	.lightX3(lightxsig3),
	.lightY3(lightysig3),
	.lightX4(lightxsig4),
	.lightY4(lightysig4),
	.lightX5(lightxsig5),
	.lightY5(lightysig5),	
//	.lightX6(lightxsig6),
//	.lightY6(lightysig6),	
//	.lightX7(lightxsig7),
//	.lightY7(lightysig7),
	.manX(manxsig),
	.manY(manysig),
	.manS(mansize),
	.light_size(lightsizesig),
	.GREEN_EN(GREEN_EN),
	.RED_EN(RED_EN),
	.YELLOW_EN(YELLOW_EN),
	.GREEN_EN_W6(GREEN_EN_W6),
	.RED_EN_W6(RED_EN_W6),
	.YELLOW_EN_W6(YELLOW_EN_W6),
	.GREEN_EN_FIFTH(GREEN_EN_FIFTH),
   .RED_EN_FIFTH(RED_EN_FIFTH),
   .YELLOW_EN_FIFTH(YELLOW_EN_FIFTH),
	.GREEN_EN_FOURTH(GREEN_EN_FOURTH),
   .RED_EN_FOURTH(RED_EN_FOURTH),
   .YELLOW_EN_FOURTH(YELLOW_EN_FOURTH),
	.red(Red),
	.green(Green),
	.blue(Blue),
	.vga_clk(VGA_Clk),
	.blank(blank),
	.walk1(walk1),
	.walk2(walk2),
	.walk3(walk3),
	.purpleCarWon(purpleCarWon),
	.PurpleCarWon_X(PurpleCarWon_X),
	.PurpleCarWon_Y(PurpleCarWon_Y),
	.PurpleCarWon_Size(PurpleCarWon_Size),
	.greenCarWon(greenCarWon),
	.coin1_collided(collect_coin),
	.coin2_collided(collect_coin2),
	.times_up(times_up),
	.ones_place_number_on(ones_place_number_on),
	.number_of_coins_collected(number_of_coins_collected),
	.hit_man(hit_man),
	.hit_man2(hit_man2),
	.time_counter(time_counter)
);
 
logic [3:0] test_var;
pedestrian man_walking  (.Reset(Reset_h), 
				  .frame_clk(VGA_VS),
				  //.x_center(512),
				  //.y_center(371),
				  .manX(manxsig),
				  .manY(manysig),
				  .manS(mansize),
				  .hit_man(hit_man),
				  .hit_man2(hit_man2)
				  );

logic hit_man, hit_man2;

// IMPLEMENTED FOR GREEN CAR
pedestrianCollision man_collision(.Car_X_Pos(carxsig), 
											 .Car_Y_Pos(carysig), 
											 .Car_Size(carsizesig), 
											 .man_X_Pos(manxsig), 
											 .man_Y_Pos(manysig), 
											 .man_Size(mansize),
											 .vga_clk(VGA_Clk),
											 .hit_man(hit_man),
											 .test_var(test_var)
);

pedestrianCollision man_collision_car2(.Car_X_Pos(ballxsig), 
											 .Car_Y_Pos(ballysig), 
											 .Car_Size(ballsizesig), 
											 .man_X_Pos(manxsig), 
											 .man_Y_Pos(manysig), 
											 .man_Size(mansize),
											 .vga_clk(VGA_Clk),
											 .hit_man(hit_man2),
											 .test_var(test_var)
);
					
CarWonSign purpleCar(.CarWonX(PurpleCarWon_X), .CarWonY(PurpleCarWon_Y), .CarWonS(PurpleCarWon_Size));

CarWonSign greenCar(.CarWonX(GreenCarWon_X), .CarWonY(GreenCarWon_Y), .CarWonS(GreenCarWon_Size));



endmodule
