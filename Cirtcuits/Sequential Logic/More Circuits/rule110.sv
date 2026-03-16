module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 


    wire [511:0] R = {q[510:0], 1'b0}; // Desplaza a la izquierda
    wire [511:0] L = {1'b0, q[511:1]}; // Desplaza a la derecha
    always @(posedge clk) begin
        if (load) q <= data;
        else q <= (q ^ R) | (~L & R);
    end
endmodule
