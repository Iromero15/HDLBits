module top_module (input x, input y, output z);

    wire outA, outB;

    boxA inst1 (x, y, outA);
    boxB inst2 (x, y, outB);

    assign z = (outA & outB) ^ (outA | outB);

endmodule

module boxA (input x, input y, output z);
    assign z = (x^y) & x;
endmodule


module boxB ( input x, input y, output z );
    assign z = !(x ^ y);
endmodule
