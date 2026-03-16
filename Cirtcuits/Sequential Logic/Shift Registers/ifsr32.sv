module top_module(
    input clk,
    input reset,    // Reset sincrónico a 32'h1
    output reg [31:0] q
); 

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            // El bit q[0] es la realimentación (feedback)
            // Taps en 32, 22, 2, 1 (índices 31, 21, 1, 0)
            q <= { q[0],                         // Tap 32 (q[31] recibe q[0])
                   q[31:23],                     // Bits intermedios (30 a 22)
                   q[22] ^ q[0],                 // Tap 22 (q[21])
                   q[21:3],                      // Bits intermedios (20 a 2)
                   q[2] ^ q[0],                  // Tap 2 (q[1])
                   q[1] ^ q[0]                   // Tap 1 (q[0])
                 };
        end
    end

endmodule