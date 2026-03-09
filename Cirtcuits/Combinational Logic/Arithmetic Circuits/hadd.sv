module top_module( 
    input a, b,
    output cout, sum );

    fadd inst (a, b, 1'b0, sum, cout);


endmodule


module fadd (input a, input b, input cin, output sum, output cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule