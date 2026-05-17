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
    // 时刻 0
    sel1 = 1;
    sel0 = 1;
    d = 1;
    c = 1;
    b = 1;
    a = 0;
    // 时刻 1
    #1 sel1 = 1;
    sel0 = 0;
    d = 1;
    c = 1;
    b = 0;
    a = 1;
    // 时刻 2
    #1 sel1 = 0;
    sel0 = 1;
    d = 0;
    c = 1;
    b = 0;
    a = 1;
    // 时刻 3
    #1 sel1 = 0;
    sel0 = 0;
    d = 1;
    c = 0;
    b = 1;
    a = 1;
    // 时刻 4
    #1 sel1 = 1;
    sel0 = 1;
    d = 1;
    c = 0;
    b = 1;
    a = 0;
    // 时刻 5
    #1 sel1 = 1;
    sel0 = 0;
    d = 0;
    c = 0;
    b = 0;
    a = 1;
    // 时刻 6
    #1 sel1 = 1;
    sel0 = 1;
    d = 1;
    c = 1;
    b = 1;
    a = 0;
    // 时刻 7
    #1 sel1 = 0;
    sel0 = 1;
    d = 1;
    c = 1;
    b = 0;
    a = 0;
    // 时刻 8
    #1 sel1 = 0;
    sel0 = 1;
    d = 0;
    c = 0;
    b = 0;
    a = 0;
    #1 $finish;
  end
endmodule
