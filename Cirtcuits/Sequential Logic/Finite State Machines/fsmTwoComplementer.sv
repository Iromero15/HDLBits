module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter NORMAL=0, FIRST1=1, INVERTED=2;
    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            NORMAL: next_state = x ? FIRST1 : NORMAL;
            FIRST1: next_state = x ? INVERTED : FIRST1;  
            INVERTED: next_state = x ? INVERTED : FIRST1;
            default: next_state = NORMAL;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) state <= NORMAL;
        else state <= next_state;
    end

    assign z = (state == FIRST1); 

endmodule
