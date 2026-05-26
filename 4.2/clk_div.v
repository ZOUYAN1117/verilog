module clk_div #(
    parameter N = 2
) (
    input  clk,
    input  rstn,
    output clk_out
);

  reg [31:0] cnt;
  reg clk_p, clk_n;

  // 1. 统一计数器 (从 0 计数到 N-1)
  always @(posedge clk, negedge rstn) begin
    if (!rstn) cnt <= 0;
    else cnt <= (cnt == N - 1) ? 0 : cnt + 1;
  end

  // 2. 上升沿生成基础分频时钟 clk_p
  // 【行业极简核心】：巧用 (cnt < N/2)
  // 如果是偶数(如4)：N/2=2，cnt为0,1时变高电平(2个周期)，天然就是完美的 50% 占空比！
  // 如果是奇数(如5)：N/2=2，cnt为0,1变高，2,3,4变低(缺了0.5个周期的高电平)。
  always @(posedge clk, negedge rstn) begin
    if (!rstn) clk_p <= 0;
    else clk_p <= (cnt < (N >> 1));  // N >> 1 等价于 N / 2
  end

  // 3. 下降沿打拍，专为奇数分频“补齐0.5个高电平”服务
  always @(negedge clk, negedge rstn) begin
    if (!rstn) clk_n <= 0;
    else clk_n <= clk_p;
  end

  // 4. 组合逻辑输出选择
  // N=1时不分频直接输出 clk
  // 偶数 (N[0]==0)天然完美，直接输出 clk_p
  // 奇数 缺半拍，利用 clk_p | clk_n 补齐这半拍
  assign clk_out = (N == 1) ? clk : (N[0] == 0) ? clk_p : (clk_p | clk_n);

endmodule
