module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    // Señales de habilitación internas
    wire ena_mm = ena && (ss == 8'h59);
    wire ena_hh = ena && (mm == 8'h59) && (ss == 8'h59);

    // Segundos (00-59)
    count_bcd_60 seg_cnt (clk, reset, ena, ss);

    // Minutos (00-59)
    count_bcd_60 min_cnt (clk, reset, ena_mm, mm);

    // Horas (01-12) y AM/PM
    reg [7:0] hh_reg;
    assign hh = hh_reg;

    always @(posedge clk) begin
        if (reset) begin
            hh_reg <= 8'h12; // Reset a las 12
            pm <= 1'b0;      // AM
        end else if (ena_hh) begin
            // Lógica de horas (BCD 01-12)
            if (hh_reg == 8'h12) hh_reg <= 8'h01;
            else if (hh_reg == 8'h09) hh_reg <= 8'h10;
            else hh_reg <= hh_reg + 1'b1;

            // El PM cambia cuando pasamos de las 11:59:59 a las 12:00:00
            if (hh_reg == 8'h11) pm <= ~pm;
        end
    end

endmodule

// Submódulo para contar de 00 a 59 en BCD
module count_bcd_60 (
    input clk,
    input reset,
    input ena,
    output [7:0] q
);
    reg [3:0] q_low, q_high;
    assign q = {q_high, q_low};

    always @(posedge clk) begin
        if (reset) begin
            q_low <= 4'd0;
            q_high <= 4'd0;
        end else if (ena) begin
            if (q_low == 4'd9) begin
                q_low <= 4'd0;
                if (q_high == 4'd5) q_high <= 4'd0;
                else q_high <= q_high + 1'b1;
            end else begin
                q_low <= q_low + 1'b1;
            end
        end
    end
endmodule