module add (
    input wire [3:0] a,
    input wire [3:0] b,
    output reg [3:0] sum,
    output reg overflow
);
  localparam EXT_NUM = 4;
  reg [EXT_NUM:0] ext_a, ext_b, ext_sum;
  always @(a or b) begin
    ext_a = {a[3], a};
    ext_b = {b[3], b};
    ext_sum = ext_a + ext_b;
    sum = ext_sum[3:0];
    overflow = (ext_sum[4] ^ ext_sum[3]) ? 1'b1 : 1'b0;
  end
endmodule
