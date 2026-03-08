// (0 ? 3 : 5)     // This is 5 because the condition is false.
// (sel ? b : a)   // A 2-to-1 multiplexer between a and b selected by sel.

// always @(posedge clk)         // A T-flip-flop.
//   q <= toggle ? ~q : q;

// always @(*)                   // State transition logic for a one-input FSM
//   case (state)
//     A: next = w ? B : A;
//     B: next = w ? A : B;
//   endcase

// assign out = ena ? q : 1'bz;  // A tri-state buffer

// ((sel[1:0] == 2'h0) ? a :     // A 3-to-1 mux
//  (sel[1:0] == 2'h1) ? b :
//                       c )


module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] intermediate_result1;
    wire [7:0] intermediate_result2;
    assign intermediate_result1 = (a < b)? a: b;
    assign intermediate_result2 = (c < d)? c: d;
    assign min = (intermediate_result1 < intermediate_result2)? intermediate_result1 : intermediate_result2;

endmodule
