//trafficLight.sv

module control (input  logic Clk, Reset, Execute,
                output logic GREEN_EN, RED_EN, YELLOW_EN );
					 

    enum logic [3:0] {RESET, DELAY_R1, DELAY_R2, DELAY_R3, DELAY_R4, DELAY_Y1, DELAY_Y2, DELAY_G1, DELAY_G2, DELAY_G3, DELAY_G4, RED, YELLOW, GREEN}   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= RESET;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            RESET :    if (Execute)
                       next_state = RED;
							  
            GREEN :  next_state = DELAY_G1;
				
				DELAY_G1: next_state = DELAY_G2;
				
				DELAY_G2: next_state = DELAY_G3;
				
				DELAY_G3: next_state = DELAY_G4;
				
				DELAY_G4: next_state = YELLOW;
				
				YELLOW:   next_state = DELAY_Y1;
				
				DELAY_Y1: next_state = DELAY_Y2;
				
				DELAY_Y2: next_state = RED;
				
				RED: next_state = DELAY_R1;
				
				DELAY_R1: next_state = DELAY_R2;
				
				DELAY_R2: next_state = DELAY_R3;
				
				DELAY_R3: next_state = DELAY_R4
				
            DELAY_R :  if (~Execute) 
                       next_state = GREEN;
							  else 
							  next_state = RESET;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   RESET: 
	         begin
                
		      end
				
	   	   RED: 
		      begin
                RED_EN = 1'b1;
		      end
				
				YELLOW: 
		      begin
                YELLOW_EN = 1'b1;
		      end
				
				GREEN: 
		      begin
                GREEN_EN = 1'b1;
		      end
				
				DELAY_R : ;
				
				DELAY_Y : ;
				
				DELAY_G : ;
		      begin
                
		      end
				
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
                Ld_A = 1'b0;
                Ld_B = 1'b0;
                Shift_En = 1'b1;
		      end
        endcase
    end

endmodule
