module clk_div #(
    parameter N = 2
) (
    input  clk,
    input  rstn,
    output clk_out
);
  reg [31:0] cnt;
  reg cnt_n, cnt_p;
  always @(posedge clk, negedge rstn) begin
    if (!rstn) cnt <= 0;
    else cnt <= (cnt == N - 1) ? 0 : cnt + 1;
  end
  always @(posedge clk, negedge rstn) begin
    if (!rstn) cnt_p <= 0;
    else cnt_p <= (cnt < (N >> 1));
  end
  always @(negedge clk, negedge rstn) begin
    if (!rstn) cnt_n <= 0;
    else cnt_n <= cnt_p;
  end
  assign clk_out = (N == 1) ? clk : (N[0] == 0) ? cnt_p : (cnt_p | cnt_n);
endmodule
