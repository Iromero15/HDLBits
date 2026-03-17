module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter NORMAL=0, INVERTED=1;
    reg  state, next_state;

    always @(*) begin
        case (state)
            NORMAL: next_state = x ? INVERTED : NORMAL;
            INVERTED: next_state = INVERTED;
            default: next_state = NORMAL;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) state <= NORMAL;
        else state <= next_state;
    end

    assign z = (state == NORMAL) ? x : !x;

endmodule
