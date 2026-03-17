module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

    parameter START=0, BYTE1=1, BYTE2=2, BYTE3=3, BYTE4=4, BYTE5=5, BYTE6=6, BYTE7=7, BYTE8=8, STOP=9, ERROR=10, DONE=11;
    reg[4:0] state, next_state;
    reg[7:0] data;
    always @(*) begin
        case (state)
            START: next_state = in ? START : BYTE1;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = BYTE4;
            BYTE4: next_state = BYTE5;
            BYTE5: next_state = BYTE6;
            BYTE6: next_state = BYTE7;
            BYTE7: next_state = BYTE8;
            BYTE8: next_state = STOP;
            STOP: next_state = in ? DONE : ERROR;
            ERROR: next_state = in ? START : ERROR;
            DONE: next_state = in ? START : BYTE1;
            default: next_state = START;
        endcase
    end

    always @(posedge clk) begin
        case (state)
            BYTE1: data[0] = in;
            BYTE2: data[1] = in;
            BYTE3: data[2] = in;
            BYTE4: data[3] = in;
            BYTE5: data[4] = in;
            BYTE6: data[5] = in;
            BYTE7: data[6] = in;
            BYTE8: data[7] = in;
        endcase
    end


    always @(posedge clk) begin
        if (reset) state = START;
        else state = next_state;
    end
    assign done = (state == DONE);
    assign out_byte = data;

endmodule
