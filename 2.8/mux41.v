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
