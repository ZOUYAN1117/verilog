module choose (
  input [3:0] in,
  output reg [3:0] out0,
  output reg [3:0] out1
);

  always @(*) begin
    out0 = {in[0], in[3:1]};
    out1 = {in[0], in[1], in[2], in[3]};
  end

endmodule //choose
