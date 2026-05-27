module shifter_32 (
    input      [31:0] data_in,    // 数据输入
    input      [ 4:0] shift_bit,  // 移位位数
    input             clk,        // 时钟信号
    input             rst_n,      // 异步复位，低电平有效
    input      [ 1:0] mode,       // 模式选择：00保持，01左移，10右移，11并行输入
    input             en,         // 使能信号，高电平有效
    output reg [31:0] data_out    // 数据输出
);

  reg [31:0] d0, d1, d2, d3, d4;
  reg [1:0] m0, m1, m2, m3, m4;
  reg [4:0] s0, s1, s2, s3, s4;

  always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      // 异步置零
      d0 <= 32'd0;
      d1 <= 32'd0;
      d2 <= 32'd0;
      d3 <= 32'd0;
      d4 <= 32'd0;
      m0 <= 2'd0;
      m1 <= 2'd0;
      m2 <= 2'd0;
      m3 <= 2'd0;
      m4 <= 2'd0;
      s0 <= 5'd0;
      s1 <= 5'd0;
      s2 <= 5'd0;
      s3 <= 5'd0;
      s4 <= 5'd0;
      data_out <= 32'd0;
    end else if (en) begin
      m0 <= mode;
      s0 <= shift_bit;
      if (mode == 2'b11) d0 <= data_in;
      else d0 <= d0;
      //处理 1 位移位
      m1 <= m0;
      s1 <= s0;
      if (m0 == 2'b00 || m0 == 2'b11) d1 <= d0;
      else if (m0 == 2'b01) d1 <= s0[0] ? {d0[30:0], d0[31]} : d0;  // 循环左移 1 位
      else if (m0 == 2'b10) d1 <= s0[0] ? {d0[0], d0[31:1]} : d0;  // 循环右移 1 位
      //处理 2 位移位
      m2 <= m1;
      s2 <= s1;
      if (m1 == 2'b11 || m1 == 2'b00) d2 <= d1;
      else if (m1 == 2'b01) d2 <= s1[1] ? {d1[29:0], d1[31:30]} : d1;  // 循环左移 2 位
      else if (m1 == 2'b10) d2 <= s1[1] ? {d1[1:0], d1[31:2]} : d1;  // 循环右移 2 位
      //处理 4 位移位
      m3 <= m2;
      s3 <= s2;
      if (m2 == 2'b11 || m2 == 2'b00) d3 <= d2;
      else if (m2 == 2'b01) d3 <= s2[2] ? {d2[27:0], d2[31:28]} : d2;  // 循环左移 4 位
      else if (m2 == 2'b10) d3 <= s2[2] ? {d2[3:0], d2[31:4]} : d2;  // 循环右移 4 位
      //处理 8 位移位
      m4 <= m3;
      s4 <= s3;
      if (m3 == 2'b11 || m3 == 2'b00) d4 <= d3;
      else if (m3 == 2'b01) d4 <= s3[3] ? {d3[23:0], d3[31:24]} : d3;  // 循环左移 8 位
      else if (m3 == 2'b10) d4 <= s3[3] ? {d3[7:0], d3[31:8]} : d3;  // 循环右移 8 位
      //处理 16 位移位
      if (m4 == 2'b11 || m4 == 2'b00) data_out <= d4;
      else data_out <= s4[4] ? {d4[15:0], d4[31:16]} : d4;
    end
  end
endmodule
