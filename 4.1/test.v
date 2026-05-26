module test (
    input  clk,
    input  reset,
    output D0,
    output D1,
    output D2
);
  reg [2:0] count;

  // 输出赋值
  assign D0 = count[0];
  assign D1 = count[1];
  assign D2 = count[2];

  // 带有同步高电平复位的3位格雷码(Gray Code)计数器
  always @(posedge clk) begin
    if (reset) begin
      count <= 3'b000;
    end else begin
      case (count)
        3'b000:  count <= 3'b001;
        3'b001:  count <= 3'b011;
        3'b011:  count <= 3'b010;
        3'b010:  count <= 3'b110;
        3'b110:  count <= 3'b111;
        3'b111:  count <= 3'b101;
        3'b101:  count <= 3'b100;
        3'b100:  count <= 3'b000;
        default: count <= 3'b000;
      endcase
    end
  end
endmodule
