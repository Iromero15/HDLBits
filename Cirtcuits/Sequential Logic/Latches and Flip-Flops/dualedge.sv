module top_module (
    input clk,
    input d,
    output q
);

    reg p, n;

    // Flip-Flop para el flanco ascendente
    always @(posedge clk) begin
        p <= d ^ n;
    end

    // Flip-Flop para el flanco descendente
    always @(negedge clk) begin
        n <= d ^ p;
    end

    // La salida es la combinación XOR de ambos
    assign q = p ^ n;

endmodule

// no se puede hacer asi ya que no permite el programa porque no existe la logica posible para hacerlo en circuito asi.


// module top_module (
//     input clk,
//     input d,
//     output q
// );

//     always @(posedge clk or negedge clk) begin
//         q = d;
//     end

// endmodule
