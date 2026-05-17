module full_adder (
    input  a,
    input  b,
    input  cin,
    output s,
    output cout
);

  // 计算本位和
  assign s = a ^ b ^ cin;
  // 计算本级进位
  assign cout = (a & b) | (cin & (a ^ b));

endmodule
