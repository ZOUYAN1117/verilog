module Half_Adder (
    input a,
    input b,
    output wire carry,
    output wire sum
);
  assign sum   = a ^ b;
  assign carry = a & b;
endmodule
