module top_module( 
    input [2:0] in,
    output [1:0] out 
);
    // Sumamos los bits como si fueran números decimales
    assign out = in[0] + in[1] + in[2];
    
endmodule