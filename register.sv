module register (input  logic Clk, Reset, Load,
              input  logic [4:0]  D,
              output logic [4:0]  Data_Out);
				  
    always_ff @ (posedge Clk)
    begin
	 	 if (Reset)
			  Data_Out <= 5'd30;
		 else if (Load)
			  Data_Out <= D;
    end
	
endmodule
