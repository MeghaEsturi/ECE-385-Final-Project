module timerFSM (input logic Clk, Reset, Execute,
                output logic );

);

enum logic [4:0] {RESET, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN
                EIGHT, NINE, TEN, ELEVEN, TWELVE, THIRTEEN, FOURTEEN,
                FIFTEEN, SIXTEEN, SEVENTEEN, EIGHTEEN, NINETEEN, TWENTY,
                TWENTYONE, TWENTYTWO, TWENTYTHREE, TWENTYFOUR, TWENTYFIVE,
                TWENTYSIX, TWENTYSEVEN, TWENTYEIGHT, TWENTYNINE, THIRTY, HOLD }

logic [31:0] delay_counter;

always_ff @ (posedge Clk)
begin
    if (Reset)
        curr_state <= RESET;
    else
        curr_state <= next_state;
end

always_ff @ (posedge Clk)
begin
    next_state  <= curr_state;
    unique case (curr_state)

        RESET: if (~Execute)
                begin
                next_state <= ONE;
                delay_counter <= 0;
                end


        ONE: if (delay_counter ==  50000)
                next_state <= TWO;
             else
                delay_counter <= delay_counter + 1;

        TWO: if (delay_counter ==  100000)
                next_state <= THREE;
             else
                delay_counter <= delay_counter + 1;

        THREE: if (delay_counter ==  150000)
                next_state <= FOUR;
             else
                delay_counter <= delay_counter + 1;

        FOUR: if (delay_counter ==  200000)
                next_state <= FIVE;
             else
                delay_counter <= delay_counter + 1;

        FIVE: if (delay_counter ==  250000)
                next_state <= SIX;
             else
                delay_counter <= delay_counter + 1;

        SIX: if (delay_counter ==  300000)
                next_state <= SEVEN;
             else
                delay_counter <= delay_counter + 1;

        SEVEN: if (delay_counter ==  350000)
                next_state <= EIGHT;
             else
                delay_counter <= delay_counter + 1;

        EIGHT: if (delay_counter ==  400000)
                next_state <= NINE;
             else
                delay_counter <= delay_counter + 1;

        NINE: if (delay_counter ==  450000)
                next_state <= TEN;
             else
                delay_counter <= delay_counter + 1;

        TEN: if (delay_counter ==  500000)
                next_state <= ELEVEN;
             else
                delay_counter <= delay_counter + 1;

        ELEVEN: if (delay_counter ==  550000)
                next_state <= TWELVE;
             else
                delay_counter <= delay_counter + 1;

        TWELVE: if (delay_counter ==  600000)
                next_state <= THIRTEEN;
             else
                delay_counter <= delay_counter + 1;

        THIRTEEN: if (delay_counter ==  650000)
                next_state <= FOURTEEN;
             else
                delay_counter <= delay_counter + 1;

        FOURTEEN: if (delay_counter ==  700000)
                next_state <= FIFTEEN;
             else
                delay_counter <= delay_counter + 1;

        FIFTEEN: if (delay_counter ==  750000)
                next_state <= SIXTEEN;
             else
                delay_counter <= delay_counter + 1;

        SIXTEEN: if (delay_counter ==  800000)
                next_state <= SEVENTEEN;
             else
                delay_counter <= delay_counter + 1;

        SEVENTEEN: if (delay_counter ==  850000)
                next_state <= EIGHTEEN;
             else
                delay_counter <= delay_counter + 1;

        EIGHTEEN: if (delay_counter ==  900000)
                next_state <= NINETEEN;
             else
                delay_counter <= delay_counter + 1;

        NINETEEN: if (delay_counter ==  950000)
                next_state <= TWENTY;
             else
                delay_counter <= delay_counter + 1;

        TWENTY: if (delay_counter ==  1000000)
                next_state <= TWENTYONE;
             else
                delay_counter <= delay_counter + 1;

        TWENTYONE: if (delay_counter ==  1050000)
                next_state <= TWENTYTWO;
             else
                delay_counter <= delay_counter + 1;

        TWENTYTWO: if (delay_counter ==  1100000)
                next_state <= TWENTYTHREE;
             else
                delay_counter <= delay_counter + 1;

        TWENTYTHREE: if (delay_counter ==  1150000)
                next_state <= TWENTYFOUR;
             else
                delay_counter <= delay_counter + 1;

        TWENTYFOUR: if (delay_counter ==  1200000)
                next_state <= TWENTYFIVE;
             else
                delay_counter <= delay_counter + 1;

        TWENTYFIVE: if (delay_counter ==  1250000)
                next_state <= TWENTYSIX;
             else
                delay_counter <= delay_counter + 1;

        TWENTYSIX: if (delay_counter ==  1300000)
                next_state <= TWENTYSEVEN;
             else
                delay_counter <= delay_counter + 1;

        TWENTYSEVEN: if (delay_counter ==  1350000)
                next_state <= TWENTYEIGHT;
             else
                delay_counter <= delay_counter + 1;

        TWENTYEIGHT: if (delay_counter ==  1400000)
                next_state <= TWENTYNINE;
             else
                delay_counter <= delay_counter + 1;

        TWENTYNINE: if (delay_counter ==  1450000)
                next_state <= THIRTY;
             else
                delay_counter <= delay_counter + 1;

        THIRTY: if (delay_counter ==  1500000)
                next_state <= HOLD;
             else
                delay_counter <= delay_counter + 1;

        HOLD: if (~Reset)
                next_state <= RESET;

    endcase

    case (curr_state)
        RESET : ;

        HOLD : ;
        
        ONE : begin
            one = 1;
            two = 0;
            three = 0;
            four = 0;
            five = 0;
            six = 0;
            seven = 0;
            eight = 0;
            nine = 0;
            end

        TWO : begin
            one = 0;
            two = 1;
            three = 0;
            four = 0;
            five = 0;
            six = 0;
            seven = 0;
            eight = 0;
            nine = 0;
            end

    endcase 

endmodule
