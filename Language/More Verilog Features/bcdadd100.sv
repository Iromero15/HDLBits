module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [99:0] w_cout;
    
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : ripple_adder
            if (i == 0)  begin
                // Los dígitos siguientes (i*4 + 3 : i*4)
                bcd_fadd inst (
                    .a(a[4*i+3 : 4*i]), 
                    .b(b[4*i+3 : 4*i]), 
                    .cin(cin), 
                    .cout(w_cout[i]), 
                    .sum(sum[4*i+3 : 4*i])
                );
            end
            else begin
                // Los dígitos siguientes (i*4 + 3 : i*4)
                bcd_fadd inst (
                    .a(a[4*i+3 : 4*i]), 
                    .b(b[4*i+3 : 4*i]), 
                    .cin(w_cout[i-1]), 
                    .cout(w_cout[i]), 
                    .sum(sum[4*i+3 : 4*i])
                );
            end

        end
    endgenerate
    assign cout = w_cout[99];
endmodule
