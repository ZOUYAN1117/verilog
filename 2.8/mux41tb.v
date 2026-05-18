module mux21 (
    input  wire data0,
    input  wire data1,
    input  wire sel,
    output wire out
);
  assign out = sel ? data1 : data0;
endmodule

module mux41 (
    input  a,
    input  b,
    input  c,
    input  d,
    input  sel0,
    input  sel1,
    output out
);

  // 定义内部连线，用于连接前级 mux21 的输出到后级的输入
  wire w0;
  wire w1;

  // 当 sel0 = 0 时，将面临 c 和 d 的选择（由 sel1 决定）
  mux21 u0 (
      .data0(d),     // 数据0连入 d
      .data1(c),     // 数据1连入 c
      .sel  (sel1),  // 控制信号连入 sel1
      .out  (w0)     // 结果输出到连线 w0
  );

  // 当 sel0 = 1 时，将面临 a 和 b 的选择（由 sel1 决定）
  mux21 u1 (
      .data0(b),     // 数据0连入 b
      .data1(a),     // 数据1连入 a
      .sel  (sel1),  // 控制信号连入 sel1
      .out  (w1)     // 结果输出到连线 w1
  );

  // 最终级，由 sel0 在上述两组之间做总决策
  mux21 u2 (
      .data0(w0),    // 数据0来源于 u0 产生的候选 (c或d)
      .data1(w1),    // 数据1来源于 u1 产生的候选 (a或b)
      .sel  (sel0),  // 控制信号连入 sel0
      .out  (out)    // 把最总结果连到最后输出上
  );

endmodule

`timescale 1ns / 100ps
module mux41_tb ();
  reg a, b, c, d;
  reg sel0, sel1;
  wire out;

  // 例化四路选择器
  mux41 u_mux41 (
      .a(a),
      .b(b),
      .c(c),
      .d(d),
      .sel0(sel0),
      .sel1(sel1),
      .out(out)
  );

  // 产生激励信号
  initial begin
    $dumpfile("mux41.vcd");  // 创建波形文件
    $dumpvars(0, mux41_tb);  // 记录测试环境下的所有信号
    // 时刻 0
    sel1 = 1;
    sel0 = 1;
    d = 1;
    c = 1;
    b = 1;
    a = 0;
    // 时刻 1
    #1;
    sel1 = 1;
    sel0 = 0;
    d = 1;
    c = 1;
    b = 0;
    a = 1;
    // 时刻 2
    #1;
    sel1 = 0;
    sel0 = 1;
    d = 0;
    c = 1;
    b = 0;
    a = 1;
    // 时刻 3
    #1;
    sel1 = 0;
    sel0 = 0;
    d = 1;
    c = 0;
    b = 1;
    a = 1;
    // 时刻 4
    #1;
    sel1 = 1;
    sel0 = 1;
    d = 1;
    c = 0;
    b = 1;
    a = 0;
    // 时刻 5
    #1;
    sel1 = 1;
    sel0 = 0;
    d = 0;
    c = 0;
    b = 0;
    a = 1;
    // 时刻 6
    #1;
    sel1 = 1;
    sel0 = 1;
    d = 1;
    c = 1;
    b = 1;
    a = 0;
    // 时刻 7
    #1;
    sel1 = 0;
    sel0 = 1;
    d = 1;
    c = 1;
    b = 0;
    a = 0;
    // 时刻 8
    #1;
    sel1 = 0;
    sel0 = 1;
    d = 0;
    c = 0;
    b = 0;
    a = 0;
    #1 $finish;
  end
endmodule
