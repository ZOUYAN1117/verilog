module shifter_universal (
    input            clk,    //时钟信号，上升沿有效
    input            reset,  //异步置零信号，高电平有效
    input      [1:0] ctrl,
    input            Dsl,    //左移操作时，补低位
    input            Dsr,    //右移操作时，补高位
    input      [3:0] Din,
    output reg [3:0] Dout
);

  // 含有异步高电平复位的时序逻辑
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      Dout <= 4'b0000;  // 1. 异步置零
    end else begin
      case (ctrl)
        2'b00:   Dout <= Dout;  // 2. 保持原状态
        2'b01:   Dout <= {Dsr, Dout[3:1]};  // 3. 右移：Dsr补在最高位，原数据向右挤
        2'b10:   Dout <= {Dout[2:0], Dsl};  // 4. 左移：Dsl补在最低位，原数据向左挤
        2'b11:   Dout <= Din;  // 5. 同步并行置数
        default: Dout <= Dout;  // 安全起见，加上default保持状态
      endcase
    end
  end

endmodule
