module Adder #(
    parameter BITWIDTH = 4,
    parameter LSB = 0
) (
    input  wire [(LSB + BITWIDTH - 1):LSB] a,
    input  wire [(LSB + BITWIDTH - 1):LSB] b,
    output wire [(LSB + BITWIDTH - 1):LSB] c
);

  assign c = a + b;

endmodule
