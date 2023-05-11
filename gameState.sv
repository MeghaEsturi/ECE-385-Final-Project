module gameState (input  logic Clk, Reset, Execute, 
					input logic [7:0] keycode, keycode2, 
                output logic gameState0, gameState1, gameState2);

    enum logic [2:0] {START, GAME1, GAME2}   curr_state, next_state;

    // updates flip flop, current state is the only one
    always_ff @ (posedge Clk)
    begin
        if (Reset)
            curr_state <= START;
        else
            curr_state <= next_state;
    end

    // Assign outputs based on state
    always_comb
    begin
	 
        next_state  = curr_state;

        unique case (curr_state)

				START: begin
						 if (keycode == 8'h1e || keycode2 == 8'h1e)	//1e
								next_state = GAME1;
								
						  else if (keycode == 8'h1f || keycode2 == 8'h1f)
								next_state = GAME2;				
						  end	
								
            GAME1: if (keycode == 8'h29 || keycode2 == 8'h29)
                       next_state = START;
							  
            GAME2: if (keycode == 8'h29 || keycode2 == 8'h29)
                       next_state = START;
							  
		
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   START: 
				begin
					gameState0 = 1;
					gameState1 = 0;
					gameState2 = 0;
				end
				
	   	   GAME1: 
		      begin
               gameState0 = 0;
					gameState1 = 1;
					gameState2 = 0;
		      end
				
				
				GAME2: 
		      begin
               gameState0 = 0;
					gameState1  = 0;
					gameState2 = 1;
		      end
				
	   	   default:  //default case
		      begin 
               gameState0 = 0;
					gameState1 = 0;
					gameState2= 0;
		      end
        endcase
    end

endmodule

