module condition_op (
    input  [7:0] a,
    input  [7:0] b,
    input  [7:0] c,
    input  [7:0] d,
    output [7:0] min
);
  wire [7:0] temp0, temp1;
  assign temp0 = (a > b) ? b : a;
  assign temp1 = (c > d) ? d : c;
  assign min   = (temp0 > temp1) ? temp1 : temp0;
endmodule
