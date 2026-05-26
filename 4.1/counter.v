module counter (
    input clk,
    input rstn,
    input updown,
    output reg C,
    output reg [7:0] Q
);
  always @(negedge clk, negedge rstn) begin
    if (!rstn) begin
      Q <= 8'b0;
      C <= 1'b0;
    end else if (updown) begin
      {C, Q} <= {1'b0, Q} + 1'b1; // 上计数，从255加1溢出到0时，最高位进位存入C（持续1个周期）
    end else begin
      Q <= Q - 1'b1;  // 下计数
      C <= 1'b0;  // 根据要求，其余时为低电平
    end
  end
endmodule
