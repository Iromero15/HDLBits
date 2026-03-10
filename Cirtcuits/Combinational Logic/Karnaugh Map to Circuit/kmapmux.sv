module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Mapeamos cada columna del K-map a una entrada del MUX
    assign mux_in[0] = c | d;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = ~d;
    assign mux_in[3] = c & d;

endmodule