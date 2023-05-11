module timer (input  logic Clk, Reset, Execute,
                output logic second_passed);

    enum logic [2:0] {RESET, START, COUNTING, ONESECOND}   curr_state, next_state;

    // Counter for the delay
    logic [31:0] delay_counter;
	 logic [31:0] counter;


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

        next_state  <= curr_state;

        unique case (curr_state)

            RESET :   if (~Execute)
							 begin
							 delay_counter <= 0;
							 counter <= 0;
                      next_state <= START;
							 end
							  
				START : begin
						  delay_counter <= 0;
						  next_state <= COUNTING;
						  end

								
				COUNTING: begin
								 if (delay_counter == 50000000) //slowed the clock down to see
								 next_state <= ONESECOND;
								 else
								 delay_counter <= delay_counter + 1;
							 end
	
							 
				ONESECOND: begin
							  if (counter < 30)
								  next_state <= START;
							  else 
								  next_state <= RESET;
							  end

        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   RESET, START, COUNTING: 
				begin
					second_passed <= 0;
				end
				
				ONESECOND: 
		      begin
                second_passed <= 1;
					 counter <= counter + 1;
		      end
				
				
	   	   default:  //default case
		      begin 
                second_passed <= 0;
		      end
        endcase
    end

endmodule
