module top_module (
    input [4:1] x, 
    output f 
);

    // Implementación de la suma de productos (SOP)
    assign f = (~x[2] & ~x[4]) | (~x[1] & x[3]) | (x[2] & x[3] & x[4]);

endmodule