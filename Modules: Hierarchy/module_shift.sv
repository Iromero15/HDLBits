module top_module ( input clk, input d, output q );
    wire w1;
    wire w2;
    my_dff instance1 (clk, d, w1);
    my_dff instance2 (clk, w1, w2);
    my_dff instance3 (clk, w2, q);

endmodule
module top_module ( input clk, input d, output q );
    // Definimos los cables internos para encadenar los DFF
    wire w1;
    wire w2;

    // Instancia 1: Entra 'd' de afuera, sale 'w1'
    my_dff instance1 (
        .clk(clk), 
        .d(d), 
        .q(w1)
    );

    // Instancia 2: Entra 'w1', sale 'w2'
    my_dff instance2 (
        .clk(clk), 
        .d(w1), 
        .q(w2)
    );

    // Instancia 3: Entra 'w2', sale 'q' hacia afuera
    my_dff instance3 (
        .clk(clk), 
        .d(w2), 
        .q(q)
    );

endmodule