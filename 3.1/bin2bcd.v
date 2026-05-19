module bin2bcd #(
    parameter BIN_WIDTH = 8,
    parameter BCD_CNT   = 3
) (
    input [BIN_WIDTH-1:0] bin_code,
    output reg [BCD_CNT*4-1:0] bcd_code
);
  integer i, j;
  always @(*) begin
    bcd_code = 0;
    for (i = BIN_WIDTH - 1; i >= 0; i = i - 1) begin
      for (j = 0; j < BCD_CNT; j = j + 1) begin
        if (bcd_code[j*4+:4] >= 5) begin
          bcd_code[j*4+:4] = bcd_code[j*4+:4] + 3;
        end
      end
      bcd_code = {bcd_code[BCD_CNT*4-2:0], bin_code[i]};
    end
  end
endmodule
