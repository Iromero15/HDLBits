// {5{1'b1}}           // 5'b11111 (or 5'd31 or 5'h1f)
// {2{a,b,c}}          // The same as {a,b,c,a,b,c}
// {3'd5, {2{3'd6}}}   // 9'b101_110_110. It's a concatenation of 101 with
//                     // the second vector, which is two copies of 3'b110.

module top_module (
    input [7:0] in,
    output [31:0] out );//

    assign out = { {24{in[7]}} , in };

endmodule