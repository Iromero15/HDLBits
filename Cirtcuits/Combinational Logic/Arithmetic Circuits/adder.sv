module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    genvar i;
    wire [3:0] cout;
    generate
        for (i = 0; i < 4; i = i + 1) begin : ripple_adder
            if (i == 0) begin
                // El primero recibe el cin externo
                fadd inst (x[i], y[i], 1'b0, sum[i], cout[i]);
            end else begin
                // Los demás reciben el cout del anterior como su cin
                fadd inst (x[i], y[i], cout[i-1], sum[i], cout[i]);
            end
        end
    endgenerate 
    assign sum[4] = cout[3];

    // assign {cout, sum} = a + b + cin;
    // siempre existio como forma

endmodule

module fadd (input a, input b, input cin, output sum, output cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule
