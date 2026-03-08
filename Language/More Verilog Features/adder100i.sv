module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : ripple_adder
            if (i == 0) begin
                // El primero recibe el cin externo
                fadd inst (a[i], b[i], cin, sum[i], cout[i]);
            end else begin
                // Los demás reciben el cout del anterior como su cin
                fadd inst (a[i], b[i], cout[i-1], sum[i], cout[i]);
            end
        end
    endgenerate

endmodule

// Módulo sumador completo (Full Adder)
module fadd (input a, input b, input cin, output sum, output cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule