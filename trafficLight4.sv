module control4 (input  logic Clk, Reset, Execute,
                output logic GREEN_EN, RED_EN, YELLOW_EN);

    enum logic [4:0] {RESET, DELAY_R, DELAY_Y, DELAY_G, RED, YELLOW, GREEN, RETURN}   curr_state, next_state;

    // Counter for the delay
    logic [31:0] delay_counter;

    // updates flip flop, current state is the only one
    always_ff @ (posedge Clk)
    begin
        if (Reset)
            curr_state <= RESET;
        else
            curr_state <= next_state;
    end

    // Assign outputs based on state
    always_ff @ (posedge Clk)
    begin
//
//        RED_EN = 1'b0;
//        GREEN_EN = 1'b0;
//        YELLOW_EN = 1'b0;

        next_state  <= curr_state;

        unique case (curr_state)


            RESET :    if (~Execute)
                       next_state <= RED;

            RED :  begin
							next_state <= DELAY_R;
							delay_counter = 0;
							end

            DELAY_R: if (delay_counter ==  50000000)
                      next_state <= GREEN;
                      else
                      delay_counter <= delay_counter + 1;

            GREEN:   next_state <= DELAY_G;

            DELAY_G: if (delay_counter == 270000000)
                      next_state <= YELLOW;
                      else
                      delay_counter <= delay_counter + 1;

            YELLOW:      next_state <= DELAY_Y;

            DELAY_Y: if (delay_counter == 330000000)
                      next_state <= RETURN;
                      else
                      delay_counter <= delay_counter + 1;	
							 
				RETURN: if (Execute)
						  next_state <= RED;
						  else
                    next_state <= RESET;

        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   RESET: ;
				
	   	   RED, DELAY_R: 
		      begin
                RED_EN = 1'b1;
					 YELLOW_EN = 1'b0;
					 GREEN_EN = 1'b0;
		      end
				
				
				YELLOW, DELAY_Y: 
		      begin
                YELLOW_EN = 1'b1;
					 GREEN_EN = 1'b0;
					 RED_EN = 1'b0;
		      end
				
				GREEN, DELAY_G: 
		      begin
                GREEN_EN = 1'b1;
					 YELLOW_EN = 1'b0;
					 RED_EN = 1'b0;
		      end
				
	   	   default:  //default case
		      begin 
                GREEN_EN = 1'b0;
					 YELLOW_EN = 1'b0;
					 RED_EN = 1'b0;
		      end
        endcase
    end

endmodule
